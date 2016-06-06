import Html exposing (text)
import Html.App exposing (beginnerProgram)

type alias Model = String

update : Never -> Model -> Model
update event model = model

main = beginnerProgram {
    model  = "Hello World!",
    view   = text,
    update = update
  }