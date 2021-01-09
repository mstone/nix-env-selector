{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "nix-env-selector"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "console"
  , "dotenv"
  , "effect"
  , "node-child-process"
  , "node-fs"
  , "node-fs-aff"
  , "prelude"
  , "psci-support"
  , "read"
  , "sunde"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
