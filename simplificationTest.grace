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
            assert (e.asString) shouldBe ("(A=>B)")
            assert (eConv.asString) shouldBe ("(~A|B)")
        }
        method testNestedImplesToOrOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def d = logic.predicate("D")
            def e = (a.implies(b)).and(c.implies(d))
            def eConv = e.conversionImpliesToOr
            assert (e.asString) shouldBe ("((A=>B)&(C=>D))")
            assert (eConv.asString) shouldBe ("((~A|B)&(~C|D))")
        }
        method testNestedImpliesToOrTwo {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = a.implies(b.implies(c))
            def eConv = e.conversionImpliesToOr
            assert (e.asString) shouldBe ("(A=>(B=>C))")
            assert (eConv.asString) shouldBe ("(~A|(~B|C))")
        }
        method testIffToImplies {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def e = a.iff(b)
            def eConv = e.conversionIffToImplies
            assert (e.asString) shouldBe ("(A<=>B)")
            assert (eConv.asString) shouldBe ("((A=>B)&(B=>A))")
        }
        method testNestedIffToImpliesOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def d = logic.predicate("D")
            def e = (a.iff(b)).and(c.iff(d))
            def eConv = e.conversionIffToImplies
            assert (e.asString) shouldBe ("((A<=>B)&(C<=>D))")
            assert (eConv.asString) shouldBe ("(((A=>B)&(B=>A))&((C=>D)&(D=>C)))")
        }
        method testNestedIffToImpliesTwo {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = a.iff(b.iff(c))
            def eConv = e.conversionIffToImplies
            assert (e.asString) shouldBe ("(A<=>(B<=>C))")
            assert (eConv.asString) shouldBe ("((A=>((B=>C)&(C=>B)))&(((B=>C)&(C=>B))=>A))")
        }
        method testRemoveAllImplications {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def e = a.iff(b)
            def eConv = e.removeAllImplications
            assert (e.asString) shouldBe ("(A<=>B)")
            assert (eConv.asString) shouldBe ("((~A|B)&(~B|A))")
        }
        method testDistributeAndOverOrOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = a.and(b.or(c))
            def eDist = e.distributeAndOverOr
            assert (e.asString) shouldBe ("(A&(B|C))")
            assert (eDist.asString) shouldBe ("((A&B)|(A&C))")
        }
        method testDistributeAndOverOrTwo {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = (b.or(c)).and(a)
            def eDist = e.distributeAndOverOr
            assert (e.asString) shouldBe ("((B|C)&A)")
            assert (eDist.asString) shouldBe ("((B&A)|(C&A))")
        }
        method testDistributeAndOverOrThree {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def d = logic.predicate("D")
            def e = (a.or(b)).and(c.or(d))
            def eDist = e.distributeAndOverOr
            assert (e.asString) shouldBe ("((A|B)&(C|D))")
            assert (eDist.asString) shouldBe ("(((A&C)|(A&D))|((B&C)|(B&D)))")
        }
        method testDistributeOrOverAndOne {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = a.or(b.and(c))
            def eDist = e.distributeOrOverAnd
            assert (e.asString) shouldBe ("(A|(B&C))")
            assert (eDist.asString) shouldBe ("((A|B)&(A|C))")
        }
        method testDistributeOrOverAndTwo {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def e = (b.and(c)).or(a)
            def eDist = e.distributeOrOverAnd
            assert (e.asString) shouldBe ("((B&C)|A)")
            assert (eDist.asString) shouldBe ("((B|A)&(C|A))")
        }
        method testDistributeOrOverAndThree {
            def a = logic.predicate("A")
            def b = logic.predicate("B")
            def c = logic.predicate("C")
            def d = logic.predicate("D")
            def e = (a.and(b)).or(c.and(d))
            def eDist = e.distributeOrOverAnd
            assert (e.asString) shouldBe ("((A&B)|(C&D))")
            assert (eDist.asString) shouldBe ("(((A|C)&(A|D))&((B|C)&(B|D)))")
        }
    }
}

print "simplificationTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
