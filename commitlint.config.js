// commitlint.config.js
// Conventional Commits 配置
// @see https://commitlint.js.org/

export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // 类型枚举 - 与项目 COMMIT_CONVENTION.md 保持一致
    'type-enum': [
      2,
      'always',
      [
        'feat',     // 新功能
        'fix',      // Bug 修复
        'deps',     // 依赖更新
        'docs',     // 文档更新
        'style',    // 代码格式
        'refactor', // 重构
        'perf',     // 性能优化
        'test',     // 测试
        'build',    // 构建系统
        'ci',       // CI 配置
        'chore',    // 其他
        'revert',   // 回滚
      ],
    ],
    // 主题最大长度 50 字符
    'subject-max-length': [2, 'always', 50],
    // 主题不以句号结尾
    'subject-full-stop': [2, 'never', '.'],
    // 主题大小写不限制（支持中文）
    'subject-case': [0],
  },
};
