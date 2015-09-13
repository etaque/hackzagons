module Model where

import Dict exposing (Dict)

import Constant.Size exposing (..)
import Constant.Color exposing (..)


type alias Map =
  { position : Point
  , coords : Coords
  , dims : (Int, Int)
  , grid : Grid
  }

type alias Grid = Dict Int GridRow
type alias GridRow = Dict Int TileKind

type alias Tile =
  { kind : TileKind
  , coords : Coords
  }

type TileKind = Sand | Rock

type alias Coords = (Int, Int)
type alias Point = (Float, Float)

type alias Cube number = (number, number, number)


initialMap : Map
initialMap =
  { position = (0, 0)
  , coords = (0, 0)
  , dims = (800, 600)
  , grid = Dict.fromList
    [ (0, Dict.fromList
        [ (1, Sand)
        , (2, Rock)
        , (3, Sand)
        , (5, Sand)
        ]
      )
    , (1, Dict.fromList
        [ (2, Sand)
        , (3, Rock)
        , (4, Sand)
        ]
      )
    , (2, Dict.fromList
        [ (1, Sand)
        , (2, Sand)
        , (3, Sand)
        , (4, Sand)
        ]
      )
    ]
  }


createTile : TileKind -> Coords -> Grid -> Grid
createTile kind (i,j) grid =
  let
    updateRow : Maybe GridRow -> GridRow
    updateRow maybeRow =
      case maybeRow of
        Just row ->
          Dict.insert j kind row
        Nothing ->
          Dict.singleton j kind
  in
    Dict.insert i (updateRow (Dict.get i grid)) grid


hexCoordsToPoint : Coords -> Point
hexCoordsToPoint (i, j) =
  let
    x = hexRadius * (sqrt 3) * (toFloat i + toFloat j / 2)
    y = hexRadius * 3 / 2 * toFloat j
  in
    (x, y)

pointToHexCoords : Point -> Coords
pointToHexCoords (x, y) =
  let
    i = (x * (sqrt 3) / 3 - y / 3) / hexRadius
    j = y * (2 / 3) / hexRadius
  in
    hexRound (i, j)

hexRound : (Float, Float) -> Coords
hexRound =
  hexToCube >> cubeRound >> cubeToHex

cubeRound : Cube Float -> Cube Int
cubeRound (x, y, z) =
  let
    rx = round x
    ry = round y
    rz = round z

    xDiff = abs (toFloat rx - x)
    yDiff = abs (toFloat ry - y)
    zDiff = abs (toFloat rz - z)
  in
    if | xDiff > yDiff && xDiff > zDiff -> (-ry-rz, ry, rz)
       | yDiff > zDiff                  -> (rx, -rx-rz, rz)
       | otherwise                      -> (rx, ry, -rx-ry)

cubeToHex : Cube number -> (number, number)
cubeToHex (x, y, z) =
  (x, y)

hexToCube : (number, number) -> Cube number
hexToCube (i, j) =
  (i, j, -i-j)


getTilesList : Grid -> List Tile
getTilesList grid =
  let
    rows : List (Int, GridRow)
    rows =
      Dict.toList grid

    mapRow : (Int, GridRow) -> List Tile
    mapRow (i, row) =
      List.map (mapTile i) (Dict.toList row)

    mapTile : Int -> (Int, TileKind) -> Tile
    mapTile i (j, kind) =
      Tile kind (i, j)
  in
    List.map mapRow rows
      |> List.concat


