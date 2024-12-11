module ViTest where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Effect.Unsafe (unsafePerformEffect)
import Promise (Promise)
import Promise.Aff as Promise

foreign import data ViTest :: Type

foreign import testImpl :: EffectFn2 String (Effect (Promise (Unit))) ViTest
test :: String -> Aff Unit -> Effect ViTest
test desc = runEffectFn2 testImpl desc <<< Promise.fromAff

foreign import describeImpl :: EffectFn2 String (Effect ViTest) ViTest

describe :: String -> Effect ViTest -> Effect ViTest
describe = runEffectFn2 describeImpl

viTest :: Effect ViTest -> ViTest
viTest = unsafePerformEffect

foreign import beforeEachImpl :: EffectFn1 (Effect (Promise Unit)) Unit

beforeEach :: Aff Unit -> Effect Unit
beforeEach = runEffectFn1 beforeEachImpl <<< Promise.fromAff

foreign import afterEachImpl :: EffectFn1 (Effect (Promise Unit)) Unit

afterEach :: Aff Unit -> Effect Unit
afterEach = runEffectFn1 afterEachImpl <<< Promise.fromAff

foreign import beforeAllImpl :: EffectFn1 (Effect (Promise Unit)) Unit

beforeAll :: Aff Unit -> Effect Unit
beforeAll = runEffectFn1 beforeAllImpl <<< Promise.fromAff

foreign import afterAllImpl :: EffectFn1 (Effect (Promise Unit)) Unit

afterAll :: Aff Unit -> Effect Unit
afterAll = runEffectFn1 afterAllImpl <<< Promise.fromAff
