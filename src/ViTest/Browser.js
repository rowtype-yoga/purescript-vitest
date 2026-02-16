import { expect } from "vitest";
import { page } from "@vitest/browser/context";

export { page };

export const gotoImpl = p => url => () => p.goto(url);

export const getByTestIdImpl = p => id => p.getByTestId(id);
export const getByRoleImpl = p => role => p.getByRole(role);
export const getByTextImpl = p => text => p.getByText(text);

export const expectToHaveScreenshotImpl = locator => name => () =>
  expect(locator).toHaveScreenshot(name);
