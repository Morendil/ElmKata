import ElmTest exposing (runSuiteHtml, suite, equals)
import Html exposing (text)
import Life exposing (view)

myTests = suite "Life"
    [
        equals (text "The world is empty")  (view []),
        equals (text "The world has population 1 [(0,0])")  (view [(0,0)])
    ]

main = runSuiteHtml myTests