module Life exposing (view, evolve, neighbours) -- where
import Html exposing (text)
import Html.App exposing (program)
import String exposing (concat)
import List exposing (length, map, concatMap, drop)
import Time exposing (Time, second)

type Event = Tick Time

world = [(0,0)]

evolve word = []

neighbours (x,y) =
    map (\ (ox,oy) -> (x+ox,y+oy)) neighbourOffsets

neighbourOffsets =
    let offsets = [0,1,-1]
        pairWith offsets x = map ((,) x) offsets
    in drop 1 <| concatMap (pairWith offsets) offsets

view cells =
    case cells of
        []          -> text "The world is empty"
        otherwise   -> text <| concat ["The world has population ", toString <| length cells, " ", toString cells]

update event model = (evolve model, Cmd.none)

main = program
    {
    init = (world, Cmd.none),
    view = view,
    update = update,
    subscriptions = always (Time.every second Tick)
    }