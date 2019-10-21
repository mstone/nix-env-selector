module VsCode.ExtensionContext.Subscriptions where

import Prelude

import Effect (Effect)
import VsCode.Disposable (Disposable)

foreign import data Subscriptions :: Type

foreign import push ::
  Subscriptions ->
  Disposable ->
  Effect Unit
