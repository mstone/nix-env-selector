module Main where

import Prelude
import Actions (getNixConfigs)
import Data.Array (head)
import Data.Maybe (Maybe(..), fromMaybe, isNothing)
import Data.String.Read (readDefault)
import Data.String (Pattern(..), Replacement(..), replace)
import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (logShow)
import Effect.Unsafe (unsafePerformEffect)
import VsCode.Commands (registerCommand)
import VsCode.ExtensionContext (ExtensionContext, subscriptions)
import VsCode.ExtensionContext.Subscriptions (push)
import VsCode.Window.QuickPick (QuickPickItems(..), showSimpleQuickPick)
import VsCode.Window.StatusBar (Aligment(..)) as Aligment
import VsCode.Window.StatusBar (Priority(..), createStatus, showStatus)
import VsCode.Workspace (workspaceFolders, getConfiguration)
import Node.ChildProcess as CP
import Sunde as S

type ConfigPickItem
  = { label :: String
    , value :: String
    }

type WorkspaceRoot
  = String

type ConfigName
  = String

makeConfigPickItem ::
  WorkspaceRoot ->
  ConfigName ->
  ConfigPickItem
makeConfigPickItem root configName =
  { label: configName
  , value: root <> "/" <> configName
  }

readBooleanOrFlase :: String -> Boolean
readBooleanOrFlase = readDefault

replaceWorkspaceToPath :: String -> String -> String
replaceWorkspaceToPath workspaceRoot =
  replace
    (Pattern "${workspaceRoot}")
    (Replacement workspaceRoot)

replacePathToWorkspace :: String -> String -> String
replacePathToWorkspace workspaceRoot =
  replace
    (Pattern workspaceRoot)
    (Replacement "${workspaceRoot}")

activateEff ::
  ExtensionContext ->
  Effect Unit
activateEff ctx =
  void do
    logShow "PureScript extension activated"
    maybeWorkspaceRoot <- (join <<< map head) <$> workspaceFolders
    logShow maybeWorkspaceRoot
    case maybeWorkspaceRoot of
      Just workspaceRoot -> do
        nixConfigPathRare <- getConfiguration "nixEnvSelector.nixShellConfig"
        isExtensionDisabled <-
          readBooleanOrFlase
            <<< fromMaybe "false"
            <$> getConfiguration "nixEnvSelector.disabled"
        logShow nixConfigPathRare
        let
          nixConfigPath = replaceWorkspaceToPath workspaceRoot <$> nixConfigPathRare
          status = createStatus (Priority 100) Aligment.Left
        if isExtensionDisabled || isNothing nixConfigPath then
          pure unit
        else
          showStatus "My status" "command" status
        disposable <-
          registerCommand "extension.selectEnv" do
            fiber <-
              launchAff do
                -- result <- S.spawn "ls" [] CP.defaultSpawnOptions
                -- liftEffect $ logShow result
                configList <- getNixConfigs workspaceRoot
                liftEffect $ logShow configList
                selectedItem <-
                  showSimpleQuickPick
                    $ QuickPickItems
                    $ (makeConfigPickItem workspaceRoot <$> configList)
                liftEffect $ logShow selectedItem
            pure unit
        ss <- subscriptions ctx
        push ss disposable
      Nothing -> pure unit

activate :: ExtensionContext -> Unit
activate ctx = unsafePerformEffect $ activateEff ctx

deactivate :: Effect Unit
deactivate = do
  logShow "PureScript extension deactivated"
