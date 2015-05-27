import "gUnit" as gU
import "utils" as utils

def test = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)

        method testMin {
            assert (utils.min(1,1)) shouldBe (1)
            assert (utils.min(1,2)) shouldBe (1)
            assert (utils.min(0,1)) shouldBe (0)
            assert (utils.min(-1,0)) shouldBe (-1)
            assert (utils.min(-1,1)) shouldBe (-1)
        }
        method testMax {
            assert (utils.max(1,1)) shouldBe (1)
            assert (utils.max(1,2)) shouldBe (2)
            assert (utils.max(0,1)) shouldBe (1)
            assert (utils.max(-1,0)) shouldBe (0)
            assert (utils.max(-1,1)) shouldBe (1)
        }
    }
}

print "utilsTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
