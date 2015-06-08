import "gUnit" as gU
import "logic" as logic

def test = object {
  class forMethod(p) {
    inherits gU.testCaseNamed(p)
    def a = logic.predicate("A")
    def b = logic.predicate("B")
    def c = logic.predicate("C")
    def d = logic.predicate("D")
    def CON = logic.contradiction
    def TAU = logic.tautology
    
    method testPredicateAsString { 
      assert (logic.predicate("A").asString) shouldBe ("A")
    }  
    method testPredicatePredicates {
      assert (logic.predicate("A").predicates) shouldBe (list.with(logic.predicate("A")))
    }
    method testNotString { 
      assert (logic.predicate("A").not.asString) shouldBe ("~A")
    }  
    method testAndString { 
      assert (a.and(b).asString) shouldBe ("(A&B)")
    }
    method testOrString { 
      assert (a.or(b).asString) shouldBe ("(A|B)")
    }  
    method testImpliesString { 
      assert (a.implies(b).asString) shouldBe ("(A=>B)")
    }  
    method testIffString { 
      assert (a.iff(b).asString) shouldBe ("(A<=>B)")
    }
    method testAndBinaryOperator { 
      def e = a&b
      assert (e.asString) shouldBe ("(A&B)")
    }
    method testOrBinaryOperator { 
      def e = a|b
      assert (e.asString) shouldBe ("(A|B)")
    }  
    method testImpliesBinaryOperator { 
      def e = a=>b
      assert (e.asString) shouldBe ("(A=>B)")
    }  
    method testIffBinaryOperator {  
      def e = a≡b
      assert (e.asString) shouldBe ("(A<=>B)")
    }
    method testNotUnaryOperator {
      def e = ~a
      assert (e.asString) shouldBe ("~A")
    }
    //method testSetCrossProductOfOneElementSets {
    //  def expected = [[1, 2]]
    //  def actual = logic.setCrossProduct([1], [2])
    //  assert (actual.asString) shouldBe (expected.asString)
    //}
    //method testSetCrossProductOfTwoElementSets {
    //  def expected = [[1, 3], [1, 4], [2, 3], [2, 4]]
    //  def actual = logic.setCrossProduct([1, 2], [3, 4])
    //  assert (actual.asString) shouldBe (expected.asString)
    //}
    // This should also work...
    method testBuildTruthTableStatesWithOne {
      def expected = [[true], [false]]
      def actual = logic.buildTruthTableStates(1)
      assert (actual.asString) shouldBe (expected.asString) // Using asString because faulty list comparison
    }
    // This should work 
    method testBuildTruthTableStatesWithTwo {
      def expected = [[true, true], [true, false], [false, true], [false, false]]
      def actual = logic.buildTruthTableStates(2)
      assert (actual.asString) shouldBe (expected.asString)
    }
    method testCopyEquality {
      def e = a.and(b)
      def f = e.copy
      assert (f.asString) shouldBe ("(A&B)")
    }
    method testCopyImutabilty {
      def e = a.and(b)
      def f = e.copy
      f.operand1 := logic.predicate("C")
      assert (e.asString) shouldBe ("(A&B)")
      assert (f.asString) shouldBe ("(C&B)")
    }
    method testIsNotOperator {
      def e = a.not
      assert (e.isNotOperator) shouldBe (true)
    }
    method testIsAndOperatorTest {
      def e = a.and(b)
      assert (e.isAndOperator) shouldBe (true)
    }
    method testIsOrOperator {
      def e = a.or(b)
      assert (e.isOrOperator) shouldBe (true)
    }
    method testIsImpliesOperator {
      def e = a.implies(b)
      assert (e.isImpliesOperator) shouldBe (true)
    }
    method testIsIffOperator {
      def e = a.iff(b)
      assert (e.isIffOperator) shouldBe (true)
    }
    method testIsTautology {
      def e = a.or(a.not)
      assert (e.isTautology) shouldBe (true)
    }
    method testIsContradiction {
      def e = a.and(a.not)
      assert (e.isContradiction) shouldBe (true)
    }
    method testIsConditional {
      def e = a.and(b)
      assert (a.isConditional) shouldBe (true)
    }
    method testPredicateEquality {
      assert ( a == a ) shouldBe (true)
    }
    method testExpresionEquality {
      def e = a.and(b)
      assert ( e == e ) shouldBe (true)
    }
    method testPredicateNotEquality {
      assert ( a != b ) shouldBe (true)
    }
    method testExpresionNotEquality {
      def e = a.and(b)
      def f = a.or(b)
      assert ( e != f ) shouldBe (true)
    }
    method testSingleNotNotSimplification {    
      def e = a.not.not
      def eSimp = e.removeNots
      assert (e.asString) shouldBe ("~~A")
      assert (eSimp.asString) shouldBe ("A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testNestedNotNotSimplificationOne {
      def e = (a.not.not).and(b.not.not)
      def eSimp = e.removeNots
      assert (e.asString) shouldBe ("(~~A&~~B)")
      assert (eSimp.asString) shouldBe ("(A&B)")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testNestedNotNotSimplificationTwo {
      def e = a.not.not.not
      def eSimp = e.removeNots
      assert (e.asString) shouldBe ("~~~A")
      assert (eSimp.asString) shouldBe ("~A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testNestedNotNotSimplificationThree {
      def e = a.not.not.not.not
      def eSimp = e.removeNots
      assert (e.asString) shouldBe ("~~~~A")
      assert (eSimp.asString) shouldBe ("A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testImpliesToOr {
      def e = a.implies(b)
      def eConv = e.removeImplies
      assert (e.asString) shouldBe ("(A=>B)")
      assert (eConv.asString) shouldBe ("(~A|B)")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testNestedImplesToOrOne {
      def e = (a.implies(b)).and(c.implies(d))
      def eConv = e.removeImplies
      assert (e.asString) shouldBe ("((A=>B)&(C=>D))")
      assert (eConv.asString) shouldBe ("((~A|B)&(~C|D))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testNestedImpliesToOrTwo {
      def e = a.implies(b.implies(c))
      def eConv = e.removeImplies
      assert (e.asString) shouldBe ("(A=>(B=>C))")
      assert (eConv.asString) shouldBe ("(~A|(~B|C))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testIffToImplies {
      def e = a.iff(b)
      def eConv = e.removeIff
      assert (e.asString) shouldBe ("(A<=>B)")
      assert (eConv.asString) shouldBe ("((A=>B)&(B=>A))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testNestedIffToImpliesOne {
      def e = (a.iff(b)).and(c.iff(d))
      def eConv = e.removeIff
      assert (e.asString) shouldBe ("((A<=>B)&(C<=>D))")
      assert (eConv.asString) shouldBe ("(((A=>B)&(B=>A))&((C=>D)&(D=>C)))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testNestedIffToImpliesTwo {
      def e = a.iff(b.iff(c))
      def eConv = e.removeIff
      assert (e.asString) shouldBe ("(A<=>(B<=>C))")
      assert (eConv.asString) shouldBe ("((A=>((B=>C)&(C=>B)))&(((B=>C)&(C=>B))=>A))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testremoveImplications {
      def e = a.iff(b)
      def eConv = e.removeImplications
      assert (e.asString) shouldBe ("(A<=>B)")
      assert (eConv.asString) shouldBe ("((~A|B)&(~B|A))")
      assert (e.results.asString) shouldBe (eConv.results.asString)
    }
    method testDistributeAndOverOrOne {
      def e = a.and(b.or(c))
      def eDist = e.distributeAndOverOr
      assert (e.asString) shouldBe ("(A&(B|C))")
      assert (eDist.asString) shouldBe ("((A&B)|(A&C))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeAndOverOrTwo {
      def e = (b.or(c)).and(a)
      def eDist = e.distributeAndOverOr
      assert (e.asString) shouldBe ("((B|C)&A)")
      assert (eDist.asString) shouldBe ("((B&A)|(C&A))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeAndOverOrThree {
      def e = (a.or(b)).and(c.or(d))
      def eDist = e.distributeAndOverOr
      assert (e.asString) shouldBe ("((A|B)&(C|D))")
      assert (eDist.asString) shouldBe ("(((A&C)|(A&D))|((B&C)|(B&D)))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeOrOverAndOne {
      def e = a.or(b.and(c))
      def eDist = e.distributeOrOverAnd
      assert (e.asString) shouldBe ("(A|(B&C))")
      assert (eDist.asString) shouldBe ("((A|B)&(A|C))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeOrOverAndTwo {
      def e = (b.and(c)).or(a)
      def eDist = e.distributeOrOverAnd
      assert (e.asString) shouldBe ("((B&C)|A)")
      assert (eDist.asString) shouldBe ("((B|A)&(C|A))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeOrOverAndThree {
      def e = (a.and(b)).or(c.and(d))
      def eDist = e.distributeOrOverAnd
      assert (e.asString) shouldBe ("((A&B)|(C&D))")
      assert (eDist.asString) shouldBe ("(((A|C)&(A|D))&((B|C)&(B|D)))")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeNotOverAnd {
      def e = (a.and(b)).not
      def eDist = e.distributeNot
      assert (e.asString) shouldBe ("~(A&B)")
      assert (eDist.asString) shouldBe ("(~A|~B)")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testDistributeNotOverOr {
      def e = (a.or(b)).not
      def eDist = e.distributeNot
      assert (e.asString) shouldBe ("~(A|B)")
      assert (eDist.asString) shouldBe ("(~A&~B)")
      assert (e.results.asString) shouldBe (eDist.results.asString)
    }
    method testToCNF {
      def e = a.iff(b)
      def eCNF = e.toCNF
      assert (e.asString) shouldBe ("(A<=>B)")
      assert (eCNF.asString) shouldBe ("((~A|B)&(~B|A))")
      assert (e.results.asString) shouldBe (eCNF.results.asString)
    }
    method testToDNF {
      def e = a.iff(b)
      def eDNF = e.toDNF
      assert (e.asString) shouldBe ("(A<=>B)")
      assert (eDNF.asString) shouldBe ("(((~A&~B)|(~A&A))|((B&~B)|(B&A)))")
      assert (e.results.asString) shouldBe (eDNF.results.asString)
    }
    method testIdempotentAnd {
      def e = a.and(a)
      def eSimp = e.idempotent
      assert (e.asString) shouldBe ("(A&A)")
      assert (eSimp.asString) shouldBe ("A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testIdempotentOr {
      def e = a.or(a)
      def eSimp = e.idempotent
      assert (e.asString) shouldBe ("(A|A)")
      assert (eSimp.asString) shouldBe ("A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testNestedIdempotent{
      def e = (a.and(a)).not
      def eSimp = e.idempotent
      assert (e.asString) shouldBe ("~(A&A)")
      assert (eSimp.asString) shouldBe ("~A")
      assert (e.results.asString) shouldBe (eSimp.results.asString)
    }
    method testComplimentationAndOne {
      def e = a.and(a.not)
      def eSimp = e.complimentation
      assert (e.asString) shouldBe ("(A&~A)")
      assert (eSimp.asString) shouldBe ("ℂ")
    }
    method testComplimentationAndTwo {
      def e = (a.not).and(a)
      def eSimp = e.complimentation
      assert (e.asString) shouldBe ("(~A&A)")
      assert (eSimp.asString) shouldBe ("ℂ")
    }
    method testComplimentationOrOne {
      def e = a.or(a.not)
      def eSimp = e.complimentation
      assert (e.asString) shouldBe ("(A|~A)")
      assert (eSimp.asString) shouldBe ("𝕋")
    }
    method testComplimentationOrTwo {
      def e = (a.not).or(a)
      def eSimp = e.complimentation
      assert (e.asString) shouldBe ("(~A|A)")
      assert (eSimp.asString) shouldBe ("𝕋")
    }
    method testIdentityAndOne {
      def e = a.and(TAU)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(A&𝕋)")
      assert (eSimp.asString) shouldBe ("A")
    }
    method testIdentityAndTwo {
      def e = TAU.and(a)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(𝕋&A)")
      assert (eSimp.asString) shouldBe ("A")
    }
    method testIdentityAndThree {
      def e = a.and(CON)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(A&ℂ)")
      assert (eSimp.asString) shouldBe ("ℂ")
    }
    method testIdentityAndFour {
      def e = CON.and(a)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(ℂ&A)")
      assert (eSimp.asString) shouldBe ("ℂ")
    }
    method testNestedIdentityAndOne {
      def e = (a.and(TAU)).not
      def eSimp = e.identity
      assert (e.asString) shouldBe ("~(A&𝕋)")
      assert (eSimp.asString) shouldBe ("~A")
    }
    method testNestedIdentityAndTwo {
      def e = (a.and(CON)).not
      def eSimp = e.identity
      assert (e.asString) shouldBe ("~(A&ℂ)")
      assert (eSimp.asString) shouldBe ("~ℂ")
    }
    method testIdentityOrOne {
      def e = a.or(TAU)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(A|𝕋)")
      assert (eSimp.asString) shouldBe ("𝕋")
    }
    method testIdentityOrTwo {
      def e = TAU.or(a)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(𝕋|A)")
      assert (eSimp.asString) shouldBe ("𝕋")
    }
    method testIdentityOrThree {
      def e = a.or(CON)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(A|ℂ)")
      assert (eSimp.asString) shouldBe ("A")
    }
    method testIdentityOrFour {
      def e = CON.or(a)
      def eSimp = e.identity
      assert (e.asString) shouldBe ("(ℂ|A)")
      assert (eSimp.asString) shouldBe ("A")
    }
    method testNestedIdentityOrOne {
      def e = (a.or(TAU)).not
      def eSimp = e.identity
      assert (e.asString) shouldBe ("~(A|𝕋)")
      assert (eSimp.asString) shouldBe ("~𝕋")
    }
    method testNestedIdentityOrTwo {
      def e = (a.or(CON)).not
      def eSimp = e.identity
      assert (e.asString) shouldBe ("~(A|ℂ)")
      assert (eSimp.asString) shouldBe ("~A")
    }
  }
}

print "logicTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
