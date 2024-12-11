module ViTest.Expect where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)

foreign import expectToBeImpl :: forall a. a -> a -> Effect Unit

expectToBe :: forall a. a -> a -> Aff Unit
expectToBe a b = liftEffect $ expectToBeImpl a b

infixl 1 expectToBe as ====
