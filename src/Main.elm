module Main
  ( main
  ) where

import Html exposing (Html)
import Signal
import Time exposing (fps)

import Model exposing (Map, initialMap)
import Inputs exposing (..)
import Update exposing (update)

import View exposing (board)

input : Signal Arrows
input = Signal.sampleOn (fps 60) arrows

mapState : Signal Map
mapState = Signal.foldp update initialMap input

main : Signal Html
main = Signal.map board mapState
