use std::{error::Error, path::PathBuf};

use spectra_native::rules_ir::{NormalizedModel, RuleEnvelope};
use ts_rs::{Config, TS};

/// 将 Rust IR 类型导出为 TypeScript 类型定义。
///
/// 输出路径：`web-editor/src/types/rule.ts`。
fn main() -> Result<(), Box<dyn Error>> {
    let manifest_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let export_dir = manifest_dir.join("../web-editor/src/types");

    std::fs::create_dir_all(&export_dir)?;

    let cfg = Config::new().with_out_dir(export_dir);
    RuleEnvelope::export_all(&cfg)?;
    NormalizedModel::export_all(&cfg)?;

    Ok(())
}
