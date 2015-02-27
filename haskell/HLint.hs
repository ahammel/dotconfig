module HLint where

import "hint" HLint.Builtin.All
import "hint" HLint.Default

warn = fmap f x             ==> f <$> x
warn = a $ b $ c            ==> a . b $ c
warn = a ++ b               ==> a <> b
warn = Data.Text.append a b ==> a <> b

ignore "Use camelCase"
