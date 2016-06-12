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
import Dict
import Dict.Extra
import Random

type Event = Tick Time | World (List (Int, Int)) | Click (Int, Int)

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
    let displayOne (xx,yy) = rect [x <| toString ((toFloat xx)*11), y <| toString <| ((toFloat yy)*11),  width "10", height "10", style "fill:white"] []
    in map displayOne cells

view cells =
    div [on "click" (Json.Decode.map Click offsetPosition)]
    [svg
        [width "880", height "660", viewBox "0 0 880 660"]
        ((rect [width "880", height "660"] []) :: (display cells))
    ]

offsetPosition : Decoder ( Int, Int )
offsetPosition =
    Json.Decode.object2 (,)
        ("offsetX" := Json.Decode.int)
        ("offsetY" := Json.Decode.int)

update event model =
    case event of
        Tick _ -> (evolve model, Cmd.none)
        World model -> (model, Cmd.none)
        Click (x,y) ->
            let cell = (x//11,y//11)
                model' = if member cell model then filter ((/=) cell) model else (cell :: model)
            in (model', Cmd.none)

main = program
    {
    init = (world, Random.generate World (Random.list 100 <| Random.pair (Random.int 20 60) (Random.int 15 45))),
    view = view,
    update = update,
    subscriptions = always (Time.every (inMilliseconds 200) Tick)
    }