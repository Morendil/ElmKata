import Html exposing (text)
import Html.App exposing (program)
import String exposing (concat)
import List exposing (length)
import Time exposing (Time, second)

type alias Coordinate = (Int, Int)
type alias Dimensions = (Int, Int)
type alias Age = Int
type alias Model = (Age, Dimensions,List Coordinate)

type Update = Tick (Time)

model : Model
model = (1,(1,1),[])

init : (Model, Cmd Update)
init = (model, Cmd.none)

view : Model -> Html.Html Update
view (age, (width, height), cells) = text <| concat
    ["The world is ", toString age, " generations old and ", toString width," wide by ",toString height, " high, population: ",toString <| length cells]

update : Update -> Model -> (Model, Cmd Update)
update event model =
    let (age, (width, height), cells) = model
        newModel = (age+1, (width, height), cells)
    in (newModel, Cmd.none)

subscriptions : Model -> Sub Update
subscriptions model = Time.every second Tick

main = program {
    init   = init,
    view   = view,
    update = update,
    subscriptions = subscriptions
  }