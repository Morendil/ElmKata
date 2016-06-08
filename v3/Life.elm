import Html exposing (a, div, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import String exposing (concat)

type alias World = Int
type Event = Start

model : World
model = 0

view : World -> Html Event
view model =
    div [] [
        text (String.concat ["The world is new! It's ", (toString model), " seconds old."]),
        div [onClick Start] [text "Click to start the world."]
    ]

update : Event -> World -> World
update event model = model + 1

main = beginnerProgram {
        model = model,
        view = view,
        update = update
    }
