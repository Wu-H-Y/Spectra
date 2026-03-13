/**
 * lint-staged 配置
 *
 * 注意：
 * 1. cargo clippy、dart fix 与格式化命令都会作用于整个项目，不能安全地按文件分块并发执行。
 * 2. 这里改为基于全部暂存文件一次性决定要运行的任务，避免 lint-staged 分块后重复跑整仓命令。
 * 3. Dart 触发范围覆盖测试目录，避免 `test/` 或 `integration_test/` 改动漏掉格式化。
 * 4. 每个语言都执行两次：先 fix/format，再 lint 验证，确保无残留错误。
 */

const normalizePath = (filePath) => filePath.replaceAll('\\', '/');

const hasMatch = (files, pattern) => files.some((file) => pattern.test(file));

export default (allStagedFiles) => {
  const files = allStagedFiles.map(normalizePath);
  const commands = [];

  if (hasMatch(files, /\.dart$/)) {
    commands.push('bun run lint:fix:dart .');
    commands.push('bun run format:dart .');
    commands.push('bun run lint:dart'); // 验证修复后无错误
  }

  if (hasMatch(files, /^rust\/.*\.rs$/)) {
    commands.push('bun run lint:fix:rust');
    commands.push('bun run format:rust');
    commands.push('bun run lint:rust'); // 验证修复后无错误
  }

  if (hasMatch(files, /^web-editor\/.*\.(ts|tsx|json|css|scss|md)$/)) {
    commands.push('bun run lint:fix:web');
    commands.push('bun run format:web');
    commands.push('bun run lint:web'); // 验证修复后无错误
  }

  return commands;
};
