-- | Browser-mode smoke spec. Compiles always but only executes under a
-- | vitest browser runner (`@vitest/browser` as a peer); skipped otherwise.
module Test.Browser where

import Prelude

import Effect (Effect)
import ViTest (describe, test, viTest)
import ViTest.Browser (expectToHaveScreenshot, getByTestId, goto, page)

browserSpec :: Effect Unit
browserSpec = describe "ViTest.Browser" do
  test "pixel-diffs a rendered locator against a committed PNG" do
    goto page "/fixtures/hello.html"
    expectToHaveScreenshot (getByTestId page "hello") "hello.png"

main :: Unit
main = viTest do
  browserSpec
