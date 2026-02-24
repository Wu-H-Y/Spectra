# Spectra Native - Rust FFI 模块

Flutter Rust Bridge 原生模块，提供高性能文本处理能力（中文分词、繁简转换、相似度计算）。

---

## COMMANDS

```bash
# 单文件检查
cargo clippy -- -W clippy::all src/path/to/file.rs  # 单文件 lint
cargo +nightly fmt -- src/path/to/file.rs            # 单文件格式化

# 全量检查
cargo clippy --all-targets --all-features -- -D warnings  # 全量 lint
cargo +nightly fmt --all -- --check                       # 格式化检查

# 代码生成 (修改 FRB API 后运行)
cd .. && dart run flutter_rust_bridge_codegen generate

# 构建
cargo build --release
```

---

## PROJECT STRUCTURE

```
rust/
├── Cargo.toml           # 依赖配置
├── src/
│   ├── lib.rs           # 模块入口
│   ├── frb_generated.rs # FRB 自动生成 (勿手动编辑)
│   └── api/             # 对外暴露的 API
│       ├── mod.rs
│       ├── text_processor.rs  # 中文处理
│       └── similarity.rs      # 相似度计算
└── target/              # 构建产物
```

---

## DO / DON'T

| ✅ Do | ❌ Don't |
|-------|---------|
| 使用 `#[frb]` 宏标记公开函数 | 直接修改 `frb_generated.rs` |
| 中文注释 | 英文注释 |
| `OnceLock` 全局实例 | 每次调用创建实例 |
| `pub fn` 暴露 API | 使用 `pub(crate)` 暴露给 Flutter |

---

## FRB PATTERNS

```rust
use flutter_rust_bridge::frb;

/// 函数文档注释会暴露给 Dart
#[frb]
pub fn my_function(input: String) -> Result<String, String> {
    Ok(input.to_uppercase())
}

/// 全局单例模式
static INSTANCE: OnceLock<MyType> = OnceLock::new();

pub fn get_instance() -> &'static MyType {
    INSTANCE.get_or_init(MyType::new)
}
```

---

## DEPENDENCIES

| 库 | 用途 |
|---|------|
| `flutter_rust_bridge` | Flutter FFI 桥接 |
| `jieba-rs` | 中文分词 |
| `ferrous-opencc` | 繁简转换 |
| `chinese-number` | 数字转中文 |
| `regex` | 正则表达式 |
| `textdistance` | 文本相似度 |

---

## CLIPPY RULES

项目启用严格 lint，所有警告视为错误 (`-D warnings`)。

常见修复：
- `clippy::unwrap_used`: 使用 `?` 或 `expect()`
- `clippy::doc_lazy_continuation`: 文档缩进
- `clippy::needless_pass_by_value`: 使用引用参数

---

## TESTING

```bash
cargo test                    # 运行所有测试
cargo test -- --test-threads=1  # 单线程运行
```

---

## LEARNING FROM MISTAKES

| 错误模式 | 正确做法 |
|---------|---------|
| 修改 `frb_generated.rs` | 修改 `api/*.rs` 后重新生成 |
| 未标记 `#[frb]` | 需暴露给 Flutter 的函数必须标记 |
| 忘记 `pub mod` | 新模块需在 `mod.rs` 中声明 |
| 猜测 crate API | 先查 docs.rs 文档 |

---

## PACKAGE DOCUMENTATION

不熟悉的 crate 或版本，**先查官方文档，不要猜测 API**:

| 来源 | 链接格式 |
|------|---------|
| docs.rs API 文档 | `https://docs.rs/<crate_name>/<version>/<crate_name>/` |
| crates.io 包详情 | `https://crates.io/crates/<crate_name>` |

**示例**:
- jieba-rs: https://docs.rs/jieba-rs/latest/jieba_rs/
- regex: https://docs.rs/regex/latest/regex/
- flutter_rust_bridge: https://docs.rs/flutter_rust_bridge/latest/flutter_rust_bridge/
- ferrous-opencc: https://docs.rs/ferrous-opencc/latest/ferrous_opencc/

---

## PERMISSIONS

**允许**: 读文件 | 单文件 clippy/fmt | `cargo check`

**需询问**: 添加新依赖 | 修改 `Cargo.toml` | `cargo publish`

---

## WHEN STUCK

1. 提具体问题或建议方案
2. **不猜测 API**，先查文档:
   - docs.rs: `https://docs.rs/<crate>/<version>/<crate>/`
   - crates.io: `https://crates.io/crates/<crate>`
3. 用 `// TODO:` 标记草稿
4. 不确认不重构
