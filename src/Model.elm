module Model
  ( Map
  , Tile
  , map
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

map : Map
map =
  { position = (200.0, 100.0)
  , tiles =
      [ sandTile (0, 0)
      , sandTile (-1, 0)
      , sandTile (-2, 0)
      , sandTile (-2, -1)
      ]
  }

sandTile : (Int, Int) -> Tile
sandTile coords =
  { coords = coords
  , kind = Sand
  }
