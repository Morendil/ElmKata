import ElmTest exposing (..)

import Html exposing (..)
import Life exposing (..)
import Dict exposing (get)
import Maybe exposing (withDefault)

myTests = suite "Les tests de la vie" [
        equals (text "Le monde est vide et sans vie") (debug []),
        equals (text "[(0,0)]") (debug [(0,0)]),
        equals ([]) (evolve [(0,0)]),
        equals ([(-1,-1),(0,-1),(1,-1),(-1,0),(1,0),(-1,1),(0,1),(1,1)]) (neighbours (0,0)),
        equals ([(2,2),(3,2),(4,2),(2,3),(4,3),(2,4),(3,4),(4,4)]) (neighbours (3,3)),
        let map = neighboursMap [(0,0)]
        in equals 1 (withDefault 0 (get (0,1) map)),
        let map = neighboursMap [(3,3)]
        in equals 1 (withDefault 0 (get (3,4) map)),
        let map = neighboursMap [(-1,0),(1,0)]
        in equals 2 (withDefault 0 (get (0,0) map)),
        equals ([(1,1)]) (evolve [(0,0),(1,1),(2,2)])
    ]

main = runSuiteHtml myTests