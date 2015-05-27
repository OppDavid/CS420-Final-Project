import "gUnit" as gU
import "logic" as logic

def test = object {
    class forMethod(p) {
        inherits gU.testCaseNamed(p)
        method testSingleNotNotSimplification {
            def A = logic.predicate("A")
            def E = A.not.not
            def simpE = E.simplificationRemoveNotNot
            assert (E.asString) shouldBe ("~~A")
            assert (simpE.asString) shouldBe ("A")
        }
        method testMultipleNotNotSimplificationOne {
            def A = logic.predicate("A")
            def B = logic.predicate("B")
            def E = (A.not.not).and(B.not.not)
            def simpE = E.simplificationRemoveNotNot
            assert (E.asString) shouldBe ("(~~A&~~B)")
            assert (simpE.asString) shouldBe ("(A&B)")
        }
        method testMultipleNotNotSimplificationTwo {
            def A = logic.predicate("A")
            def E = A.not.not.not
            def simpE = E.simplificationRemoveNotNot
            assert (E.asString) shouldBe ("~~~A")
            assert (simpE.asString) shouldBe ("~A")
        }
        method testMultipleNotNotSimplificationThree {
            def A = logic.predicate("A")
            def E = A.not.not.not.not
            def simpE = E.simplificationRemoveNotNot
            assert (E.asString) shouldBe ("~~~~A")
            assert (simpE.asString) shouldBe ("A")
        }
    }
}

print "simplificationTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults