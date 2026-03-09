// 临时说明：
//
// 该文件原本是预览 runner 的独立原型实现，但当前仓库的正式链路
// 已收敛到 `server_provider.dart` 中的 `PreviewSessionController`
// 与 `_PreviewRunnerProcessSessionController`。
//
// 由于这里的原型文件未接入正式调用链，且依赖的本地 runner 脚本
// （如 `tools/preview-runner/index.mjs`）当前并未随仓库实现一并落地，
// 因此先保留为注释占位，避免后续维护时误认为这是生效代码。
//
// 如果未来需要重新拆分预览 runner：
// 1. 先补齐实际的本地 runner 脚本与启动方式；
// 2. 再把 `server_provider.dart` 中的预览控制器实现迁回独立文件；
// 3. 最后补齐端到端测试与依赖声明后再启用。
