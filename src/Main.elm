module Main
  ( main
  ) where

import Html exposing (Html)

import Model exposing (map)

import View exposing (board)

main : Html
main = board map
