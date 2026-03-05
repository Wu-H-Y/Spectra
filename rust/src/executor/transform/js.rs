//! JavaScript 执行器
//!
//! 使用 rquickjs 提供轻量级的 JavaScript 执行环境。

use crate::error::CrawlerError;

/// JavaScript 执行器
pub struct JsExecutor;

impl JsExecutor {
    /// 执行 JavaScript 代码片段
    ///
    /// # 参数
    /// - `script`: JavaScript 代码
    /// - `val`: 当前值（注入为 `val` 变量）
    /// - `vars`: 上下文变量（注入为 `vars` 对象）
    ///
    /// # 返回
    /// 执行结果的字符串
    pub fn execute(
        script: &str,
        val: &str,
        vars: Option<&serde_json::Value>,
    ) -> Result<String, CrawlerError> {
        use rquickjs::{Context, Runtime};

        // 创建 QuickJS 运行时
        let runtime = Runtime::new()
            .map_err(|e| CrawlerError::JsError(format!("无法创建 JS 运行时: {}", e)))?;

        let ctx = Context::full(&runtime)
            .map_err(|e| CrawlerError::JsError(format!("无法创建 JS 上下文: {}", e)))?;

        // 在上下文中执行
        ctx.with(|ctx| {
            // 注入 val 变量
            let globals = ctx.globals();
            globals
                .set("val", val)
                .map_err(|e| CrawlerError::JsError(format!("无法注入 val 变量: {}", e)))?;

            // 注入 vars 对象
            if let Some(vars_value) = vars {
                let vars_json = serde_json::to_string(vars_value)
                    .map_err(|e| CrawlerError::JsError(format!("无法序列化 vars: {}", e)))?;
                // 使用 eval 直接设置 vars (使用 let 声明变量)
                let setup_script = format!("let vars = {};", vars_json);
                ctx.eval::<(), _>(setup_script.as_str())
                    .map_err(|e| CrawlerError::JsError(format!("无法注入 vars 变量: {}", e)))?;
            }

            // 执行脚本
            let result: String = ctx
                .eval(script)
                .map_err(|e| CrawlerError::JsError(format!("JS 执行错误: {}", e)))?;

            Ok(result)
        })
    }
}

#[cfg(test)]
mod tests {
    use serde_json::json;

    use super::*;

    #[test]
    fn test_js_basic() {
        let script = "val.toUpperCase()";
        let result = JsExecutor::execute(script, "hello", None).unwrap();
        assert_eq!(result, "HELLO");
    }

    #[test]
    fn test_js_replace() {
        let script = "val.replace(/world/g, 'rust')";
        let result = JsExecutor::execute(script, "hello world", None).unwrap();
        assert_eq!(result, "hello rust");
    }

    #[test]
    fn test_js_with_vars() {
        let script = "val + ' - ' + vars.host";
        let vars = json!({"host": "example.com"});
        let result = JsExecutor::execute(script, "test", Some(&vars)).unwrap();
        assert_eq!(result, "test - example.com");
    }
}
