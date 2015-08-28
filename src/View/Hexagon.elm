module View.Hexagon
  ( corners
  , toSvgPoints
  , getNeighbor
  ) where

import List
import String

import Constant.Size exposing (hexagonRadius)

import Model.Position exposing (..)
import Model.Coords exposing (..)

corners : Position -> List Position
corners center =
  List.map (corner center) [0..5]

corner : Position -> Int -> Position
corner center i =
  let angle = degrees (60 * toFloat(i) + 30)
  in  { x = center.x + hexagonRadius * (cos angle)
      , y = center.y + hexagonRadius * (sin angle)
      }

toSvgPoints : List Position -> String
toSvgPoints points =
  points
    |> List.map (\{x, y} -> (toString x) ++ "," ++ (toString y))
    |> String.join " "

getNeighbor : Position -> Coords -> Position
getNeighbor center coords =
  { x = center.x + 2 * hexagonRadius * (toFloat(coords.x) + toFloat(coords.y) * cos(degrees 60.0))
  , y = center.y + 2 * hexagonRadius * toFloat(coords.y) * sin(degrees 60.0)
  }
