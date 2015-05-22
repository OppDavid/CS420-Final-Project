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
      assert (a.implies(b).asString) shouldBe ("(A->B)")
    }  
    method testIffString { 
      def a = logic.predicate("A")
      def b = logic.predicate("B")
      assert (a.iff(b).asString) shouldBe ("(A<->B)")
    }  
  }
}

print "logicTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
