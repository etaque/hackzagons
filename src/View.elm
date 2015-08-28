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
    [ appDefs
    , background
    , title
    , hexagon Sand { x = 300, y = 200 }
    , player map.position
    ]

appDefs : Svg
appDefs =
  defs [ ]
    [ tilePattern "sandPattern" 360 360 "http://cdn.grid.fotosearch.com/CSP/CSP428/k4284340.jpg"
    ]

tilePattern : String -> Int -> Int -> String -> Svg
tilePattern pid w h url =
  pattern
    [ id pid
    , width (toString w), height (toString h)
    , patternUnits "userSpaceOnUser"
    ]
    [ image
      [ x "0", y "0"
      , width (toString w), height (toString h)
      , xlinkHref url
      ] [ ]
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

hexagon : TileKind -> Position -> Svg
hexagon kind position =
  let hexagonPoints = toSvgPoints (corners position)
  in  polygon
        [ fill Color.sand
        , points hexagonPoints
        ]
        []

player : Position -> Svg
player {x, y} =
  circle [ cx (toString x) , cy (toString y), r "4", fill "black" ] [ ]
