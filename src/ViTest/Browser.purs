module ViTest.Browser
  ( Page
  , Locator
  , page
  , goto
  , getByTestId
  , getByRole
  , getByText
  , expectToHaveScreenshot
  ) where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff (toAffE)

-- | Handle to the vitest-browser `page` context, the entry point for
-- | navigation and locator queries during a browser-mode test run.
foreign import data Page :: Type

-- | Handle to a deferred element query. Locators evaluate lazily and retry
-- | until they resolve, which keeps tests stable across async renders.
foreign import data Locator :: Type

-- | The singleton `page` re-exported from `@vitest/browser/context`.
foreign import page :: Page

goto :: Page -> String -> Aff Unit
goto p url = toAffE (gotoImpl p url)

getByTestId :: Page -> String -> Locator
getByTestId = getByTestIdImpl

getByRole :: Page -> String -> Locator
getByRole = getByRoleImpl

getByText :: Page -> String -> Locator
getByText = getByTextImpl

-- | Pixel-diff the rendered locator against the PNG committed at `name`.
-- |
-- | The first run writes the baseline; subsequent runs fail when the rendered
-- | bytes drift outside vitest's configured threshold.
expectToHaveScreenshot :: Locator -> String -> Aff Unit
expectToHaveScreenshot loc name = toAffE (expectToHaveScreenshotImpl loc name)

foreign import gotoImpl :: Page -> String -> Effect (Promise Unit)
foreign import getByTestIdImpl :: Page -> String -> Locator
foreign import getByRoleImpl :: Page -> String -> Locator
foreign import getByTextImpl :: Page -> String -> Locator
foreign import expectToHaveScreenshotImpl :: Locator -> String -> Effect (Promise Unit)
