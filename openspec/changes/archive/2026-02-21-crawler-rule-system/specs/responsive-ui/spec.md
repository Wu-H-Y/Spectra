# Responsive UI

## ADDED Requirements

### Requirement: Sizer 包集成

系统 SHALL 集成 sizer 包实现响应式布局：

- 使用 Sizer widget 包裹 MaterialApp
- 配置设备类型断点 (mobile ≤ 599px, tablet ≤ 1024px)
- 支持百分比尺寸单位 (.w, .h)
- 支持响应式字体 (.sp, .dp)

#### Scenario: Sizer 初始化

- **WHEN** 应用启动
- **THEN** Sizer widget SHALL 包裹 MaterialApp 并配置断点

```dart
Sizer(
  maxMobileWidth: 599,
  maxTabletWidth: 1024,
  builder: (context, orientation, screenType) {
    return MaterialApp(...);
  },
)
```

---

### Requirement: 设备类型检测

系统 SHALL 支持设备类型检测：

- `ScreenType.mobile`: 宽度 ≤ 599px
- `ScreenType.tablet`: 600px < 宽度 ≤ 1024px
- `ScreenType.desktop`: 宽度 > 1024px

#### Scenario: 设备类型判断

- **WHEN** 需要根据设备类型调整布局
- **THEN** 系统 SHALL 使用 `Device.screenType` 进行判断

```dart
if (Device.screenType == ScreenType.mobile) {
  return MobileLayout();
} else if (Device.screenType == ScreenType.tablet) {
  return TabletLayout();
} else {
  return DesktopLayout();
}
```

---

### Requirement: 响应式尺寸单位

系统 SHALL 使用 sizer 的响应式尺寸单位：

| 单位 | 用途 | 计算方式 |
|------|------|----------|
| `.w` | 宽度百分比 | 屏幕宽度 × 百分比 |
| `.h` | 高度百分比 | 屏幕高度 × 百分比 |
| `.sp` | 响应式字体 | 基于像素密度和屏幕比例 |
| `.dp` | 响应式 dp | 基于像素密度 |
| `.sw` | SafeArea 宽度 | 去除安全区域后的宽度 |
| `.sh` | SafeArea 高度 | 去除安全区域后的高度 |

#### Scenario: 容器尺寸

- **WHEN** 创建容器或组件
- **THEN** 系统 SHALL 使用百分比单位而非固定像素

```dart
Container(
  width: 80.w,      // 屏幕宽度的 80%
  height: 20.h,     // 屏幕高度的 20%
  padding: EdgeInsets.all(4.w),  // 响应式内边距
)
```

#### Scenario: 字体大小

- **WHEN** 设置文本字体大小
- **THEN** 系统 SHALL 使用 .sp 或 .dp 单位

```dart
Text(
  '标题',
  style: TextStyle(fontSize: 16.sp),
)
```

---

### Requirement: 移动端布局

系统 SHALL 为移动端 (width ≤ 599px) 提供专用布局：

- 单列内容布局
- 底部导航栏 (BottomNavigationBar)
- 全宽卡片和列表
- 抽屉式菜单 (Drawer)
- 悬浮操作按钮 (FAB)

#### Scenario: 移动端导航

- **WHEN** 应用运行在移动设备上
- **THEN** 系统 SHALL 使用底部导航栏

#### Scenario: 移动端列表

- **WHEN** 显示内容列表
- **THEN** 系统 SHALL 使用单列全宽布局

---

### Requirement: 平板/桌面端布局

系统 SHALL 为平板和桌面端 (width > 600px) 提供优化布局：

- 双列或多列布局
- 侧边导航栏 (NavigationRail / NavigationDrawer)
- 网格卡片布局
- 主从式界面 (Master-Detail)
- 宽屏优化间距

#### Scenario: 平板导航

- **WHEN** 应用运行在平板设备上
- **THEN** 系统 SHALL 使用侧边导航栏

#### Scenario: 平板列表

- **WHEN** 显示内容列表
- **THEN** 系统 SHALL 使用网格布局

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: Device.screenType == ScreenType.mobile ? 1 : 2,
    mainAxisSpacing: 2.h,
    crossAxisSpacing: 2.w,
    childAspectRatio: 0.7,
  ),
  itemBuilder: (context, index) => ContentCard(item: items[index]),
)
```

---

### Requirement: 屏幕方向适配

系统 SHALL 支持屏幕方向变化：

- 检测 `Device.orientation` 变化
- 竖屏和横屏布局切换
- 保持 UI 状态

#### Scenario: 方向变化

- **WHEN** 设备旋转
- **THEN** 系统 SHALL 自动重新计算布局

```dart
Device.orientation == Orientation.portrait
  ? PortraitLayout()
  : LandscapeLayout();
```

---

### Requirement: 页面预览响应式

页面预览功能 SHALL 支持响应式设计：

- 移动端：全屏预览
- 平板/桌面端：侧边面板或弹窗预览
- 预览窗口尺寸自适应

#### Scenario: 移动端预览

- **WHEN** 在移动设备上打开预览
- **THEN** 系统 SHALL 使用全屏 WebView

#### Scenario: 桌面端预览

- **WHEN** 在桌面设备上打开预览
- **THEN** 系统 SHALL 显示为侧边面板

---

### Requirement: Web 编辑器响应式

Web 编辑器 SHALL 使用 Tailwind CSS 响应式断点：

- `mobile`: max-width 599px
- `tablet`: min-width 600px
- `desktop`: min-width 1024px

#### Scenario: 编辑器布局切换

- **WHEN** 浏览器窗口调整大小
- **THEN** 编辑器 SHALL 根据断点切换布局

```tsx
<div className="flex flex-col tablet:flex-row">
  <aside className="w-full tablet:w-64">侧边栏</aside>
  <main className="flex-1">主内容</main>
</div>
```

---

### Requirement: 响应式间距

系统 SHALL 使用响应式间距：

- 使用百分比单位定义间距
- 不同设备类型使用不同基础间距
- 边距和内边距自适应

#### Scenario: 卡片间距

- **WHEN** 设置卡片之间的间距
- **THEN** 系统 SHALL 使用响应式间距

```dart
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: Device.screenType == ScreenType.mobile ? 4.w : 2.w,
    vertical: 2.h,
  ),
  child: ContentCard(),
)
```

---

### Requirement: 响应式图标和按钮

系统 SHALL 使用响应式图标和按钮尺寸：

- 图标大小根据设备类型调整
- 按钮尺寸使用响应式单位
- 触摸目标在移动端足够大 (≥ 48dp)

#### Scenario: 图标尺寸

- **WHEN** 显示图标
- **THEN** 系统 SHALL 根据设备类型调整大小

```dart
Icon(
  Icons.menu,
  size: Device.screenType == ScreenType.mobile ? 24.sp : 20.sp,
)
```

#### Scenario: 按钮尺寸

- **WHEN** 创建按钮
- **THEN** 移动端触摸目标 SHALL ≥ 48dp

```dart
IconButton(
  iconSize: 24.sp,
  constraints: BoxConstraints(
    minWidth: 12.w,  // 响应式最小宽度
    minHeight: 12.w,
  ),
  onPressed: () {},
  icon: Icon(Icons.add),
)
```
