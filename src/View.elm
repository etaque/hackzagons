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
    (  [ appDefs
       , background
       , title
       ]
    ++ hexagons map
    ++ [ player map.position ]
    )

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

hexagons : Map -> List Svg
hexagons map =
  let pos = { x = Size.boardWidth / 2, y = Size.boardHeight / 2 }
  in  List.map (\tile -> hexagon tile.kind (getNeighbor pos tile.coords)) map.tiles

hexagon : TileKind -> Position -> Svg
hexagon kind position =
  let
    hexagonPoints = toSvgPoints (corners position)
    bg = case kind of
           Sand -> Color.sand
           Rock -> Color.rock
  in  polygon
        [ fill bg
        , points hexagonPoints
        ]
        []

player : Position -> Svg
player {x, y} =
  circle
    [ cx (toString x)
    , cy (toString y)
    , r (toString Size.player)
    , fill Color.player
    ]
    []
