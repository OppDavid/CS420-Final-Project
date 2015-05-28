import "gUnit" as gU
import "logic" as logic

def test = object {
    class forMethod(p) {
        inherits gU.testCaseNamed(p)
        method testSingleNotNotSimplification {
            def a = logic.predicate("A")
            def e = a.not.not
            def eSimp = e.simplificationRemoveNotNot
            assert (e.asString) shouldBe ("~~A")
            assert (eSimp.asString) shouldBe ("A")
        }
        method testNestedNotNotSimplificationOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def e = (a.not.not).and(b.not.not)
            def eSimp = e.simplificationRemoveNotNot
            assert (e.asString) shouldBe ("(~~A&~~B)")
            assert (eSimp.asString) shouldBe ("(A&B)")
        }
        method testNestedNotNotSimplificationTwo {
            def a = logic.predicate("A")
            def e = a.not.not.not
            def eSimp = e.simplificationRemoveNotNot
            assert (e.asString) shouldBe ("~~~A")
            assert (eSimp.asString) shouldBe ("~A")
        }
        method testNestedNotNotSimplificationThree {
            def a = logic.predicate("A")
            def e = a.not.not.not.not
            def eSimp = e.simplificationRemoveNotNot
            assert (e.asString) shouldBe ("~~~~A")
            assert (eSimp.asString) shouldBe ("A")
        }
        method testImpliesToOr {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def e = a.implies(b)
            def eConv = e.conversionImpliesToOr
            assert (e.asString) shouldBe ("(A->B)")
            assert (eConv.asString) shouldBe ("(~A|B)")
        }
        method testNestedImplesToOrOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def d = logic.predicate("D")
            def e = (a.implies(b)).and(c.implies(d))
            def eConv = e.conversionImpliesToOr
            assert (e.asString) shouldBe ("((A->B)&(C->D))")
            assert (eConv.asString) shouldBe ("((~A|B)&(~C|D))")
        }
        method testNestedImpliesToOrTwo {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = a.implies(b.implies(c))
            def eConv = e.conversionImpliesToOr
            assert (e.asString) shouldBe ("(A->(B->C))")
            assert (eConv.asString) shouldBe ("(~A|(~B|C))")
        }
    }
}

print "simplificationTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults