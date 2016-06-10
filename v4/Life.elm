module Life exposing (view, evolve) -- where
import Html exposing (text)
import Html.App exposing (program)
import String exposing (concat)
import List exposing (length)
import Time exposing (Time, second)

type Event = Tick Time

world = [(0,0)]

view cells =
    case cells of
        []          -> text "The world is empty"
        otherwise   -> text <| concat ["The world has population ", toString <| length cells, " ", toString cells]

evolve word = []

update event model = (evolve model, Cmd.none)

main = program
    {
    init = (world, Cmd.none),
    view = \ model -> view model,
    update = update,
    subscriptions = \ model -> Time.every second Tick
    }