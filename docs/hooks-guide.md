# Hooks 使用指南

本文档描述 Spectra 项目中 Flutter Hooks 的使用模式和最佳实践。

## 概述

Spectra 使用 `flutter_hooks` 和 `hooks_riverpod` 来简化状态管理和组件生命周期处理。

## 基础 Hooks

### useState

管理组件内部状态：

```dart
class Counter extends HookConsumerWidget {
  const Counter({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = useState(0);
    
    return Column(
      children: [
        Text('Count: ${count.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### useEffect

处理副作用（类似 initState + dispose）：

```dart
class DataFetcher extends HookConsumerWidget {
  const DataFetcher({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<String?>(null);
    
    useEffect(() {
      // 组件初始化时执行
      Future<void> fetchData() async {
        final result = await api.getData();
        data.value = result;
      }
      
      fetchData();
      
      // 返回清理函数（可选）
      return () {
        // 组件销毁时执行
        api.cancelRequests();
      };
    }, []); // 空数组表示只在组件初始化时执行一次
    
    if (data.value == null) {
      return CircularProgressIndicator();
    }
    return Text(data.value!);
  }
}
```

### useMemoized

缓存计算结果：

```dart
class ExpensiveWidget extends HookConsumerWidget {
  final List<int> numbers;
  
  const ExpensiveWidget({required this.numbers, super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 只在 numbers 变化时重新计算
    final sum = useMemoized(() => numbers.reduce((a, b) => a + b), [numbers]);
    
    return Text('Sum: $sum');
  }
}
```

### useCallback

缓存回调函数：

```dart
class ItemList extends HookConsumerWidget {
  final List<Item> items;
  
  const ItemList({required this.items, super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = useState<Item?>(null);
    
    // 缓存回调，避免子组件不必要的重建
    final onSelect = useCallback((Item item) {
      selectedItem.value = item;
    }, []);
    
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemTile(
          item: items[index],
          isSelected: selectedItem.value == items[index],
          onSelect: onSelect,
        );
      },
    );
  }
}
```

### useRef

存储可变引用（不触发重建）：

```dart
class AnimationWidget extends HookConsumerWidget {
  const AnimationWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useRef(AnimationController(
      duration: Duration(seconds: 1),
      vsync: Navigator.of(context),
    ));
    
    useEffect(() {
      controller.value.forward();
      return () => controller.value.dispose();
    }, []);
    
    return AnimatedBuilder(
      animation: controller.value,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value.value,
          child: child,
        );
      },
      child: Text('Hello'),
    );
  }
}
```

## Riverpod 集成

### HookConsumerWidget

使用 Riverpod 的基础 Widget：

```dart
class UserPage extends HookConsumerWidget {
  final String userId;
  
  const UserPage({required this.userId, super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听 Provider
    final userAsync = ref.watch(userProvider(userId));
    
    // 使用 hooks 管理本地状态
    final isEditing = useState(false);
    
    return userAsync.when(
      data: (user) => isEditing.value
        ? UserEditForm(user: user)
        : UserView(user: user),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(error: err),
    );
  }
}
```

### ref.listen

响应 Provider 变化：

```dart
class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    
    // 监听登录状态变化
    ref.listen<AsyncValue>(loginProvider, (previous, next) {
      next.when(
        data: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('登录成功')),
          );
          Navigator.of(context).pop();
        },
        loading: () {},
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('登录失败: $err')),
          );
        },
      );
    });
    
    return Form(
      key: formKey,
      child: Column(
        children: [
          // 表单字段...
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref.read(loginProvider.notifier).login();
              }
            },
            child: Text('登录'),
          ),
        ],
      ),
    );
  }
}
```

## 自定义 Hooks

### 创建可复用的 Hook

```dart
// useDebouncedValue.dart
ValueNotifier<T> useDebouncedValue<T>(T value, Duration duration) {
  final debouncedValue = useState(value);
  final timer = useRef<Timer?>(null);
  
  useEffect(() {
    timer.value?.cancel();
    timer.value = Timer(duration, () {
      debouncedValue.value = value;
    });
    
    return () => timer.value?.cancel();
  }, [value]);
  
  return debouncedValue;
}

// 使用
class SearchWidget extends HookConsumerWidget {
  const SearchWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final debouncedQuery = useDebouncedValue(query.value, Duration(milliseconds: 500));
    
    // 只在 debouncedQuery 变化时触发搜索
    final results = ref.watch(searchProvider(debouncedQuery.value));
    
    return Column(
      children: [
        TextField(
          onChanged: (value) => query.value = value,
        ),
        ResultsList(results: results),
      ],
    );
  }
}
```

### useAnimation

封装动画逻辑：

```dart
AnimationController useAnimationController({
  required Duration duration,
  String? debugLabel,
}) {
  final controller = useRef<AnimationController?>(null);
  
  useEffect(() {
    return () => controller.value?.dispose();
  }, []);
  
  return useMemoized(() {
    controller.value ??= AnimationController(
      duration: duration,
      debugLabel: debugLabel,
    );
    return controller.value!;
  }, [duration, debugLabel]);
}
```

## 最佳实践

### 1. 状态分离

将本地状态和全局状态分开：

```dart
// 本地状态使用 useState
final isSelected = useState(false);

// 全局状态使用 Riverpod
final user = ref.watch(userProvider);
```

### 2. 避免过度使用 useEffect

只在需要时使用 useEffect，简单组件不需要：

```dart
// 不好的做法
useEffect(() {
  // 只是为了初始化一个简单值
  count.value = 0;
  return null;
}, []);

// 好的做法
final count = useState(0);
```

### 3. 正确使用依赖数组

```dart
// 只在 id 变化时重新获取数据
useEffect(() {
  fetchData(id);
  return null;
}, [id]); // 正确

// 错误：缺少依赖
useEffect(() {
  fetchData(id);
  return null;
}, []); // 每次都使用初始 id
```

### 4. 清理资源

在 useEffect 中返回清理函数：

```dart
useEffect(() {
  final subscription = stream.listen((event) {
    // 处理事件
  });
  
  return () => subscription.cancel(); // 清理
}, [stream]);
```

### 5. 使用 useMemoized 优化性能

```dart
// 避免在每次 build 时重新计算
final sortedItems = useMemoized(
  () => items..sort((a, b) => a.name.compareTo(b.name)),
  [items],
);
```

## 参考资料

- [flutter_hooks 官方文档](https://pub.dev/packages/flutter_hooks)
- [hooks_riverpod 官方文档](https://pub.dev/packages/hooks_riverpod)
- [React Hooks 原理](https://react.dev/reference/react)
