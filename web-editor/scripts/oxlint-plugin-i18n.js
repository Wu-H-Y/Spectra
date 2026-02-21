/**
 * Oxlint JS Plugin: i18n 规则
 *
 * 检测 react-i18next 使用中的常见问题：
 * 1. 禁止 t() 调用中使用 defaultValue 参数
 * 2. 禁止 t() 调用中使用 ns 参数（应使用嵌套键格式）
 */

/**
 * @type {import('@oxlint/plugins').Plugin}
 */
const plugin = {
  meta: {
    name: 'i18n',
    version: '1.0.0',
  },
  rules: {
    /**
     * 禁止在 t() 调用中使用 defaultValue 参数
     *
     * @example
     * // ❌ 错误
     * t('key', { defaultValue: 'text' })
     *
     * // ✅ 正确
     * t('key')
     */
    'no-default-value': {
      meta: {
        type: 'suggestion',
        docs: {
          description: '禁止在 t() 调用中使用 defaultValue 参数',
          recommended: true,
        },
        messages: {
          noDefaultValue:
            '避免使用 defaultValue 参数，应在 locale 文件中定义翻译文本',
        },
      },
      create(context) {
        return {
          CallExpression(node) {
            // 检查是否是 t() 调用
            if (
              node.callee.type === 'Identifier' &&
              node.callee.name === 't' &&
              node.arguments.length >= 2
            ) {
              const secondArg = node.arguments[1];
              if (
                secondArg.type === 'ObjectExpression' &&
                secondArg.properties.some(
                  (prop) =>
                    prop.type === 'Property' &&
                    prop.key.type === 'Identifier' &&
                    prop.key.name === 'defaultValue',
                )
              ) {
                context.report({
                  node,
                  messageId: 'noDefaultValue',
                });
              }
            }
          },
        };
      },
    },

    /**
     * 禁止在 t() 调用中使用 ns 参数
     *
     * @example
     * // ❌ 错误
     * t('key', { ns: 'errors' })
     *
     * // ✅ 正确
     * t('errors.key')
     */
    'no-namespace-option': {
      meta: {
        type: 'suggestion',
        docs: {
          description: '禁止在 t() 调用中使用 ns 参数，应使用嵌套键格式',
          recommended: true,
        },
        messages: {
          noNamespaceOption:
            '避免使用 ns 参数，应使用嵌套键格式如 t("errors.key")',
        },
      },
      create(context) {
        return {
          CallExpression(node) {
            // 检查是否是 t() 调用
            if (
              node.callee.type === 'Identifier' &&
              node.callee.name === 't' &&
              node.arguments.length >= 2
            ) {
              const secondArg = node.arguments[1];
              if (
                secondArg.type === 'ObjectExpression' &&
                secondArg.properties.some(
                  (prop) =>
                    prop.type === 'Property' &&
                    prop.key.type === 'Identifier' &&
                    prop.key.name === 'ns',
                )
              ) {
                context.report({
                  node,
                  messageId: 'noNamespaceOption',
                });
              }
            }
          },
        };
      },
    },
  },
};

export default plugin;
