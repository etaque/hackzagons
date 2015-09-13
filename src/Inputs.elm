module Inputs where

import Signal
import Keyboard
import Window
import DragAndDrop exposing (..)


type alias Input =
  { mouseEvent : MouseEvent
  , dims : (Int, Int)
  }

-- type alias Arrows = { x : Int, y : Int }

input : Signal Input
input =
  Signal.map2 Input mouseEvents dims

-- arrows : Signal Arrows
-- arrows =
--   Keyboard.arrows

dims : Signal (Int, Int)
dims =
  Window.dimensions

