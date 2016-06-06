import Html exposing (text)
import Html.App exposing (beginnerProgram)
import String exposing (concat)
import List exposing (length)

type alias Coordinate = (Int, Int)
type alias Dimensions = (Int, Int)
type alias Age = Int
type alias Model = (Age, Dimensions,List Coordinate)

model : Model
model = (1,(1,1),[])

view : Model -> Html.Html Never
view (age, (width, height), cells) = text <| concat
    ["The world is ", toString age, " generations old and ", toString width," wide by ",toString height, " high, population: ",toString <| length cells]

update : Never -> Model -> Model
update event model = model

main = beginnerProgram {
    model  = model,
    view   = view,
    update = update
  }