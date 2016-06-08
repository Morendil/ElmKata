module Life exposing (..) -- where

import Html exposing (a, div, text, Html)
import Html.App exposing (program)
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
dimensions world = {w=10*world.w, h=10*world.h}

age model = toString <| model.age

view : World -> Html Event
view model =
    div [] [
        text (String.concat ["The world is new! It's ", (age model), " seconds old."]),
        div [onClick Start] [text "Click to start the world."],
        let dim = dimensions model
        in toHtml <| collage 100 100 [filled black <| rect dim.w dim.h]
    ]

update : Event -> World -> World
update event model = {model | age = model.age + 1}

main = program {
        init = (model, Cmd.none),
        view = view,
        update = \ event model -> (update event model, Cmd.none),
        subscriptions = \ model -> Sub.none
    }
