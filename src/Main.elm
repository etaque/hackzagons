module Main
  ( main
  ) where

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)

import Constant.Size as Size
import Constant.Color as Color

main : Html
main =
  svg
    [ width (toString Size.boardWidth)
    , height (toString Size.boardHeight)
    ]
    [ background
    , title
    ]

background : Svg
background =
  rect
    [ width (toString Size.boardWidth)
    , height (toString Size.boardHeight)
    , fill Color.background
    ]
    []

title : Svg
title =
  text'
    [ x "5"
    , y (toString (Size.title + 5))
    , fill Color.title
    , fontSize (toString Size.title)
    ]
    [ text "Hackzagons" ]
