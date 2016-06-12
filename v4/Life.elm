module Life exposing (debug, evolve, neighbours, countNeighbours) -- where
import Html exposing (text, div)
import Html.Events exposing (on)
import Html.App exposing (program)
import String exposing (concat)
import List exposing (length, map, concatMap, drop, member, filter)
import Time exposing (..)
import Svg exposing (svg, rect)
import Svg.Attributes exposing (x, y, width, height, style, viewBox)
import Element exposing (toHtml)
import Maybe exposing (withDefault)
import Json.Decode exposing (Decoder, (:=))
import Window exposing (Size, size)
import Task exposing (perform)
import Platform.Cmd exposing (batch)
import Dict
import Dict.Extra
import Random


type Event = Start | Tick Time | World (List (Int, Int)) | Click (Int, Int) | Window Size

world = {cells=[(-1,0),(0,0),(1,0),(1,1),(0,2)], height=0, width=0}

wrapCells world cells = map (\(x,y) -> (x%(world.width//11),y%(world.height//11))) cells

evolve world = 
    let wasAlive cell = member cell world.cells
        alive cell count = (count == 3) || ((wasAlive cell) && (count == 2))
        filtered = Dict.filter alive <| neighbourMap world
    in Dict.keys filtered

neighbourMap world =
    Dict.map (always length) <| Dict.Extra.groupBy identity <| wrapCells world <| concatMap neighbours world.cells

countNeighbours cell world =
    withDefault 0 <| Dict.get cell <| neighbourMap world

neighbours (x,y) =
    map (\ (ox,oy) -> (x+ox,y+oy)) neighbourOffsets

neighbourOffsets = [(0,1),(0,-1),(1,0),(1,1),(1,-1),(-1,0),(-1,1),(-1,-1)]

debug cells =
    case cells of
        []          -> text "The world is empty"
        otherwise   -> text <| concat ["The world has population ", toString <| length cells, " ", toString cells]

display cells =
    let displayOne (xx,yy) = rect [x <| toString ((toFloat xx)*11), y <| toString <| ((toFloat yy)*11),  width "10", height "10", style "fill:white"] []
    in map displayOne cells

view world =
    div [on "click" (Json.Decode.map Click offsetPosition)]
    [svg
        [width <| toString world.width, height <| toString world.height]
        ((rect [width <| toString world.width, height <| toString world.height] []) :: (display world.cells))
    ]

offsetPosition : Decoder ( Int, Int )
offsetPosition =
    Json.Decode.object2 (,)
        ("offsetX" := Json.Decode.int)
        ("offsetY" := Json.Decode.int)

update event model =
    case event of
        Start -> (world, Cmd.none)
        Window {height,width} -> ({model| width=width, height=height}, Cmd.none)
        Tick _ -> ({model| cells = evolve model}, Cmd.none)
        World cells -> ({model| cells = cells}, Cmd.none)
        Click (x,y) ->
            let cell = (x//11,y//11)
                cells' = if member cell model.cells then filter ((/=) cell) model.cells else (cell :: model.cells)
            in ({model| cells = cells'}, Cmd.none)

generateWorld = Random.generate World (Random.list 100 <| Random.pair (Random.int 20 60) (Random.int 15 45))

getWindowSize = perform (always Start) Window size

main = program
    {
    init = (world, batch [generateWorld, getWindowSize]),
    view = view,
    update = update,
    subscriptions = always (Time.every (inMilliseconds 200) Tick)
    }