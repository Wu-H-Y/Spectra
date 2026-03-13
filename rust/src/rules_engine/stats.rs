use std::time::Duration;

/// 节点运行统计。
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct NodeStats {
    /// 输入消息条数。
    pub input_messages: usize,
    /// 输出消息条数。
    pub output_messages: usize,
    /// 错误条数。
    pub error_count: usize,
    /// 节点是否成功结束。
    pub success: bool,
    /// 节点耗时。
    pub elapsed: Duration,
}
