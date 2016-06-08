import Html exposing (a, div, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import String exposing (concat)

type alias Model = Int
type Event = Start

model : Model
model = 0

view : Model -> Html Event
view model =
    div [] [
        text (String.concat ["The world is new! It's ", (toString model), " seconds old."]),
        div [onClick Start] [text "Click to start the world."]
    ]

update : Event -> Model -> Model
update = always identity

main = beginnerProgram {
        model = model,
        view = view,
        update = update
    }
