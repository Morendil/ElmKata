module Life exposing (view, evolve) -- where
import Html exposing (text)
import String exposing (concat)
import List exposing (length)

world = [(0,0)]

view cells =
    case cells of
        []          -> text "The world is empty"
        otherwise   -> text <| concat ["The world has population ", toString <| length cells, " ", toString cells]

evolve word = []

main = view world