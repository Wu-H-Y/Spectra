import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

const resources = {
  en: {
    translation: {
      // General
      appTitle: 'Crawler Rule Editor',
      save: 'Save',
      cancel: 'Cancel',
      delete: 'Delete',
      edit: 'Edit',
      create: 'Create',
      import: 'Import',
      export: 'Export',
      exportAll: 'Export All',
      newRule: 'New Rule',
      retry: 'Retry',
      author: 'Author',
      noDescription: 'No description',
      searchRules: 'Search rules...',
      noRules: 'No rules yet. Create your first rule to get started.',
      confirmDelete: 'Delete Rule?',
      confirmDeleteDescription:
        'This action cannot be undone. This will permanently delete the rule.',
      ruleEditorDescription: 'Manage your crawler rules for content extraction',

      // Messages
      saved: 'Saved successfully',
      deleted: 'Deleted successfully',
      deleteError: 'Failed to delete rule',
      error: 'An error occurred',
      exportSuccess: 'Rule exported successfully',
      exportAllSuccess: 'Exported {{count}} rules successfully',
      exportError: 'Failed to export rules',
      noRulesToExport: 'No rules to export',
      importSuccess: 'Imported {{count}} rules successfully',
      importPartial: 'Imported {{count}} rules, {{errorCount}} failed',
      importError: 'Failed to import rules',

      // Navigation
      rules: 'Rules',
      settings: 'Settings',

      // Rule Editor
      ruleEditor: 'Rule Editor',
      ruleName: 'Rule Name',
      ruleDescription: 'Description',
      mediaType: 'Media Type',

      // URL Matching
      urlMatching: 'URL Matching',
      urlPattern: 'URL Pattern',
      patternType: 'Pattern Type',

      // Extraction
      extraction: 'Extraction',
      listExtraction: 'List Extraction',
      detailExtraction: 'Detail Extraction',
      contentExtraction: 'Content Extraction',

      // Actions
      actions: 'Actions',
      beforeActions: 'Before Actions',
      afterActions: 'After Actions',

      // Preview
      preview: 'Preview',
      testRule: 'Test Rule',
      previewUrl: 'Preview URL',
      previewDescription: 'Open a page in the app to select elements',
      previewNotConnected: 'Connect to server to enable preview',
      previewOpened: 'Preview opened in app',
      previewError: 'Failed to open preview',
      enterPreviewUrl: 'Please enter a URL to preview',
      serverNotRunning: 'Server is not running',
      disconnected: 'Disconnected',
      elementSelection: 'Element Selection',
      selectElement: 'Select Element',
      cancelSelection: 'Cancel',
      selectingHint: 'Click on an element in the app to select it',
      selectedElement: 'Selected Element',
      applySelector: 'Apply Selector',
      selectorApplied: 'Selector applied',
      selectorCopied: 'Selector copied',
      selectElementFromPage: 'Select element from page',
      pageScreenshot: 'Page Screenshot',
      refreshScreenshot: 'Refresh screenshot',
      toggleSize: 'Toggle size',
      selectorTesting: 'Selector Testing',
      selectorTestingDescription: 'Test selectors on the preview page',
      selector: 'Selector',
      enterSelector: 'Please enter a selector',
      openPreviewFirst: 'Please open a preview first',
      foundElements: 'Found {{count}} elements',
      noElementsFound: 'No elements found',
      testError: 'Failed to test selector',
      success: 'Success',
      failed: 'Failed',
      elementsFound: '{{count}} elements found',
      element: 'Element',
      andMore: 'And {{count}} more...',
    },
  },
  zh: {
    translation: {
      // 通用
      appTitle: '爬虫规则编辑器',
      save: '保存',
      cancel: '取消',
      delete: '删除',
      edit: '编辑',
      create: '创建',
      import: '导入',
      export: '导出',
      exportAll: '导出全部',
      newRule: '新建规则',
      retry: '重试',
      author: '作者',
      noDescription: '无描述',
      searchRules: '搜索规则...',
      noRules: '暂无规则，创建第一个规则开始使用。',
      confirmDelete: '删除规则？',
      confirmDeleteDescription: '此操作无法撤销，将永久删除该规则。',
      ruleEditorDescription: '管理用于内容提取的爬虫规则',

      // 消息
      saved: '保存成功',
      deleted: '删除成功',
      deleteError: '删除规则失败',
      error: '发生错误',
      exportSuccess: '导出规则成功',
      exportAllSuccess: '成功导出 {{count}} 条规则',
      exportError: '导出失败',
      noRulesToExport: '没有可导出的规则',
      importSuccess: '成功导入 {{count}} 条规则',
      importPartial: '导入 {{count}} 条规则，{{errorCount}} 条失败',
      importError: '导入规则失败',

      // 导航
      rules: '规则',
      settings: '设置',

      // 规则编辑器
      ruleEditor: '规则编辑器',
      ruleName: '规则名称',
      ruleDescription: '描述',
      mediaType: '媒体类型',

      // URL 匹配
      urlMatching: 'URL 匹配',
      urlPattern: 'URL 模式',
      patternType: '模式类型',

      // 提取
      extraction: '提取配置',
      listExtraction: '列表提取',
      detailExtraction: '详情提取',
      contentExtraction: '内容提取',

      // 动作
      actions: '动作',
      beforeActions: '前置动作',
      afterActions: '后置动作',

      // 预览
      preview: '预览',
      testRule: '测试规则',
      previewUrl: '预览 URL',
      previewDescription: '在应用中打开页面以选择元素',
      previewNotConnected: '连接服务器以启用预览',
      previewOpened: '已在应用中打开预览',
      previewError: '打开预览失败',
      enterPreviewUrl: '请输入要预览的 URL',
      serverNotRunning: '服务器未运行',
      disconnected: '未连接',
      elementSelection: '元素选择',
      selectElement: '选择元素',
      cancelSelection: '取消',
      selectingHint: '在应用中点击元素以选择',
      selectedElement: '已选择元素',
      applySelector: '应用选择器',
      selectorApplied: '选择器已应用',
      selectorCopied: '选择器已复制',
      selectElementFromPage: '从页面选择元素',
      pageScreenshot: '页面截图',
      refreshScreenshot: '刷新截图',
      toggleSize: '切换大小',
      selectorTesting: '选择器测试',
      selectorTestingDescription: '在预览页面上测试选择器',
      selector: '选择器',
      enterSelector: '请输入选择器',
      openPreviewFirst: '请先打开预览',
      foundElements: '找到 {{count}} 个元素',
      noElementsFound: '未找到元素',
      testError: '测试选择器失败',
      success: '成功',
      failed: '失败',
      elementsFound: '找到 {{count}} 个元素',
      element: '元素',
      andMore: '还有 {{count}} 个...',
    },
  },
};

i18n.use(initReactI18next).init({
  resources,
  lng: 'zh', // Default language
  fallbackLng: 'en',
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;
