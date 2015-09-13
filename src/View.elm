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


render : Model -> Html
render model =
  svg
    [ width "100%"
    , height "100%"
    , fill "black"
    ]
    [ renderTiles model
    -- , player model.center
    , renderMode model.mode
    ]

renderTiles : Model -> Svg
renderTiles {grid, dims, center} =
  let
    tiles = List.map renderTile (getTilesList grid)
    (w, h) = toPoint dims
    cx = w / 2 + fst center
    cy = h / 2 + snd center
  in
    g [ transform ("translate(" ++ toString cx ++ ", " ++ toString cy ++ ")")] tiles

renderTile : Tile -> Svg
renderTile {kind, coords} =
  let
    (x,y) = hexCoordsToPoint coords
    color = tileKindColor kind
    hex = polygon
      [ points Hexagon.verticesPoints
      , fill color
      , stroke color
      , strokeWidth "1"
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
      [ hex ]

tileKindColor : TileKind -> String
tileKindColor kind =
  case kind of
    Water -> Color.water
    Sand -> Color.sand
    Rock -> Color.rock

renderMode : Mode -> Svg
renderMode mode =
  let
    color =
      case mode of
        CreateTile kind ->
          tileKindColor kind
        Erase ->
          Color.grass
        Watch ->
          "white"
  in
    circle
      [ r "20"
      , fill color
      , stroke "white"
      , strokeWidth "2"
      , cx "50"
      , cy "50"
      ]
      []




-- player : Point -> Svg
-- player (x, y) =
--   circle
--     [ cx (toString x)
--     , cy (toString y)
--     , r (toString Size.playerRadius)
--     , stroke "white"
--     , strokeWidth "2"
--     , fill Color.player
--     ]
--     []
