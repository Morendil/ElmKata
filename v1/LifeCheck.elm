import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (..)
import ElmTest exposing (runSuiteHtml, equals)
import List exposing (length)

import Life exposing (cells)

evidence : Evidence
evidence = quickCheck myClaims

myClaims : Claim
myClaims =
  suite "Cell representation"
    [ claim
        "A model with dimensions w,h contains w * h cells"
      `that`
        (\dimensions -> length <| cells dimensions)
      `is`
        (\(w,h) -> w * h)
      `for`
        tuple (rangeInt 1 100, rangeInt 1 100)
    ]

myTests = ElmTest.suite "Tests"
  [
    equals 4 (length <| cells (2,2))
  ]

main = ElmTest.runSuiteHtml <| ElmTest.suite "Everything" [myTests, (Check.Test.evidenceToTest evidence)]