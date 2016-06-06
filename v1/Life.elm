module Life exposing (cells) -- where

import Html exposing (span, div, text, node)
import Html.Attributes exposing (id, class, attribute, style)
import Html.App exposing (beginnerProgram)
import List exposing (repeat)
import String exposing (concat)

cells (w,h) = repeat (w*h) (div [class "cell"] [])

main = beginnerProgram
    {
        model = (30,30),
        view = (\model -> node "wrapper" [] [
            style, -- setup
            div [id "view"] [div [id "box", attribute "style" (boxStyle model)] (cells model)]]),
        update = identity
    }

boxStyle (w,h) = concat ["width: ",toString (w*10),"px; height: ",toString (h*10),"px;"]

style = node "style" [] [text "#view { display: flex; height: 100%;} #box { display: flex; flex-flow: row wrap; margin: auto; } .cell { margin-left: -1px; margin-top: -1px; padding:0; border: 1px solid #BBBBBB; width: 9px; height: 9px;}"]
