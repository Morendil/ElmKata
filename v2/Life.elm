import Html exposing (text)
import Html.App exposing (beginnerProgram)

type alias Coordinate = (Int, Int)
type alias Model = (Int,Int,List Coordinate)

model : Model
model = (1,1,[])

view : Model -> Html.Html Never
view model = text (toString model)

update : Never -> Model -> Model
update event model = model

main = beginnerProgram {
    model  = model,
    view   = view,
    update = update
  }