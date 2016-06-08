import ElmTest exposing (runSuiteHtml, equals)

import Life exposing (dimensions, model)

myTests = ElmTest.suite "Tests"
  [
    let model' = {model | w=20, h=10}
    in equals {w=200.0, h=100.0} (dimensions model')
  ]

main = ElmTest.runSuiteHtml myTests