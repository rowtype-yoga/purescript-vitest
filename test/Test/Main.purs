module Test.Main where

import Prelude

import Effect (Effect)
import ViTest (describe, test, viTest)
import ViTest.Expect.Snapshot (expectToMatchFileSnapshot)

snapshotSpec :: Effect Unit
snapshotSpec = describe "ViTest.Expect.Snapshot" do
  test "writes the baseline on first run and diffs it on subsequent runs"
    $ expectToMatchFileSnapshot rendered "./__snapshots__/hello.txt"
  where
  rendered = "hello, world\n"

main :: Unit
main = viTest do
  snapshotSpec
