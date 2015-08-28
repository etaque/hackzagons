module Model.Collision
  ( playerTileCollision
  ) where

import Debug

import Model.Hexagon exposing (getTilePosition)

import Model.Position exposing (..)
import Model.Coords exposing (..)
import Model.Hexagon exposing (..)

import Constant.Size as Size

playerTileCollision : Position -> Position -> Bool
playerTileCollision playerPos tilePos =
  (  playerTileCircleCollision playerPos tilePos
  && playerTileExactCollision playerPos (segments (corners tilePos))
  )

playerTileCircleCollision : Position -> Position -> Bool
playerTileCircleCollision playerPos tilePos =
  (distance playerPos tilePos) < Size.playerRadius + Size.tileRadius

segments : List Position -> List (Position, Position)
segments points =
  case points of
    x :: y :: xs ->
      List.foldl
        (\newPoint acc ->
          case List.head acc of
            Just (p1, p2) ->
              (p2, newPoint) :: acc
            Nothing ->
              acc
        )
        [(x, y)]
        xs
    _ ->
      []

playerTileExactCollision : Position -> List (Position, Position) -> Bool
playerTileExactCollision p segments =
  case List.minimum (List.map (distPointSegment p) segments) of
    Just minDist ->
      minDist < Size.playerRadius
    Nothing ->
      False

-- Ref: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment
distPointSegment : Position -> (Position, Position) -> Float
distPointSegment p (v, w) =
  let l2 = squaredDistance v w
  in  if l2 == 0.0
        then
          distance p v
        else
          let t = ((p.x - v.x) * (w.x - v.x) + (p.y - v.y) * (w.y - v.y)) / l2
          in  if | t < 0.0 -> distance p v
                 | t > 1.0 -> distance p w
                 | otherwise ->
                     squaredDistance
                       p
                       { x = v.x + t * (w.x - v.x)
                       , y = v.y + t * (w.y - v.y)
                       }
