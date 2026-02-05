module ViTest.Expect.Either where

import Prelude

import Data.Either (Either(..), either)
import Effect.Aff (Aff)
import ViTest.Expect (expectToBe, expectToEqual)

-- | Assert that a value is Right with a specific value
expectRight :: forall e a. Eq a => Show e => a -> Either e a -> Aff Unit
expectRight expected result = case result of
  Right actual -> expectToEqual expected actual
  Left err -> expectToBe true false -- Always fails, shows error in output

-- | Assert that a value is Right (don't care about the value)
expectIsRight :: forall e a. Show e => Either e a -> Aff Unit
expectIsRight result = case result of
  Right _ -> expectToBe true true
  Left err -> expectToBe true false

-- | Assert that a value is Left with a specific error
expectLeft :: forall e a. Eq e => Show a => e -> Either e a -> Aff Unit
expectLeft expected result = case result of
  Left actual -> expectToEqual expected actual
  Right val -> expectToBe true false

-- | Assert that a value is Left (don't care about the error)
expectIsLeft :: forall e a. Show a => Either e a -> Aff Unit
expectIsLeft result = case result of
  Left _ -> expectToBe true true
  Right val -> expectToBe true false

-- | Assert that a Left contains a specific substring in its error
expectLeftContains :: forall a. Show a => String -> Either String a -> Aff Unit
expectLeftContains needle result = case result of
  Left err -> 
    if contains needle err
    then expectToBe true true
    else expectToBe true false -- Fails with message about not containing
  Right val -> expectToBe true false
  where
    contains :: String -> String -> Boolean
    contains n h = indexOf n h >= 0
    
    indexOf :: String -> String -> Int
    indexOf = indexOfImpl
    
foreign import indexOfImpl :: String -> String -> Int
