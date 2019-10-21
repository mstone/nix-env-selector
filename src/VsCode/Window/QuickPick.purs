module VsCode.Window.QuickPick
  ( showQuickPick
  , QuickPickItems(..)
  , showSimpleQuickPick
  ) where

import Prelude
import Control.Promise (Promise, toAff)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Effect.Aff (Aff)

type QuickPickOptions
  = { matchOnDescription :: Maybe Boolean -- An optional flag to include the description when filtering the picks.
    , matchOnDetail :: Maybe Boolean -- An optional flag to include the detail when filtering the picks
    , placeHolder :: Maybe String -- An optional string to show as place holder in the input box to guide the user what to pick on.
    , ignoreFocusOut :: Maybe Boolean -- Set to `true` to keep the picker open when focus moves to another part of the editor or to another window.
    , canPickMany :: Maybe Boolean -- An optional flag to make the picker accept multiple selections, if true the result is an array of picks.
    }

type QuickPickJsOptions
  = { matchOnDescription :: Nullable Boolean -- An optional flag to include the description when filtering the picks.
    , matchOnDetail :: Nullable Boolean -- An optional flag to include the detail when filtering the picks
    , placeHolder :: Nullable String -- An optional string to show as place holder in the input box to guide the user what to pick on.
    , ignoreFocusOut :: Nullable Boolean -- Set to `true` to keep the picker open when focus moves to another part of the editor or to another window.
    , canPickMany :: Nullable Boolean -- An optional flag to make the picker accept multiple selections, if true the result is an array of picks.
    }

quickPickOptionsDefault :: QuickPickOptions
quickPickOptionsDefault =
  { placeHolder: Nothing
  , canPickMany: Nothing
  , ignoreFocusOut: Nothing
  , matchOnDescription: Just true
  , matchOnDetail: Just false
  }

newtype QuickPickItems a
  = QuickPickItems (Array a)

foreign import showQuickPickJs ::
  forall a.
  QuickPickJsOptions ->
  QuickPickItems a ->
  Promise (Nullable a)

showQuickPick ::
  forall a.
  QuickPickOptions ->
  QuickPickItems a ->
  Aff (Maybe a)
showQuickPick options items = toMaybe <$> (toAff $ showQuickPickJs jsOptions items)
  where
  jsOptions :: QuickPickJsOptions
  jsOptions =
    { matchOnDescription: toNullable options.matchOnDescription
    , matchOnDetail: toNullable options.matchOnDetail
    , placeHolder: toNullable options.placeHolder
    , ignoreFocusOut: toNullable options.ignoreFocusOut
    , canPickMany: toNullable options.canPickMany
    }

showSimpleQuickPick ::
  forall a.
  QuickPickItems a ->
  Aff (Maybe a)
showSimpleQuickPick = showQuickPick quickPickOptionsDefault
