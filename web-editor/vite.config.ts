import path from 'path';

import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],

  // Build output to Flutter assets directory
  build: {
    outDir: '../assets/editor',
    emptyOutDir: true,
    rollupOptions: {
      output: {
        manualChunks: {
          // React 核心
          'vendor-react': ['react', 'react-dom', 'react-router-dom'],
          // UI 组件库
          'vendor-ui': ['radix-ui', 'lucide-react'],
          // 数据获取和状态管理
          'vendor-data': ['@tanstack/react-query', 'zustand'],
          // 编辑器
          'vendor-editor': ['@monaco-editor/react'],
        },
      },
    },
  },

  // Development server proxy to Flutter backend
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },

  // Path aliases
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
});
