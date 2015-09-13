module Main
  ( main
  ) where

import Html exposing (Html)
import Signal
import Keyboard
import Time exposing (fps)
import DragAndDrop exposing (mouseEvents)

import Model exposing (..)
import Inputs exposing (..)
import Update exposing (update, Action(..))

import View exposing (render)


actions : Signal Action
actions =
  Signal.mergeMany
    [ Signal.map MouseAction mouseEvents
    , Signal.map UpdateDims dims
    , Signal.map (\b -> if b then NextTileKind else NoOp) Keyboard.space
    , Signal.map (\b -> if b then EscapeMode else NoOp) (Keyboard.isDown 27)
    ]

state : Signal Model
state = Signal.foldp update initialModel actions

main : Signal Html
main = Signal.map render state

-- port grid : Signal Grid
-- port grid =
--   Signal.map .grid state
