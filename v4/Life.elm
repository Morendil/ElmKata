module Life exposing (debug, evolve, neighbours, countNeighbours) -- where
import Html exposing (text, div)
import Html.App exposing (program)
import String exposing (concat)
import List exposing (length, map, concatMap, drop, member)
import Time exposing (..)
import Collage exposing (filled, rect, collage, move)
import Color exposing (..)
import Element exposing (toHtml)
import Maybe exposing (withDefault)
import Dict
import Dict.Extra

type Event = Tick Time

world = [(-1,0),(0,0),(1,0),(1,1),(0,2)]

wrap world = map (\(x,y) -> (x%80,y%60)) world

evolve world = 
    let wasAlive cell = member cell world
        alive cell count = (count == 3) || ((wasAlive cell) && (count == 2))
        filtered = Dict.filter alive <| neighbourMap world
    in Dict.keys filtered

neighbourMap world =
    Dict.map (always length) <| Dict.Extra.groupBy identity <| wrap <| concatMap neighbours world

countNeighbours cell world =
    withDefault 0 <| Dict.get cell <| neighbourMap world

neighbours (x,y) =
    map (\ (ox,oy) -> (x+ox,y+oy)) neighbourOffsets

neighbourOffsets =
    let offsets = [0,1,-1]
        pairWith offsets x = map ((,) x) offsets
    in drop 1 <| concatMap (pairWith offsets) offsets

debug cells =
    case cells of
        []          -> text "The world is empty"
        otherwise   -> text <| concat ["The world has population ", toString <| length cells, " ", toString cells]

display cells =
    let displayOne (x,y) = move ((toFloat x)*11-435, (toFloat y)*11-325) <| filled white <| rect 10 10
    in map displayOne cells

view cells =
    div []  [
        debug cells,
        toHtml <| collage 880 660 ((filled black <| rect 880 660) :: display cells)
            ]

update event model = (evolve model, Cmd.none)

main = program
    {
    init = (world, Cmd.none),
    view = view,
    update = update,
    subscriptions = always (Time.every (inMilliseconds 200) Tick)
    }