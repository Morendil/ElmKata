module Life exposing (cells) -- where

import Html exposing (span, div, text, node)
import Html.Attributes exposing (class, attribute, style)
import Html.App exposing (beginnerProgram)
import List exposing (repeat)
import String exposing (concat)

cells (w,h) = repeat (w*h) (div [attribute "style" cellStyle] [])

main = beginnerProgram
    {
        model = (50,50),
        view = (\model -> div [attribute "style" viewStyle] [div [attribute "style" (boxStyle model)] (cells model)]),
        update = identity
    }

viewStyle = "display: flex; height: 100%;"
boxStyle (w,h) = concat ["width: ",toString (w*10),"px; height: ",toString (h*10),"px; display: flex; flex-flow: row wrap; margin: auto;"]
cellStyle = "margin-left: -1px; margin-top: -1px; padding:0; border: 1px solid #CCCCCC; width: 9px; height: 9px;"