module Model.Hexagon
  ( getTilePosition
  , corners
  ) where

import Model.Position exposing (..)
import Model.Coords exposing (..)

import Constant.Size exposing (..)

getTilePosition : Coords -> Position
getTilePosition coords =
  let dist = 1.725 * tileRadius
  in  { x = tilesCenterX + dist * (toFloat(coords.x) + toFloat(coords.y) * cos(degrees 60.0))
      , y = tilesCenterY + dist * toFloat(coords.y) * sin(degrees 60.0)
      }

corners : Position -> List Position
corners center =
  List.map (corner center) [0..5]

corner : Position -> Int -> Position
corner center i =
  let angle = degrees (60 * toFloat(i) + 30)
  in  { x = center.x + tileRadius * (cos angle)
      , y = center.y + tileRadius * (sin angle)
      }
