module View where

import Html exposing (Html)
import Html.Lazy exposing (lazy)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import List
import String
import Dict

import Constant.Size as Size
import Constant.Color as Color

import Model exposing (..)
import View.Hexagon as Hexagon


board : Map -> Html
board map =
  lazy renderBoard map

renderBoard : Map -> Html
renderBoard map =
  svg
    [ width "100%"
    , height "100%"
    ]
    [ renderTiles map.coords map.grid
    , player map.position
    ]

renderTiles : Coords -> Grid -> Svg
renderTiles playerCoords grid =
  let
    tiles = List.map (renderTile playerCoords) (getTilesList grid)
  in
    g [] tiles

renderTile : Coords -> Tile -> Svg
renderTile playerCoords {kind, coords} =
  let
    (x,y) = hexCoordsToPoint coords
    playerTile = playerCoords == coords
    color = case kind of
      Sand -> Color.sandTile
      Rock -> Color.rockTile
    hex = polygon
      [ points Hexagon.verticesPoints
      , fill color
      , stroke color
      , strokeWidth "0.5"
      , opacity (if playerTile then "0.5" else "1")
      ]
      []
    label = text'
      [ fill "black"
      , textAnchor "middle"
      , fontSize "10px"
      ]
      [ text (toString coords) ]
  in
    g [ transform ("translate(" ++ toString x ++ ", " ++ toString y ++ ")") ]
      [ hex, label ]

player : Point -> Svg
player (x, y) =
  circle
    [ cx (toString x)
    , cy (toString y)
    , r (toString Size.playerRadius)
    , stroke "white"
    , strokeWidth "2"
    , fill Color.player
    ]
    []
