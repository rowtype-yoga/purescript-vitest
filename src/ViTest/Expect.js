import {expect} from "vitest";

export const expectToBeImpl = x => y => () => expect(x).toBe(y)

export const unsafeStringify = x => {
  try {
    return JSON.stringify(x, null, 2);
  } catch (e) {
    return String(x);
  }
}

export const expectToEqualFailureImpl = actual => expected => () => {
  const constructorName = value => value?.constructor?.name ?? typeof value;
  throw new Error(
    `PureScript Eq assertion failed.\n` +
    `Expected (${constructorName(expected)}):\n${unsafeStringify(expected)}\n` +
    `Received (${constructorName(actual)}):\n${unsafeStringify(actual)}`
  );
}

export const expectToSatisfyImpl = value => predicate => () => {
  const result = predicate(value);
  if (!result) {
    throw new Error(`Expected value to satisfy predicate, but it didn't.\nValue: ${unsafeStringify(value)}`);
  }
}

