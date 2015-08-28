module Main
  ( main
  ) where

import Graphics.Element exposing (..)
import Text as T exposing (Text)
import Color as C

main : Element
main = leftAligned title

title : Text
title =
  T.fromString "Hackzagons"
    |> T.color C.orange
    |> T.height 40
    |> T.bold
