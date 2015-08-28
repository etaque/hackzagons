module View
  ( board
  ) where

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import List
import String

import Constant.Size as Size
import Constant.Color as Color

import Model exposing (..)
import Model.Position exposing (..)

import View.Hexagon exposing (..)

board : Map -> Html
board map =
  svg
    [ width (toString Size.boardWidth)
    , height (toString Size.boardHeight)
    ]
    [ background
    , title
    , hexagon { x = 300, y = 200 }
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

hexagon : Position -> Svg
hexagon position =
  let hexagonPoints = toSvgPoints (corners position)
  in  polygon
        [ fill Color.sand
        , points hexagonPoints
        ]
        []
