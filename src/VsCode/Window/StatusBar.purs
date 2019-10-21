module VsCode.Window.StatusBar
  ( Priority(..)
  , Aligment(..)
  , StatusBar
  , createStatus
  , showStatus
  , hideStatus
  ) where

import Prelude
import Effect (Effect)

data Aligment
  = Left
  | Right

newtype Priority
  = Priority Int

foreign import data StatusBar :: Type

foreign import createStatusJs ::
  Int ->
  Int ->
  StatusBar

createStatus ::
  Priority ->
  Aligment ->
  StatusBar
createStatus (Priority priority) aligment = createStatusJs priority $ aligmentNumber
  where
  aligmentNumber = case aligment of
    Left -> 1 :: Int
    Right -> 2 :: Int

foreign import showStatus ::
  String ->
  String ->
  StatusBar ->
  Effect Unit

foreign import hideStatus ::
  StatusBar ->
  Effect Unit
