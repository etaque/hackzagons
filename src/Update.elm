module Update where

import Inputs exposing (..)

import Model exposing (..)
import Model.Position exposing (..)

import Constant.Size as Size

update : Input -> Map -> Map
update {arrows,dims} map =
  let
    newPosition = updatePosition arrows map.position
  in
    { map | position <- newPosition, dims <- dims }

updatePosition : Arrows -> Position -> Position
updatePosition a p =
  { x = clamp Size.playerRadius (Size.boardWidth - Size.playerRadius) (p.x + 2 * (toFloat a.x))
  , y = clamp Size.playerRadius (Size.boardHeight - Size.playerRadius) (p.y - 2 * (toFloat a.y))
  }
