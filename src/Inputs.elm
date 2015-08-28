module Inputs where

import Signal
import Keyboard
import Window


type alias Input =
  { arrows : Arrows
  , dims : (Int, Int)
  }

type alias Arrows = { x : Int, y : Int }

input : Signal Input
input =
  Signal.map2 Input arrows dims

arrows : Signal Arrows
arrows =
  Keyboard.arrows

dims : Signal (Int, Int)
dims =
  Window.dimensions

