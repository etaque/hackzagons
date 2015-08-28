module Model.Hexagon
  ( getTilePosition
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
