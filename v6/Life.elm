module Life exposing (..) -- where

import Html exposing (Html, text, div)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Svg exposing (svg, rect)
import Svg.Attributes exposing (width,height,x,y,style)
import List exposing (length,map,member,concat,filter)
import Dict exposing (get)
import Dict.Extra exposing (groupBy)
import Maybe exposing (withDefault)

type Update = Click
type alias Cell = (Int,Int)

-- Model

world : List Cell
world = [(1,0),(2,1),(0,2),(1,2),(2,2)]

offsets = [(-1,-1),(0,-1),(1,-1),
           (-1,0),(1,0),
           (-1,1),(0,1),(1,1)]

add : Cell -> Cell -> Cell
add (cx,cy) (ox,oy) = (cx+ox,cy+oy)

countNeighbours position cells =
    let allNeighbours = concat <| map neighbours cells
        neighbourMap = Dict.Extra.groupBy identity allNeighbours
    in length <| withDefault [] <| get position neighbourMap

neighbours position = map (add position) offsets

-- Update

evolve world =
    let wasAlive cell = member cell world
        willLive cell = (wasAlive cell && (countNeighbours cell world == 2)) || (countNeighbours cell world == 3)
    in filter willLive world -- this is fatally wrong ;)

update message world =
    case message of
        Click -> evolve world

-- View

displayCell (xx,yy) =
    rect [x (toString (xx*11)),
          y (toString (yy*11)),
          width "10", height "10",
          style "fill:white"] []

background =
    rect [width "400", height "300",
          style "fill:black"] []

debug : List trucs -> Html Update
debug world =
    if length world == 0 then
        text "Le monde est vide et sans vie"
    else
        toString world |> text

view world =
    div [] [
        div [onClick Click] [debug world],
        svg [] (background :: (map displayCell world))
    ]

main : Program Never
main = beginnerProgram
    {
        model = world,
        view = view,
        update = update
    }