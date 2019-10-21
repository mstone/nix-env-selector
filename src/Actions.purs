module Actions where

import Prelude

import Data.Array (filter)
import Data.Maybe (isJust)
import Data.String (Pattern(..), stripSuffix)
import Effect.Aff (Aff)
import Node.FS.Aff (readdir)

isNixConfigFile :: String -> Boolean
isNixConfigFile = isJust <<< (stripSuffix $ Pattern ".nix")

getNixConfigs :: String -> Aff (Array String)
getNixConfigs path = filter isNixConfigFile <$> readdir path


