module Model.Position
  ( Position
  , distance
  ) where

type alias Position =
  { x : Float
  , y : Float
  }

distance : Position -> Position -> Float
distance p1 p2 = sqrt ((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2)
