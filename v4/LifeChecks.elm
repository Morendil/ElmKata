import ElmTest exposing (runSuiteHtml, suite, equals)
import Html exposing (text)
import Life exposing (view)

myTests = suite "Life" [equals (text "The world is empty")  (view [])]

main = runSuiteHtml myTests