module Model.Collision
  ( playerTileCollision
  ) where

import Model.Hexagon exposing (getTilePosition)

import Model.Position exposing (..)
import Model.Coords exposing (..)

import Constant.Size as Size

playerTileCollision : Position -> Position -> Bool
playerTileCollision playerPos tilePos =
  (distance playerPos tilePos) < Size.playerRadius + Size.tileRadius
