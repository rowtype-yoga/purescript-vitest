import {expect} from "vitest";

export const expectToBeImpl = x => y => () => expect(x).toBe(y)

