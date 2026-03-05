## 1. 数据结构定义

- [ ] 1.1 在 `rust/src/domain/phase.rs` 中定义 `LifecyclePhase` 枚举（Explore/Search/Detail/Toc/Content）
- [ ] 1.2 在 `rust/src/domain/phase.rs` 中定义 `ContentType` 枚举（Html/Json/Xml）
- [ ] 1.3 在 `rust/src/domain/phase.rs` 中定义 `PhaseContext` 结构（url/keyword/page/vars）
- [ ] 1.4 在 `rust/src/domain/phase.rs` 中定义 `PhaseResult` 结构（success/final_url/content_type/raw_body/data/error）
- [ ] 1.5 在 `rust/src/domain/phase.rs` 中定义 `PhaseData` 枚举及各阶段数据结构（SearchData/DetailData/TocData/ContentData）
- [ ] 1.6 扩展 `CrawlerError` 枚举，添加新错误类型（MissingPhaseConfig/UrlTemplateError/UnsupportedContentType/DataParseError/MissingRequiredContext）
- [ ] 1.7 运行 `cargo check` 验证类型定义

## 2. 核心执行器实现

- [ ] 2.1 创建 `rust/src/api/lifecycle_executor.rs` 模块
- [ ] 2.2 实现 URL 模板替换函数（支持 `{{key}}`, `{{page}}`, 自定义变量）
- [ ] 2.3 实现响应类型检测函数（Content-Type header 解析 + 规则配置覆盖）
- [ ] 2.4 实现 WAF 拦截检测函数（403/503 + Cloudflare headers）
- [ ] 2.5 实现 `execute_lifecycle_phase()` 主函数框架（参数验证、阶段配置获取）
- [ ] 2.6 集成 HTTP 请求逻辑（调用内部 `http_client.rs` API）
- [ ] 2.7 集成 Pipeline 执行逻辑（根据 ContentType 选择解析器）
- [ ] 2.8 实现数据结构化转换逻辑（Vec<String> -> PhaseData）
- [ ] 2.9 运行 `cargo check` 验证编译

## 3. API 导出与降级

- [ ] 3.1 在 `rust/src/api/mod.rs` 中导出 `lifecycle_executor` 模块
- [ ] 3.2 将 `rust/src/api/html_parser.rs` 标记为 `pub(crate)`，移除 FRB 导出
- [ ] 3.3 将 `rust/src/api/http_client.rs` 标记为 `pub(crate)`，移除部分 FRB 导出
- [ ] 3.4 运行 `flutter_rust_bridge code generate` 生成 Dart 类型
- [ ] 3.5 运行 `cargo check` 验证模块导出

## 4. 单元测试

- [ ] 4.1 为 `LifecyclePhase` 枚举编写单元测试
- [ ] 4.2 为 URL 模板替换函数编写单元测试（正常替换、缺少变量、无效模板）
- [ ] 4.3 为响应类型检测函数编写单元测试（自动检测、规则覆盖）
- [ ] 4.4 为 WAF 拦截检测函数编写单元测试（Cloudflare 拦截、普通 403、非 WAF 错误）
- [ ] 4.5 为 `execute_lifecycle_phase()` 搜索阶段编写集成测试（模拟 HTTP 响应）
- [ ] 4.6 为 `execute_lifecycle_phase()` 详情阶段编写集成测试
- [ ] 4.7 运行 `cargo test` 确保所有测试通过

## 5. Dart 侧集成

- [ ] 5.1 检查生成的 Dart 类型是否正确（`lib/core/rust/domain/phase.dart`）
- [ ] 5.2 创建 `lib/core/crawler/phase_executor.dart` 服务类
- [ ] 5.3 实现 `PhaseExecutor.executeSearch()` 方法
- [ ] 5.4 实现 `PhaseExecutor.executeDetail()` 方法
- [ ] 5.5 实现 `PhaseExecutor.executeToc()` 方法
- [ ] 5.6 实现 `PhaseExecutor.executeContent()` 方法
- [ ] 5.7 运行 `flutter analyze` 确保无错误

## 6. 现有代码迁移

- [ ] 6.1 识别使用底层 API 的 Dart 代码位置
- [ ] 6.2 更新使用新 `PhaseExecutor` API
- [ ] 6.3 移除或标记为 deprecated 的旧封装类
- [ ] 6.4 运行 `flutter analyze` 确保无错误
- [ ] 6.5 运行完整功能测试确保迁移成功

## 7. 文档与清理

- [ ] 7.1 更新 `rust/README.md` 文档，说明新旧 API 的使用方式
- [ ] 7.2 添加迁移指南，说明如何从底层 API 迁移到新 API
- [ ] 7.3 清理不再使用的导入和依赖
- [ ] 7.4 运行 `cargo clippy` 确保代码质量
- [ ] 7.5 运行 `flutter analyze` 确保整体代码质量

## 8. 性能验证

- [ ] 8.1 编写性能基准测试（新 API vs 底层 API）
- [ ] 8.2 运行性能测试，确保响应时间不超过底层 API
- [ ] 8.3 分析性能瓶颈（如有）
- [ ] 8.4 优化性能关键路径（如有需要）
