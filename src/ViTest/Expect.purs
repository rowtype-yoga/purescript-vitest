module ViTest.Expect where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)

foreign import expectToBeImpl :: forall a. a -> a -> Effect Unit

expectToBe :: forall a. a -> a -> Aff Unit
expectToBe a b = liftEffect $ expectToBeImpl a b

infixl 1 expectToBe as ====

foreign import unsafeStringify :: forall a. a -> String

foreign import expectToEqualImpl :: forall a. a -> a -> Effect Unit

expectToEqual :: forall a. Eq a => a -> a -> Aff Unit
expectToEqual a b = liftEffect $ expectToEqualImpl a b

infixl 1 expectToEqual as ===

foreign import expectToSatisfyImpl :: forall a. a -> (a -> Boolean) -> Effect Unit

expectToSatisfy :: forall a. a -> (a -> Boolean) -> Aff Unit
expectToSatisfy value predicate = liftEffect $ expectToSatisfyImpl value predicate
