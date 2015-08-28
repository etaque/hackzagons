module View.Hexagon
  ( corners, toSvgPoints
  ) where

import List
import String

import Constant.Size exposing (hexagonSize)

import Model.Position exposing (..)

corners : Position -> List Position
corners center =
  List.map (corner center) [0..5]

corner : Position -> Int -> Position
corner center i =
  let angle = degrees (toFloat (60 * i))
  in  { x = center.x + hexagonSize * (cos angle)
      , y = center.y + hexagonSize * (sin angle)
      }

toSvgPoints : List Position -> String
toSvgPoints points =
  points
    |> List.map (\{x, y} -> (toString x) ++ "," ++ (toString y))
    |> String.join " "
