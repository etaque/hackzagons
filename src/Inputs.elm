module Inputs where

import Signal
import Keyboard
import Window
import DragAndDrop exposing (..)


dims : Signal (Int, Int)
dims =
  Window.dimensions

-- nextMode : Signal ()
-- nextMode
