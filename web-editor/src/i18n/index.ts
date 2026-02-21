import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import en from './locales/en.json';
import zh from './locales/zh.json';

/**
 * 默认 namespace
 */
export const defaultNS = 'translation' as const;

/**
 * i18n 资源配置
 * 使用单文件嵌套结构，通过点号访问: t('common.save')
 */
export const resources = {
  zh: { translation: zh },
  en: { translation: en },
} as const;

i18n.use(initReactI18next).init({
  lng: 'zh', // 默认语言
  fallbackLng: 'en',
  defaultNS,
  resources,
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;
