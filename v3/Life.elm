import Html exposing (text)
import Html.App exposing (beginnerProgram)
import String exposing (concat)

main = beginnerProgram {
        model = 0,
        view = \ model -> text (String.concat ["The world is new! It's ", (toString model), " seconds old."]),
        update = \ event model -> model
    }
