import i18n from 'i18next'
import { initReactI18next } from 'react-i18next'

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
      
      // Navigation
      rules: 'Rules',
      settings: 'Settings',
      
      // Rule Editor
      ruleEditor: 'Rule Editor',
      newRule: 'New Rule',
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
      
      // Messages
      saved: 'Saved successfully',
      deleted: 'Deleted successfully',
      error: 'An error occurred',
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
      
      // 导航
      rules: '规则',
      settings: '设置',
      
      // 规则编辑器
      ruleEditor: '规则编辑器',
      newRule: '新建规则',
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
      
      // 消息
      saved: '保存成功',
      deleted: '删除成功',
      error: '发生错误',
    },
  },
}

i18n.use(initReactI18next).init({
  resources,
  lng: 'zh', // Default language
  fallbackLng: 'en',
  interpolation: {
    escapeValue: false,
  },
})

export default i18n
