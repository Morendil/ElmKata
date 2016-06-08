import Html exposing (text, Html)
import Html.App exposing (beginnerProgram)
import String exposing (concat)

type alias Model = Int

model : Model
model = 0

view : Model -> Html Never
view model = text (String.concat ["The world is new! It's ", (toString model), " seconds old."])

update : Never -> Model -> Model
update _ = identity

main = beginnerProgram {
        model = model,
        view = view,
        update = update
    }
