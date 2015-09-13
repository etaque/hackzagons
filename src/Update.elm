module Update where

import Maybe

import Inputs exposing (..)
import Model exposing (..)

import Constant.Size as Size

import DragAndDrop exposing (MouseEvent(..))


type Action
  = MouseAction MouseEvent
  | UpdateDims (Int, Int)
  | NextTileKind
  | EscapeMode
  | NoOp


update : Action -> Model -> Model
update action model =
  case action of

    UpdateDims dims ->
      { model | dims <- dims }

    MouseAction event ->
      case model.mode of
        CreateTile kind ->
          updateTileEvent kind event model
        Erase ->
          deleteTileEvent event model
        Watch ->
          updateCenter event model

    NextTileKind ->
      { model | mode <- getNextMode model.mode }

    EscapeMode ->
      { model | mode <- Watch }

    _ ->
      model

deleteTileEvent : MouseEvent -> Model -> Model
deleteTileEvent event model =
  let
    coordsMaybe = getMouseEventTile model event
    newGrid = Maybe.map (\c -> deleteTile c model.grid) coordsMaybe
      |> Maybe.withDefault model.grid
  in
    { model | grid <- newGrid }

updateTileEvent : TileKind -> MouseEvent -> Model -> Model
updateTileEvent kind event model =
  let
    coordsMaybe = getMouseEventTile model event
    newGrid = Maybe.map (\c -> createTile kind c model.grid) coordsMaybe
      |> Maybe.withDefault model.grid
  in
    { model | grid <- newGrid }

getMouseEventTile : Model -> MouseEvent -> Maybe Coords
getMouseEventTile model event =
  let
    pointMaybe =
      case event of
        StartAt p -> Just p
        MoveFromTo p _ -> Just p
        EndAt _ -> Nothing
  in
    Maybe.map ((clickPoint model) >> pointToHexCoords) pointMaybe

clickPoint : Model -> (Int, Int) -> Point
clickPoint {dims, center} (x, y) =
  let
    (w, h) = dims
    (cx, cy) = center
  in
    ( toFloat x - cx - toFloat w / 2
    , toFloat y - cy - toFloat h / 2
    )

updateCenter : MouseEvent -> Model -> Model
updateCenter event ({center} as model) =
  let
    (dx, dy) =
      case event of
        StartAt _ ->
          (0, 0)
        MoveFromTo (xa, ya) (xb, yb) ->
          (xb - xa, yb - ya)
        EndAt _ ->
          (0, 0)
    newCenter = (fst center + toFloat dx, snd center + toFloat dy)
  in
    { model | center <- newCenter }

getNextMode : Mode -> Mode
getNextMode mode =
  case mode of
    CreateTile Water ->
      CreateTile Sand
    CreateTile Sand ->
      CreateTile Rock
    CreateTile Rock ->
      Erase
    _ ->
      CreateTile Water

