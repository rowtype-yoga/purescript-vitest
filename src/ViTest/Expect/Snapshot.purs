module ViTest.Expect.Snapshot where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff (toAffE)

-- | Assert that `value` equals the snapshot stored at `path` on disk.
-- |
-- | On the first run vitest writes `value` to `path`. On subsequent runs the
-- | value is diffed against the file content; commit the file to gate
-- | regressions.
expectToMatchFileSnapshot :: String -> String -> Aff Unit
expectToMatchFileSnapshot value path = toAffE (expectToMatchFileSnapshotImpl value path)

foreign import expectToMatchFileSnapshotImpl :: String -> String -> Effect (Promise Unit)
