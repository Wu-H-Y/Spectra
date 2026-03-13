import { describe, expect, test } from 'vitest';

import {
  createEmptyRuleEnvelope,
  parseRuleEnvelope,
  serializeRuleEnvelope,
} from '@/lib/ruleEditorEnvelope';

describe('ruleEditorEnvelope', () => {
  test('createEmptyRuleEnvelope returns valid envelope', () => {
    const envelope = createEmptyRuleEnvelope();

    expect(envelope.irVersion).toBe('1.0.0');
    expect(envelope.metadata.ruleId).toBe('');
    expect(envelope.metadata.name).toBe('');
    expect(envelope.graph.nodes).toHaveLength(2);
    expect(envelope.graph.edges).toHaveLength(1);
    expect(envelope.capabilities.supportsPagination).toBe(false);
    expect(envelope.capabilities.crypto.aes).toBe(false);
  });

  test('parseRuleEnvelope parses valid JSON', () => {
    const envelope = createEmptyRuleEnvelope();
    const json = JSON.stringify(envelope);

    const parsed = parseRuleEnvelope(json);

    expect(parsed.irVersion).toBe(envelope.irVersion);
    expect(parsed.metadata.ruleId).toBe(envelope.metadata.ruleId);
  });

  test('parseRuleEnvelope throws on empty string', () => {
    expect(() => parseRuleEnvelope('')).toThrow();
  });

  test('parseRuleEnvelope throws on invalid JSON', () => {
    expect(() => parseRuleEnvelope('not json')).toThrow();
  });

  test('parseRuleEnvelope throws on invalid structure', () => {
    expect(() => parseRuleEnvelope('{"foo": "bar"}')).toThrow();
  });

  test('serializeRuleEnvelope produces formatted JSON', () => {
    const envelope = createEmptyRuleEnvelope();
    const json = serializeRuleEnvelope(envelope);

    expect(json).toContain('irVersion');
    expect(json).toContain('metadata');
    expect(json).toContain('graph');

    // Should be parseable back
    const parsed = JSON.parse(json);
    expect(parsed.irVersion).toBe(envelope.irVersion);
  });
});
