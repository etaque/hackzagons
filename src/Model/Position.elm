module Model.Position
  ( Position
  , distance
  , squaredDistance
  ) where

type alias Position =
  { x : Float
  , y : Float
  }

distance : Position -> Position -> Float
distance p1 p2 = sqrt ((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2)

squaredDistance : Position -> Position -> Float
squaredDistance p1 p2 = (abs ((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2)) ^ 2
