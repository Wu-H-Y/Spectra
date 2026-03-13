import path from 'path';

import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

const manualChunks = (id: string) => {
  if (
    id.includes('react-dom') ||
    id.includes('react-router-dom') ||
    id.includes(`${path.sep}react${path.sep}`)
  ) {
    return 'vendor-react';
  }

  if (id.includes('radix-ui') || id.includes('lucide-react')) {
    return 'vendor-ui';
  }

  if (id.includes('@tanstack/react-query') || id.includes('zustand')) {
    return 'vendor-data';
  }

  if (id.includes('@monaco-editor/react')) {
    return 'vendor-editor';
  }

  return undefined;
};

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],

  // Build output to Flutter assets directory
  build: {
    outDir: '../assets/editor',
    emptyOutDir: true,
    rollupOptions: {
      output: {
        manualChunks,
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
