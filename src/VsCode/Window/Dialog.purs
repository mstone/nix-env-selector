module VsCode.Window.Dialog where

import Prelude
import Effect (Effect)

foreign import showInformationMessage ::
  String ->
  Effect Unit
