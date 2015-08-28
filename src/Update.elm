module Update where

import Inputs exposing (..)
import Model exposing (..)
import Model.Position exposing (..)


update : Input -> Map -> Map
update {arrows,dims} map =
  let
    newPosition = updatePosition arrows map.position
  in
    { map | position <- newPosition, dims <- dims }

updatePosition : Arrows -> Position -> Position
updatePosition a p =
  { x = p.x + 2 * (toFloat a.x)
  , y = p.y - 2 * (toFloat a.y)
  }
