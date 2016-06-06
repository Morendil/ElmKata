import Html exposing (text)
import Html.App exposing (beginnerProgram)

main = beginnerProgram {
    model  = "Hello World!",
    view   = text,
    update = always identity
  }