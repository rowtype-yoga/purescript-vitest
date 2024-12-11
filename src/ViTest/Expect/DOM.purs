module ViTest.Expect.DOM where

import Prelude

import Control.Monad.Error.Class (class MonadThrow)
import Data.Maybe (Maybe(Just, Nothing))
import Data.Nullable (toMaybe) as Nullable
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error, throw)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.Element (getAttribute) as Element
import Web.DOM.Node (textContent)
import Web.HTML.HTMLElement (HTMLElement)
import Web.HTML.HTMLElement (toElement, toNode) as HTMLElement

elemText :: forall m. Bind m => MonadEffect m => MonadThrow Error m => HTMLElement -> m String
elemText elem = do
  liftEffect $ textContent $ HTMLElement.toNode elem

elemValue :: HTMLElement -> Aff String
elemValue elem = do
  case Nullable.toMaybe (unsafeCoerce elem).value of
    Just v -> pure v
    Nothing -> (throw $ "Element does not have a value") # liftEffect

elemInnerHTML :: HTMLElement -> Aff String
elemInnerHTML elem = do
  case Nullable.toMaybe (unsafeCoerce elem).innerHTML of
    Just v -> pure v
    Nothing -> (throw $ "Element does not have innerHTML") # liftEffect

elemAttribute :: HTMLElement -> String -> Aff String
elemAttribute x attr = do
  maybeAttrValue <- Element.getAttribute attr (HTMLElement.toElement x) # liftEffect
  case maybeAttrValue of
    Just v -> pure v
    Nothing -> (throw $ "HTMLElement does not have attribute: " <> attr) # liftEffect
