import { expect } from "vitest";

export const expectToMatchFileSnapshotImpl = value => path => () =>
  expect(value).toMatchFileSnapshot(path);
