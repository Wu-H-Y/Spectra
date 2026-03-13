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

const quoteArg = (filePath) => JSON.stringify(filePath);

const buildCommand = (command, files) => {
  if (files.length === 0) {
    return null;
  }

  return `${command} ${files.map(quoteArg).join(' ')}`;
};

export default (allStagedFiles) => {
  const files = allStagedFiles.map(normalizePath);
  const commands = [];
  const dartFiles = files.filter((file) => file.endsWith('.dart'));

  if (hasMatch(files, /\.dart$/)) {
    const formatCommand = buildCommand(
      'dart format --output=none --set-exit-if-changed',
      dartFiles,
    );
    const analyzeCommand = buildCommand('dart analyze --fatal-infos', dartFiles);

    if (formatCommand) {
      commands.push(formatCommand);
    }
    if (analyzeCommand) {
      commands.push(analyzeCommand);
    }
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
