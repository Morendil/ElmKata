module Life exposing (view) -- where
import Html exposing (text)

world = [(0,0)]

view world = text <| toString world

main = view world