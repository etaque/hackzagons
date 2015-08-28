module Model
  ( Map
  , Tile
  , TileKind (..)
  , initialMap
  ) where

import Model.Position exposing (..)
import Model.Coords exposing (..)

type alias Map =
  { position : Position
  , tiles : List Tile
  }

type alias Tile =
  { coords : Coords
  , kind : TileKind
  }

type TileKind = Sand | Rock

initialMap : Map
initialMap =
  { position =
      { x = 300.0
      , y = 250.0
      }
  , tiles =
      [ sandTile { x =  0, y =  0 }
      , sandTile { x = -1, y =  0 }
      , sandTile { x = -2, y =  0 }
      , sandTile { x = -2, y = -1 }
      , sandTile { x = -2, y =  1 }
      , sandTile { x = -3, y =  1 }
      , rockTile { x =  0, y = -1 }
      , rockTile { x = -1, y = -1 }
      , rockTile { x =  0, y = -2 }
      , rockTile { x =  1, y = -3 }
      ]
  }

sandTile : Coords -> Tile
sandTile coords =
  { coords = coords
  , kind = Sand
  }

rockTile : Coords -> Tile
rockTile coords =
  { coords = coords
  , kind = Rock
  }
