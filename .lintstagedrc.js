/**
 * lint-staged 配置
 *
 * 注意：
 * 1. pre-commit 阶段只做校验，不做整仓 fix/format，避免提交失败时出现“改动被回滚”的体验。
 * 2. 这里仍然基于全部暂存文件一次性决定要运行的任务，避免 lint-staged 分块后重复跑整仓命令。
 * 3. 只要某个语言域存在暂存改动，就运行对应的非破坏性 format/lint 检查。
 */

const normalizePath = (filePath) => filePath.replaceAll('\\', '/');

const hasMatch = (files, pattern) => files.some((file) => pattern.test(file));

export default (allStagedFiles) => {
  const files = allStagedFiles.map(normalizePath);
  const commands = [];

  if (hasMatch(files, /\.dart$/)) {
    commands.push('bun run format:check:dart');
    commands.push('bun run lint:dart');
  }

  if (hasMatch(files, /^rust\/.*\.rs$/)) {
    commands.push('bun run format:check:rust');
    commands.push('bun run lint:rust');
  }

  if (hasMatch(files, /^web-editor\/.*\.(ts|tsx|json|css|scss|md)$/)) {
    commands.push('bun run format:check:web');
    commands.push('bun run lint:web');
  }

  return commands;
};
