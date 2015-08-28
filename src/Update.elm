module Update where

import Inputs exposing (Arrows)
import Model exposing (..)
import Model.Position exposing (..)


update : Arrows -> Map -> Map
update arrows map =
  let
    newPosition = updatePosition arrows map.position
  in
    { map | position <- newPosition }

updatePosition : Arrows -> Position -> Position
updatePosition a p =
  { x = p.x + 2 * (toFloat a.x)
  , y = p.y - 2 * (toFloat a.y)
  }
