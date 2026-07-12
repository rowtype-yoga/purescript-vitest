module Test.Main where

import Prelude

import Control.Monad.Error.Class (throwError)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (attempt)
import Effect.Exception (error)
import ViTest (describe, test, viTest)
import ViTest.Expect ((===))
import ViTest.Expect.Snapshot (expectToMatchFileSnapshot)

data Direction = North | South

derive instance Eq Direction

equalitySpec :: Effect Unit
equalitySpec = describe "ViTest.Expect equality" do
  test "uses PureScript Eq for nullary constructors" do
    North === North
    result <- attempt (North === South)
    case result of
      Left _ -> pure unit
      Right _ -> throwError (error "North === South unexpectedly passed")

snapshotSpec :: Effect Unit
snapshotSpec = describe "ViTest.Expect.Snapshot" do
  test "writes the baseline on first run and diffs it on subsequent runs"
    $ expectToMatchFileSnapshot rendered "./__snapshots__/hello.txt"
  where
  rendered = "hello, world\n"

main :: Unit
main = viTest do
  snapshotSpec
  equalitySpec
