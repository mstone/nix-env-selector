module VsCode.Workspace (workspaceFolders, getConfiguration) where

import Prelude
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

type ConfigSelector
  = String

foreign import workspaceFoldersJs :: Effect (Nullable (Array String))

foreign import getConfigurationJs ::
  ConfigSelector ->
  Effect (Nullable String)

workspaceFolders :: Effect (Maybe (Array String))
workspaceFolders = toMaybe <$> workspaceFoldersJs

getConfiguration ::
  ConfigSelector ->
  Effect (Maybe String)
getConfiguration configPath = toMaybe <$> getConfigurationJs configPath
