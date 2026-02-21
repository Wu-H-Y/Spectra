import { lazy, Suspense } from 'react';
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';

// 路由级代码分割
const RuleListPage = lazy(() =>
  import('@/pages/rules/RuleListPage').then((m) => ({
    default: m.RuleListPage,
  })),
);
const RuleEditorPage = lazy(() =>
  import('@/pages/rules/RuleEditorPage').then((m) => ({
    default: m.RuleEditorPage,
  })),
);

/**
 * 页面加载占位符
 */
function PageLoader() {
  return (
    <div className="flex items-center justify-center min-h-100">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
    </div>
  );
}

/**
 * 应用主入口组件。
 * 配置路由和全局布局。
 */
function App() {
  return (
    <BrowserRouter>
      <Suspense fallback={<PageLoader />}>
        <Routes>
          <Route path="/" element={<Navigate to="/rules" replace />} />
          <Route path="/rules" element={<RuleListPage />} />
          <Route path="/rules/new" element={<RuleEditorPage />} />
          <Route path="/rules/:id" element={<RuleEditorPage />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}

export default App;
