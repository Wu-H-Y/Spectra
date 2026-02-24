/// 相似度计算 API
///
/// 提供：
/// - Jaccard 相似度 (基于分词)
/// - Levenshtein 距离/相似度
/// - 标题标准化
/// - 模糊搜索评分
use flutter_rust_bridge::frb;
use regex::Regex;
use std::collections::HashSet;
use std::sync::OnceLock;
use textdistance::{Algorithm, Levenshtein, SorensenDice};

use super::text_processor::get_jieba;

/// 标题标准化元数据匹配模式
const METADATA_PATTERNS: &[&str] = &[
    r"\([^)]*\)",     // (2024) (HD)
    r"【[^】]*】",    // 【推荐】
    r"\[[^\]]*\]",    // [完本]
    r"《[^》]*》",    // 《书名》
    r"<[^>]*>",       // <转载>
    r"第\s*\d+\s*章", // 第123章
    r"Chapter\s*\d+", // Chapter 123
];

/// 预编译的元数据正则表达式
static METADATA_REGEXES: OnceLock<Vec<Regex>> = OnceLock::new();

/// 预编译的空白正则表达式
static WHITESPACE_REGEX: OnceLock<Regex> = OnceLock::new();

fn get_metadata_regexes() -> &'static Vec<Regex> {
    METADATA_REGEXES.get_or_init(|| {
        METADATA_PATTERNS
            .iter()
            .filter_map(|pattern| Regex::new(pattern).ok())
            .collect()
    })
}

fn get_whitespace_regex() -> &'static Regex {
    WHITESPACE_REGEX.get_or_init(|| Regex::new(r"\s+").expect("Invalid whitespace regex"))
}

/// 计算 Jaccard 相似度
///
/// 基于中文分词计算两个字符串的 Jaccard 相似度
///
/// # Arguments
/// * `a` - 第一个字符串
/// * `b` - 第二个字符串
///
/// # Returns
/// 相似度值 (0.0 ~ 1.0)
#[frb]
pub fn jaccard(a: String, b: String) -> f64 {
    let jieba = get_jieba();

    let tokens_a: HashSet<&str> = jieba.cut(&a, false).into_iter().collect();
    let tokens_b: HashSet<&str> = jieba.cut(&b, false).into_iter().collect();

    if tokens_a.is_empty() && tokens_b.is_empty() {
        return 1.0;
    }
    if tokens_a.is_empty() || tokens_b.is_empty() {
        return 0.0;
    }

    let intersection = tokens_a.intersection(&tokens_b).count();
    let union = tokens_a.union(&tokens_b).count();

    if union == 0 {
        return 0.0;
    }

    intersection as f64 / union as f64
}

/// 计算 Levenshtein 相似度
///
/// 使用 textdistance 库计算编辑距离相似度
///
/// # Arguments
/// * `a` - 第一个字符串
/// * `b` - 第二个字符串
///
/// # Returns
/// 相似度值 (0.0 ~ 1.0)
#[frb]
pub fn levenshtein(a: String, b: String) -> f64 {
    if a == b {
        return 1.0;
    }
    if a.is_empty() || b.is_empty() {
        return 0.0;
    }

    let lev = Levenshtein::default();
    let result = lev.for_str(&a, &b);

    // nsim() 返回归一化相似度 (0.0 ~ 1.0)
    result.nsim()
}

/// 计算 Sørensen-Dice 相似度
///
/// 基于中文分词计算词组序列的 Sørensen-Dice 相似度
/// 比 Jaccard 更强调共同元素
///
/// # Arguments
/// * `a` - 第一个字符串
/// * `b` - 第二个字符串
///
/// # Returns
/// 相似度值 (0.0 ~ 1.0)
#[frb]
pub fn sorensen_dice(a: String, b: String) -> f64 {
    let jieba = get_jieba();

    let tokens_a: Vec<&str> = jieba.cut(&a, false);
    let tokens_b: Vec<&str> = jieba.cut(&b, false);

    if tokens_a.is_empty() && tokens_b.is_empty() {
        return 1.0;
    }
    if tokens_a.is_empty() || tokens_b.is_empty() {
        return 0.0;
    }

    let sd = SorensenDice::default();
    let result = sd.for_iter(tokens_a.iter().copied(), tokens_b.iter().copied());

    result.nsim()
}

/// 计算词组序列的 Levenshtein 相似度
///
/// 基于中文分词后计算词组序列的编辑距离相似度
/// 对词序敏感，适合标题匹配
///
/// # Arguments
/// * `a` - 第一个字符串
/// * `b` - 第二个字符串
///
/// # Returns
/// 相似度值 (0.0 ~ 1.0)
#[frb]
pub fn levenshtein_tokens(a: String, b: String) -> f64 {
    let jieba = get_jieba();

    let tokens_a: Vec<&str> = jieba.cut(&a, false);
    let tokens_b: Vec<&str> = jieba.cut(&b, false);

    if tokens_a.is_empty() && tokens_b.is_empty() {
        return 1.0;
    }
    if tokens_a.is_empty() || tokens_b.is_empty() {
        return 0.0;
    }

    let lev = Levenshtein::default();
    let result = lev.for_iter(tokens_a.iter().copied(), tokens_b.iter().copied());

    result.nsim()
}

/// 标题标准化
///
/// 统一标题格式：
/// 1. 繁体转简体
/// 2. 去除元数据模式
/// 3. 转小写
/// 4. 合并空白
///
/// # Arguments
/// * `title` - 原始标题
///
/// # Returns
/// 标准化后的标题
#[frb]
pub fn normalize_title(title: String) -> String {
    use super::text_processor::to_simplified;

    // 1. 繁体转简体
    let mut result = to_simplified(title);

    // 2. 使用预编译的正则去除元数据模式
    for re in get_metadata_regexes() {
        result = re.replace_all(&result, "").into_owned();
    }

    // 3. 转小写
    result = result.to_lowercase();

    // 4. 使用预编译的正则合并空白
    result = get_whitespace_regex()
        .replace_all(&result, " ")
        .into_owned();

    // 5. 去除首尾空白
    result.trim().to_string()
}

/// 模糊搜索评分
///
/// 综合计算搜索词与目标标题的相似度
/// 算法: sorensen_dice * 0.4 + levenshtein_tokens * 0.4 + levenshtein * 0.2
///
/// # Arguments
/// * `query` - 搜索词
/// * `target` - 目标标题
///
/// # Returns
/// 综合相似度分数 (0.0 ~ 1.0)
#[frb]
pub fn fuzzy_search_score(query: String, target: String) -> f64 {
    // 标准化
    let query_norm = normalize_title(query);
    let target_norm = normalize_title(target);

    // 计算 Sørensen-Dice 相似度 (词组级别，强调共同元素)
    let sd_score = sorensen_dice(query_norm.clone(), target_norm.clone());

    // 计算词组 Levenshtein 相似度 (词序敏感)
    let lev_tokens_score = levenshtein_tokens(query_norm.clone(), target_norm.clone());

    // 计算字符级 Levenshtein 相似度
    let lev_score = levenshtein(query_norm, target_norm);

    // 综合评分
    sd_score * 0.4 + lev_tokens_score * 0.4 + lev_score * 0.2
}

// ============================================================================
// 单元测试
// ============================================================================

#[cfg(test)]
mod tests {
    use super::*;

    // ============ Jaccard 相似度测试 ============

    #[test]
    fn test_jaccard_identical_strings() {
        let result = jaccard("你好世界".to_string(), "你好世界".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_jaccard_empty_strings() {
        let result = jaccard("".to_string(), "".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);

        let result = jaccard("你好".to_string(), "".to_string());
        assert!((result - 0.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_jaccard_partial_overlap() {
        let result = jaccard("你好世界".to_string(), "你好中国".to_string());
        assert!(result > 0.0 && result < 1.0);
    }

    #[test]
    fn test_jaccard_no_overlap() {
        let result = jaccard("苹果".to_string(), "香蕉".to_string());
        assert!((0.0..0.5).contains(&result));
    }

    // ============ Levenshtein 相似度测试 (textdistance) ============

    #[test]
    fn test_levenshtein_identical_strings() {
        let result = levenshtein("hello".to_string(), "hello".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_levenshtein_empty_strings() {
        let result = levenshtein("".to_string(), "".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);

        let result = levenshtein("hello".to_string(), "".to_string());
        assert!((result - 0.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_levenshtein_one_char_difference() {
        let result = levenshtein("hello".to_string(), "hallo".to_string());
        // textdistance 使用不同的归一化方式
        assert!(result > 0.7 && result < 1.0);
    }

    #[test]
    fn test_levenshtein_chinese() {
        let result = levenshtein("你好世界".to_string(), "你好世借".to_string());
        assert!(result > 0.6);
    }

    // ============ Sørensen-Dice 测试 ============

    #[test]
    fn test_sorensen_dice_identical() {
        let result = sorensen_dice("你好世界".to_string(), "你好世界".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_sorensen_dice_different() {
        let result = sorensen_dice("苹果手机".to_string(), "香蕉电脑".to_string());
        assert!(result < 0.5);
    }

    #[test]
    fn test_sorensen_dice_word_order() {
        // 测试词序不同的情况
        // "苹果手机" vs "手机苹果" - 分词后词集相同，Dice 应该较高
        let result = sorensen_dice("苹果手机".to_string(), "手机苹果".to_string());
        // Sørensen-Dice 基于 bigram，词序不同会有影响
        assert!(result > 0.3);
    }

    // ============ 词组 Levenshtein 测试 ============

    #[test]
    fn test_levenshtein_tokens_identical() {
        let result = levenshtein_tokens("你好世界".to_string(), "你好世界".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_levenshtein_tokens_word_order() {
        // 测试词序不同的情况
        // "苹果手机" vs "手机苹果" - 分词后顺序不同，编辑距离应该较高
        let result = levenshtein_tokens("苹果手机".to_string(), "手机苹果".to_string());
        // 词序不同，相似度应该较低
        assert!(result < 0.7);
    }

    // ============ 标题标准化测试 ============

    #[test]
    fn test_normalize_title_simple() {
        let result = normalize_title("你好世界".to_string());
        assert_eq!(result, "你好世界");
    }

    #[test]
    fn test_normalize_title_lowercase() {
        let result = normalize_title("Hello World".to_string());
        assert_eq!(result, "hello world");
    }

    #[test]
    fn test_normalize_title_remove_parentheses() {
        let result = normalize_title("标题(2024)".to_string());
        assert_eq!(result, "标题");
    }

    #[test]
    fn test_normalize_title_remove_brackets() {
        let result = normalize_title("标题[完本]".to_string());
        assert_eq!(result, "标题");
    }

    #[test]
    fn test_normalize_title_remove_chinese_brackets() {
        let result = normalize_title("标题【推荐】".to_string());
        assert_eq!(result, "标题");
    }

    #[test]
    fn test_normalize_title_remove_chapter() {
        let result = normalize_title("第123章 标题".to_string());
        assert_eq!(result, "标题");
    }

    #[test]
    fn test_normalize_title_remove_english_chapter() {
        let result = normalize_title("Chapter 123 Title".to_string());
        assert_eq!(result, "title");
    }

    #[test]
    fn test_normalize_title_collapse_whitespace() {
        let result = normalize_title("标题   副标题".to_string());
        assert_eq!(result, "标题 副标题");
    }

    #[test]
    fn test_normalize_title_trim() {
        let result = normalize_title("  标题  ".to_string());
        assert_eq!(result, "标题");
    }

    #[test]
    fn test_normalize_title_complex() {
        let result = normalize_title("斗罗大陆(2024)【完结】[精品]".to_string());
        assert_eq!(result, "斗罗大陆");
    }

    // ============ 模糊搜索评分测试 ============

    #[test]
    fn test_fuzzy_search_score_identical() {
        let result = fuzzy_search_score("斗罗大陆".to_string(), "斗罗大陆".to_string());
        assert!((result - 1.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_fuzzy_search_score_similar() {
        let result = fuzzy_search_score("斗罗大陆".to_string(), "斗罗大陆1".to_string());
        assert!(result > 0.5, "Score {} should be > 0.5", result);
    }

    #[test]
    fn test_fuzzy_search_score_different() {
        let result = fuzzy_search_score("苹果".to_string(), "香蕉".to_string());
        assert!(result < 0.5);
    }

    #[test]
    fn test_fuzzy_search_score_with_metadata() {
        let result = fuzzy_search_score("斗罗大陆".to_string(), "斗罗大陆(2024)".to_string());
        assert!((result - 1.0).abs() < 0.01);
    }

    #[test]
    fn test_fuzzy_search_score_threshold() {
        let result = fuzzy_search_score("斗罗大陆第一部".to_string(), "斗罗大陆第二部".to_string());
        assert!(result < 0.96);
    }

    #[test]
    fn test_fuzzy_search_score_word_order() {
        let result = fuzzy_search_score("苹果手机".to_string(), "手机苹果".to_string());
        // 词序相反，相似度中等偏低是合理的
        assert!(result > 0.3 && result < 0.6);
    }
}
