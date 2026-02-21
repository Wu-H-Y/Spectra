# web-editor 组件模式规范

## 组件基础

### Requirement: forwardRef 支持

所有 UI 组件必须使用 `React.forwardRef` 支持引用传递。

```typescript
const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, ...props }, ref) => {
    return <button ref={ref} className={className} {...props} />
  }
)
Button.displayName = 'Button'
```

#### Scenario: 引用访问
- **WHEN** 外部通过 `ref` 访问组件
- **THEN** 获取到正确的 DOM 元素引用

---

### Requirement: className 透传

组件必须支持 `className` prop，并与默认样式合并。

```typescript
className={cn(baseStyles, className)}
```

#### Scenario: 样式扩展
- **WHEN** 传入 `className="mt-4"`
- **THEN** 该类名追加到默认类名之后，不覆盖

---

### Requirement: displayName

所有组件必须设置 `displayName` 便于 React DevTools 调试。

#### Scenario: DevTools 显示
- **WHEN** 在 React DevTools 中查看组件树
- **THEN** 显示有意义的组件名称而非 "Anonymous"

---

## 变体系统

### Requirement: cva 变体定义

有样式变体需求的组件必须使用 `cva` (class-variance-authority)。

```typescript
const buttonVariants = cva(
  'inline-flex items-center justify-center rounded-md',
  {
    variants: {
      variant: {
        default: 'bg-primary text-primary-foreground',
        destructive: 'bg-destructive text-destructive-foreground',
        outline: 'border border-input bg-background',
      },
      size: {
        default: 'h-10 px-4',
        sm: 'h-9 px-3',
        lg: 'h-11 px-8',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  }
)
```

#### Scenario: 变体选择
- **WHEN** 使用 `<Button variant="destructive" />`
- **THEN** 应用 destructive 变体的样式类

#### Scenario: 默认变体
- **WHEN** 不指定 variant prop
- **THEN** 应用 defaultVariants 定义的默认样式

---

### Requirement: 变体类型导出

导出变体类型供外部使用。

```typescript
export type ButtonVariantProps = VariantProps<typeof buttonVariants>
```

#### Scenario: 类型安全
- **WHEN** 使用 Button 组件
- **THEN** TypeScript 提供变体选项的自动补全

---

## 可访问性

### Requirement: ARIA 属性

交互组件必须包含必要的 ARIA 属性。

#### Scenario: 按钮无障碍
- **WHEN** 渲染 Button 组件
- **THEN** 支持通过 aria-label、aria-describedby 等 prop 传递 ARIA 属性

#### Scenario: 表单关联
- **WHEN** Input 组件与 Label 关联
- **THEN** 通过 id 和 htmlFor 正确关联

---

### Requirement: 键盘导航

可交互组件必须支持键盘操作。

#### Scenario: Tab 导航
- **WHEN** 用户按 Tab 键
- **THEN** 焦点按预期顺序移动

#### Scenario: Enter/Space 激活
- **WHEN** 焦点在按钮上按 Enter 或 Space
- **THEN** 触发 onClick 事件

---

## 组合模式

### Requirement: Slot 模式

支持 `asChild` prop 实现渲染委托。

```typescript
const Comp = asChild ? Slot : 'button'
```

#### Scenario: 渲染委托
- **WHEN** 使用 `<Button asChild><Link to="/path" /></Button>`
- **THEN** Link 组件继承 Button 的样式

---

### Requirement: 复合组件

相关组件作为命名导出组合。

```typescript
export const Card = { Root, Header, Title, Description, Content, Footer }
// 或
export { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter }
```

#### Scenario: 组件发现
- **WHEN** 开发者输入 `import { Card`
- **THEN** IDE 自动补全所有 Card 相关组件
