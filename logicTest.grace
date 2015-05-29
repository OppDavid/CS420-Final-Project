import "gUnit" as gU
import "logic" as logic

def test = object {
  class forMethod(p) {
    inherits gU.testCaseNamed(p)
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
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.and(b).asString) shouldBe ("(A&B)")
    }
    method testOrString { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.or(b).asString) shouldBe ("(A|B)")
    }  
    method testImpliesString { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.implies(b).asString) shouldBe ("(A=>B)")
    }  
    method testIffString { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.iff(b).asString) shouldBe ("(A<=>B)")
    }
    method testAndBinaryOperator { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      def e = a&b
      assert (e.asString) shouldBe ("(A&B)")
    }
    method testOrBinaryOperator { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      def e = a|b
      assert (e.asString) shouldBe ("(A|B)")
    }  
    method testImpliesBinaryOperator { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      def e = a=>b
      assert (e.asString) shouldBe ("(A=>B)")
    }  
    method testIffBinaryOperator {  
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      def e = a≡b
      assert (e.asString) shouldBe ("(A<=>B)")
    }
    method testNotUnaryOperator {
      def a = logic.predicate("A")
      def e = ~a
      assert (e.asString) shouldBe ("~A")
    }
    method testSetCrossProductOfOneElementSets {
      def expected = [[1, 2]]
      def actual = logic.setCrossProduct([1], [2])
      assert (actual.asString) shouldBe (expected.asString)
    }
    method testSetCrossProductOfTwoElementSets {
      def expected = [[1, 3], [1, 4], [2, 3], [2, 4]]
      def actual = logic.setCrossProduct([1, 2], [3, 4])
      assert (actual.asString) shouldBe (expected.asString)
    }
    // This should also work...
    method testBuildTruthTableStatesWithOne {
      def a = [[true], [false]]
      def b = logic.buildTruthTableStates(1)
      assert (b.asString) shouldBe (a.asString) // Using asString because faulty list comparison
    }
    // This should work 
    method testBuildTruthTableStatesWithTwo {
      def a = [[true, true], [true, false], [false, true], [false, false]]
      def b = logic.buildTruthTableStates(2)
      assert (a.asString) shouldBe (b.asString)
    }
    method testCopyEquality {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        def f = e.copy
        assert (f.asString) shouldBe ("(A&B)")
    }
    method testCopyImutabilty {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        def f = e.copy
        f.operand1 := logic.predicate("C")
        assert (e.asString) shouldBe ("(A&B)")
        assert (f.asString) shouldBe ("(C&B)")
    }
    method testIsNotOperator {
        def a = logic.predicate("A")
        def e = a.not
        assert (e.isNotOperator) shouldBe (true)
    }
    method testIsAndOperatorTest {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        assert (e.isAndOperator) shouldBe (true)
    }
    method testIsOrOperator {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.or(b)
        assert (e.isOrOperator) shouldBe (true)
    }
    method testIsImpliesOperator {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.implies(b)
        assert (e.isImpliesOperator) shouldBe (true)
    }
    method testIsIffOperator {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.iff(b)
        assert (e.isIffOperator) shouldBe (true)
    }
    method testIsTautology {
        def a = logic.predicate("A")
        def e = a.or(a.not)
        assert (e.isTautology) shouldBe (true)
    }
    method testIsContradiction {
        def a = logic.predicate("A")
        def e = a.and(a.not)
        assert (e.isContradiction) shouldBe (true)
    }
    method testIsConditional {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        assert (a.isConditional) shouldBe (true)
    }
    method testPredicateEquality {
        def a = logic.predicate("A")
        assert ( a == a ) shouldBe (true)
    }
    method testExpresionEquality {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        assert ( e == e ) shouldBe (true)
    }
    method testPredicateNotEquality {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        assert ( a != b ) shouldBe (true)
    }
    method testExpresionNotEquality {
        def a = logic.predicate("A")
        def b = logic.predicate("B")
        def e = a.and(b)
        def f = a.or(b)
        assert ( e != f ) shouldBe (true)
    }
  }
}

print "logicTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
