module Life exposing (..) -- where

import Html exposing (a, div, text, Html)
import Html.App exposing (program)
import Html.Events exposing (onClick)
import Element exposing (toHtml)
import Collage exposing (filled, rect, collage)
import Color exposing (..)
import String exposing (concat)
import Task exposing (perform)
import Window exposing (resizes, size, Size)

type alias Dimensions = {w:Float, h:Float}
type alias World = {win:Size, w:Float, h:Float, age: Int}
type Event = Start | Window Size

model : World
model = {win={width=0,height=0},w=30,h=30,age=0}

dimensions: World -> Dimensions
dimensions world = {w=10*world.w, h=10*world.h}

age model = toString <| model.age

view : World -> Html Event
view model =
    div [] [
        text (String.concat ["The world is new! It's ", (age model), " seconds old."]),
        div [onClick Start] [text "Click to start the world."],
        let dim = dimensions model
        in toHtml <| collage model.win.width model.win.height [filled black <| rect dim.w dim.h]
    ]

update : Event -> World -> World
update event model =
    case event of
        Start -> {model | age = model.age + 1}
        Window size -> {model | win = size}

subscriptions = always (resizes Window)

main = program {
        init = (model, perform (always Start) Window size),
        view = view,
        update = \ event model -> (update event model, Cmd.none),
        subscriptions = subscriptions
    }
