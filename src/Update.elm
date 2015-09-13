module Update where

import Inputs exposing (..)
import Model exposing (..)

import Constant.Size as Size


update : Input -> Map -> Map
update {arrows,dims} map =
  let
    newPosition = updatePosition arrows map.position
    newCoords = pointToHexCoords newPosition
  in
    { map | position <- newPosition, coords <- newCoords, dims <- dims }

updatePosition : Arrows -> Point -> Point
updatePosition a (x, y) =
  ( clamp Size.playerRadius (Size.boardWidth - Size.playerRadius) (x + 2 * (toFloat a.x))
  , clamp Size.playerRadius (Size.boardHeight - Size.playerRadius) (y - 2 * (toFloat a.y))
  )
