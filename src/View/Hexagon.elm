module View.Hexagon
  ( corners
  , toSvgPoints
  ) where

import List
import String

import Model.Position exposing (..)

import Constant.Size exposing (tileRadius)

corners : Position -> List Position
corners center =
  List.map (corner center) [0..5]

corner : Position -> Int -> Position
corner center i =
  let angle = degrees (60 * toFloat(i) + 30)
  in  { x = center.x + tileRadius * (cos angle)
      , y = center.y + tileRadius * (sin angle)
      }

toSvgPoints : List Position -> String
toSvgPoints points =
  points
    |> List.map (\{x, y} -> (toString x) ++ "," ++ (toString y))
    |> String.join " "
