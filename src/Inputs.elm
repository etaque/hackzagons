module Inputs where

import Signal
import Keyboard


type alias Arrows = { x : Int, y : Int }

arrows : Signal Arrows
arrows =
  Keyboard.arrows
