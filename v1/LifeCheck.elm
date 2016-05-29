import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (..)
import ElmTest exposing (runSuiteHtml)
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


main = ElmTest.runSuiteHtml (Check.Test.evidenceToTest evidence)