import {expect} from "vitest";

export const expectToBeImpl = x => y => () => expect(x).toBe(y)

export const unsafeStringify = x => {
  try {
    return JSON.stringify(x, null, 2);
  } catch (e) {
    return String(x);
  }
}

export const expectToEqualImpl = x => y => () => expect(x).toEqual(y)

export const expectToSatisfyImpl = value => predicate => () => {
  const result = predicate(value);
  if (!result) {
    throw new Error(`Expected value to satisfy predicate, but it didn't.\nValue: ${unsafeStringify(value)}`);
  }
}

