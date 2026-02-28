/**
 * lint-staged 配置
 *
 * 注意: cargo clippy 和 dart fix 不支持对单个文件进行操作，
 * 因此这里忽略 lint-staged 传入的文件列表，改为在整个项目上运行。
 */

export default {
  "lib/**/*.dart": [
    () => "bun run lint:fix:dart .",
    () => "bun run format:dart .",
  ],
  "rust/**/*.rs": [
    () => "bun run lint:fix:rust",
    () => "bun run format:rust",
  ],
  "web-editor/**/*.{ts,tsx,json,css,scss,md}": [
    () => "bun run lint:fix:web",
    () => "bun run format:web",
  ],
};
