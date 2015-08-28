module View.Hexagon
  ( corners
  ) where

import List

import Model.Position exposing (..)

corners : Position -> Float -> List Position
corners center size = List.map (corner center size) [0..5]

corner : Position -> Float -> Int -> Position
corner center size i =
  let angle = degrees (toFloat (60 * i))
  in  { x = center.x + size * (cos angle)
      , y = center.y + size * (sin angle)
      }
