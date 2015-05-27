import "gUnit" as gU
import "logic" as logic

def test = object {
  class forMethod(p) {
    inherits gU.testCaseNamed(p)
    method testPredicateAsString { 
      assert (logic.predicate("A").asString) shouldBe ("A")
    }  
    method testPredicatePredicates {
//      assert (logic.predicate("A").predicates) shouldBe (list.with(logic.predicate("A")))
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
      assert (a.implies(b).asString) shouldBe ("(A->B)")
    }  
    method testIffString { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.iff(b).asString) shouldBe ("(A<->B)")
    } 
    method testSetCrossProductOfOneElementSets {
      def expected = [[1, 2]]
      def actual = logic.setCrossProduct([1], [2])
      assert (actual) shouldBe (expected)
    }
    method testSetCrossProductOfTwoElementSets {
      def expected = [[1, 3], [1, 4], [2, 3], [2, 4]]
      def actual = logic.setCrossProduct([1, 2], [3, 4])
      assert (actual) shouldBe (expected)
    }
    // This should also work...
    method testBuildTruthTableStatesWithOne {
    //  def a = [[true], [false]]
    //  def b = logic.buildTruthTableStates(1)
    //  assert (a) shouldBe (b)
    }
    // This should work 
    method testBuildTruthTableStatesWithTwo {
    //  def a = [[true, true], [true, false], [false, true], [false, false]]
    //  def b = logic.buildTruthTableStates(2)
    //  assert (a) shouldBe (b)
    }
  }
}

print "logicTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
