module Update where

import Maybe

import Inputs exposing (..)
import Model exposing (..)

import Constant.Size as Size

import DragAndDrop exposing (MouseEvent(..))


update : Input -> Map -> Map
update {mouseEvent,dims} map =
  let
    draggedPoint =
      case mouseEvent of
        StartAt p -> Just p
        MoveFromTo p _ -> Just p
        EndAt _ -> Nothing
    coords = Maybe.map (toPoint >> pointToHexCoords) draggedPoint
    newGrid = Maybe.map (\c -> createTile Sand c map.grid) coords
      |> Maybe.withDefault map.grid
  in
    { map | grid <- newGrid, dims <- dims }

toPoint : (Int, Int) -> Point
toPoint (x, y) =
  (toFloat x, toFloat y)

-- updatePosition : Arrows -> Point -> Point
-- updatePosition a (x, y) =
--   ( clamp Size.playerRadius (Size.boardWidth - Size.playerRadius) (x + 2 * (toFloat a.x))
--   , clamp Size.playerRadius (Size.boardHeight - Size.playerRadius) (y - 2 * (toFloat a.y))
--   )
