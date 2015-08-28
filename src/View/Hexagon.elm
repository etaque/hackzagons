module View.Hexagon
  ( corners
  ) where

import List

import Model.Position exposing (..)

corners : Position -> Float -> List Position
corners center size = List.map (corner center size) [0..5]

corner : Position -> Float -> Int -> Position
corner center size i =
  let angleDeg = 60 * i + 20
      angleRad = pi / 180 * angleDeg
  in  { x = center.x + size * (cos angleRad)
      , y = center.y + size * (sin angleRad)
      }
