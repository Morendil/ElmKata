module Life exposing (..) -- where

import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html exposing (Html, text, div)
import Svg exposing (svg, rect)
import Svg.Attributes exposing (width,height,style,x,y)
import List exposing (length, map, concatMap, member)
import Dict exposing (empty)
import Dict.Extra exposing (groupBy)

type alias Cell = (Int, Int)
type alias World = List (Int, Int)
type Click = Click

model : World
model = [(1,0),(2,1),(0,2),(1,2),(2,2)]

debug : World -> Html Click
debug world =
    if length world == 0 then text "Le monde est vide et sans vie"
    else text (toString world)

background = rect [width "400", height "200", style "fill:black"] []

view : World -> Html Click
view world =
    div []
        [
        div [onClick Click] [debug world],
        svg [width "400", height "200"]
            (background :: displayCells world)
        ]

displayCell (xx,yy) = rect [x (toString (xx*11)), y (toString (yy*11)), width "10", height "10", style "fill:white"] []

displayCells cells = map displayCell cells

offset (cx,cy) (ox,oy) = (cx+ox,cy+oy)

neighbours : Cell -> List Cell
neighbours cell = map (offset cell) [(-1,-1),(0,-1),(1,-1),(-1,0),(1,0),(-1,1),(0,1),(1,1)]

neighboursMap world = Dict.map (always length) (groupBy identity (concatMap neighbours world))

evolve : World -> World
evolve world =
    let wasAlive cell = member cell world
        alive cell count = if (((count == 2) && (wasAlive cell)) || (count == 3)) then True else False
    in Dict.keys (Dict.filter alive (neighboursMap world))

update : Click -> World -> World
update message world = evolve world

main = beginnerProgram
    {
    model = model,
    view = view,
    update = update
    }