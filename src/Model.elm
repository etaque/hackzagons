module Model
  ( Map
  , Tile
  ) where

type alias Map =
  { position : (Float, Float)
  , tiles : List Tile
  }

type alias Tile =
  { coords : (Int, Int)
  , kind : TileKind
  }
type TileKind = Sand | Rock
