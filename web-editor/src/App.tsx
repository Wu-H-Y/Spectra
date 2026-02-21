import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';

import { RuleEditorPage } from '@/pages/rules/RuleEditorPage';
import { RuleListPage } from '@/pages/rules/RuleListPage';

/**
 * 应用主入口组件。
 * 配置路由和全局布局。
 */
function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Navigate to="/rules" replace />} />
        <Route path="/rules" element={<RuleListPage />} />
        <Route path="/rules/new" element={<RuleEditorPage />} />
        <Route path="/rules/:id" element={<RuleEditorPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
