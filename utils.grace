import "gUnit" as gU

method min(x, y) { if (x <= y) then { x } else { y } }
method max(x, y) { if (x >= y) then { x } else { y } }

//
// TESTS
//

def utils2DTest = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)

        method testMin {
            assert (min(1,1)) shouldBe (1)
            assert (min(1,2)) shouldBe (1)
            assert (min(0,1)) shouldBe (0)
            assert (min(-1,0)) shouldBe (-1)
            assert (min(-1,1)) shouldBe (-1)
        }
        method testMax {
            assert (max(1,1)) shouldBe (1)
            assert (max(1,2)) shouldBe (2)
            assert (max(0,1)) shouldBe (1)
            assert (max(-1,0)) shouldBe (0)
            assert (max(-1,1)) shouldBe (1)
        }
    }
}

def utils2DTests = gU.testSuite.fromTestMethodsIn(utils2DTest)
print "utils"
utils2DTests.runAndPrintResults
