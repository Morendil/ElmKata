import ElmTest exposing (runSuiteHtml, suite, equals)
import Html exposing (text)
import Life exposing (view, evolve, neighbours, countNeighbours)

myTests = suite "Life"
    [
        equals (text "The world is empty")  (view []),
        equals (text "The world has population 1 [(0,0)]")  (view [(0,0)]),
        equals [] (evolve [(0,0)]),
        equals [(0,1),(0,-1),(1,0),(1,1),(1,-1),(-1,0),(-1,1),(-1,-1)] (neighbours (0,0)),
        equals [(4,5),(4,3),(5,4),(5,5),(5,3),(3,4),(3,5),(3,3)] (neighbours (4,4)),
        equals 1 (countNeighbours (0,0) [(0,1)]),
        equals 8 (countNeighbours (0,0) (neighbours (0,0))),
        equals [(-1,0),(0,0),(1,0)] (evolve [(0,-1),(0,0),(0,1)])
    ]

main = runSuiteHtml myTests