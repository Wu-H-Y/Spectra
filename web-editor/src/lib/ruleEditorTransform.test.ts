import { describe, expect, test } from 'vitest';

import { getSecretSource, parseKeyRef } from '@/lib/ruleEditorTransform';

describe('ruleEditorTransform', () => {
  describe('parseKeyRef', () => {
    test('returns null for undefined value', () => {
      expect(parseKeyRef(undefined)).toBeNull();
    });

    test('returns null for empty string', () => {
      expect(parseKeyRef('')).toBeNull();
    });

    test('parses valid JSON KeyRef', () => {
      const keyRef = {
        provider: 'variable' as const,
        name: 'myKey',
        value: null,
      };
      const result = parseKeyRef(JSON.stringify(keyRef));

      expect(result).not.toBeNull();
      expect(result?.provider).toBe('variable');
      expect(result?.name).toBe('myKey');
    });

    test('treats non-JSON as inline value', () => {
      const result = parseKeyRef('mySecretKey');

      expect(result).not.toBeNull();
      expect(result?.provider).toBe('inline');
      expect(result?.value).toBe('mySecretKey');
    });
  });

  describe('getSecretSource', () => {
    test('returns inline for null KeyRef', () => {
      expect(getSecretSource(null)).toBe('inline');
    });

    test('returns inline for inline provider', () => {
      const keyRef = { provider: 'inline' as const, value: 'test', name: null };
      expect(getSecretSource(keyRef)).toBe('inline');
    });

    test('returns variable for variable provider', () => {
      const keyRef = {
        provider: 'variable' as const,
        name: 'myVar',
        value: null,
      };
      expect(getSecretSource(keyRef)).toBe('variable');
    });

    test('returns secureStore for secureStore provider', () => {
      const keyRef = {
        provider: 'secureStore' as const,
        name: 'mySecret',
        value: null,
      };
      expect(getSecretSource(keyRef)).toBe('secureStore');
    });
  });
});
