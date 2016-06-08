module Life exposing (..) -- where

import Html exposing (a, div, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Element exposing (toHtml)
import Collage exposing (filled, rect, collage)
import Color exposing (..)
import String exposing (concat)

type alias Dimensions = {w:Float, h:Float}
type alias World = {w:Float, h:Float, age: Int}
type Event = Start

model : World
model = {w=20,h=20,age=0}

dimensions: World -> Dimensions
dimensions world = {w=0.0, h=0.0}

view : World -> Html Event
view model =
    div [] [
        text (String.concat ["The world is new! It's ", (toString model), " seconds old."]),
        div [onClick Start] [text "Click to start the world."],
        toHtml <| collage 100 100 [filled black <| rect 100.0 100.0]
    ]

update : Event -> World -> World
update event model = {model | age = model.age + 1}

main = beginnerProgram {
        model = model,
        view = view,
        update = update
    }
