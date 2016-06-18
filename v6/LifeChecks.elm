import ElmTest exposing (..)
import Html exposing (text)

import Life exposing (..)

lifeTests = suite "Life"
    [
        equals (text "Le monde est vide et sans vie")
               (debug []),
        equals (text "[(0,0)]")
               (debug [(0,0)]),
        equals ([]) (evolve [(0,0)]),
        equals ([(-1,-1),(0,-1),(1,-1),
                 (-1,0),(1,0),
                 (-1,1),(0,1),(1,1)]) (neighbours (0,0)),
        equals ([(2,2),(3,2),(4,2),
                 (2,3),(4,3),
                 (2,4),(3,4),(4,4)]) (neighbours (3,3)),
        equals (1) (countNeighbours (1,0) [(0,0)]),
        equals (0) (countNeighbours (3,3) [(0,0)]),
        equals (1) (countNeighbours (4,3) [(3,3)]),
        equals (2) (countNeighbours (0,0) [(-1,0),(1,0)]),
        equals (2) (countNeighbours (0,0) [(-1,-1),(1,1)]),
        equals (3) (countNeighbours (0,-1) [(-1,0),(0,0),(1,0)]),
        equals ([(0,0)]) (evolve [(-1,-1),(0,0),(1,1)]),
        equals ([]) (evolve [(-1,-1),(1,1)]),
        equals ([(0,-1),(0,0),(0,1)]) (evolve [(-1,0),(0,0),(1,0)])
    ]

main = runSuiteHtml lifeTests