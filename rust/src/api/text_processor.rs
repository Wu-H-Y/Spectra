use chinese_number::{ChineseCase, ChineseVariant, NumberToChinese};
use ferrous_opencc::{config::BuiltinConfig, OpenCC};
/// 中文处理 API
///
/// 提供：
/// - 中文分词 (jieba-rs)
/// - 繁简转换 (ferrous-opencc)
/// - 数字转中文 (chinese-number)
use flutter_rust_bridge::frb;
use jieba_rs::Jieba;
use std::sync::OnceLock;

/// 全局 Jieba 实例
static JIEBA: OnceLock<Jieba> = OnceLock::new();

/// 全局 OpenCC 繁转简实例
static OPENCC_T2S: OnceLock<OpenCC> = OnceLock::new();

/// 全局 OpenCC 简转繁实例
static OPENCC_S2T: OnceLock<OpenCC> = OnceLock::new();

pub fn get_jieba() -> &'static Jieba {
    JIEBA.get_or_init(Jieba::new)
}

fn get_opencc_t2s() -> &'static OpenCC {
    OPENCC_T2S.get_or_init(|| {
        OpenCC::from_config(BuiltinConfig::T2s).expect("Failed to load T2S converter")
    })
}

fn get_opencc_s2t() -> &'static OpenCC {
    OPENCC_S2T.get_or_init(|| {
        OpenCC::from_config(BuiltinConfig::S2t).expect("Failed to load S2T converter")
    })
}

/// 中文分词
///
/// 使用 jieba 进行中文分词
///
/// # Arguments
/// * `text` - 待分词的文本
///
/// # Returns
/// 分词结果列表
#[frb]
pub fn segment(text: String) -> Vec<String> {
    let jieba = get_jieba();
    jieba
        .cut(&text, false)
        .into_iter()
        .map(|s| s.to_string())
        .collect()
}

/// 繁体转简体
///
/// 将繁体中文转换为简体中文
///
/// # Arguments
/// * `text` - 待转换的繁体文本
///
/// # Returns
/// 转换后的简体文本
#[frb]
pub fn to_simplified(text: String) -> String {
    let opencc = get_opencc_t2s();
    opencc.convert(&text)
}

/// 简体转繁体
///
/// 将简体中文转换为繁体中文
///
/// # Arguments
/// * `text` - 待转换的简体文本
///
/// # Returns
/// 转换后的繁体文本
#[frb]
pub fn to_traditional(text: String) -> String {
    let opencc = get_opencc_s2t();
    opencc.convert(&text)
}

/// 数字转中文
///
/// 将阿拉伯数字转换为中文数字
///
/// # Arguments
/// * `number` - 待转换的数字
///
/// # Returns
/// 中文数字字符串
#[frb]
pub fn number_to_chinese(number: i32) -> String {
    number.to_chinese_naive(ChineseVariant::Simple, ChineseCase::Lower)
}
