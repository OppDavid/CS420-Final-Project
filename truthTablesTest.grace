import "gUnit" as gU
import "truthTables" as truthTables

def test = object {
  class forMethod(p) {
    inherits gU.testCaseNamed(p)

    method testNot { 
      assert (truthTables.not(true)) shouldBe (false)
      assert (truthTables.not(false)) shouldBe (true)
    }  

    method testAnd {
      assert (truthTables.and(true, true)) shouldBe (true)
      assert (truthTables.and(true, false)) shouldBe (false)
      assert (truthTables.and(false, true)) shouldBe (false)
      assert (truthTables.and(false, false)) shouldBe (false)
    }

    method testOr {
      assert (truthTables.or(true, true)) shouldBe (true)
      assert (truthTables.or(true, false)) shouldBe (true)
      assert (truthTables.or(false, true)) shouldBe (true)
      assert (truthTables.or(false, false)) shouldBe (false)
    }

    method testImplies {
      assert (truthTables.implies(true, true)) shouldBe (true)
      assert (truthTables.implies(true, false)) shouldBe (false)
      assert (truthTables.implies(false, true)) shouldBe (true)
      assert (truthTables.implies(false, false)) shouldBe (true)
    }

    method testIff {
      assert (truthTables.iff(true, true)) shouldBe (true)
      assert (truthTables.iff(true, false)) shouldBe (false)
      assert (truthTables.iff(false, true)) shouldBe (false)
      assert (truthTables.iff(false, false)) shouldBe (false)
    }

    method testNand {
      assert (truthTables.nand(true, true)) shouldBe (false)
      assert (truthTables.nand(true, false)) shouldBe (true)
      assert (truthTables.nand(false, true)) shouldBe (true)
      assert (truthTables.nand(false, false)) shouldBe (true)
    }

    method testNor {
      assert (truthTables.nor(true, true)) shouldBe (false)
      assert (truthTables.nor(true, false)) shouldBe (true)
      assert (truthTables.nor(false, true)) shouldBe (true)
      assert (truthTables.nor(false, false)) shouldBe (false)
    }
  }
}

print "truthTablesTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
