import Html exposing (text)
import Html.App exposing (beginnerProgram)

main = beginnerProgram {
        model = "The world is new! It's 0 seconds old.",
        view = \ model -> text model,
        update = \ event model -> model
    }
