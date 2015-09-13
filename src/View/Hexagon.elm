module View.Hexagon where

import List
import String

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Model exposing (..)

import Constant.Size as Size
import Constant.Color as Color


verticesPoints : String
verticesPoints =
  toSvgPoints vertices

vertices : List Point
vertices =
  let
    (w,h) = Size.hexDims
    w2 = w / 2
    h2 = h / 2
    h4 = h / 4
  in
    [ (-w2, -h4)
    , (0, -h2)
    , (w2, -h4)
    , (w2, h4)
    , (0, h2)
    , (-w2, h4)
    ]

toSvgPoints : List Point -> String
toSvgPoints points =
  points
    |> List.map (\(x, y) -> toString x ++ "," ++ toString y)
    |> String.join " "
