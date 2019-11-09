{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "nix-env-selector"
, dependencies =
    [ "aff"
    , "console"
    , "effect"
    , "node-child-process"
    , "node-fs"
    , "node-fs-aff"
    , "prelude"
    , "psci-support"
    , "read"
    , "aff-promise"
    , "sunde"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
