module View.Hexagon
  ( toSvgPoints
  ) where

import List
import String

import Model.Position exposing (..)

import Constant.Size exposing (tileRadius)

toSvgPoints : List Position -> String
toSvgPoints points =
  points
    |> List.map (\{x, y} -> (toString x) ++ "," ++ (toString y))
    |> String.join " "
