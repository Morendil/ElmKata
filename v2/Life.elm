import Html exposing (text)
import Html.App exposing (beginnerProgram)

type alias Model = String

model : Model
model = "Hello World!"

view : Model -> Html.Html Never
view model = text model

update : Never -> Model -> Model
update event model = model

main = beginnerProgram {
    model  = model,
    view   = view,
    update = update
  }