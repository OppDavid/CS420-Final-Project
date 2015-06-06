import "gUnit" as gU
import "equivalances" as equiv

def test = object {
  class forMethod(p) {
    inherits gU.testCaseNamed(p)

    method testNot { 
      assert (equiv.not(true)) shouldBe (false)
      assert (equiv.not(false)) shouldBe (true)
    }  

    method testAnd {
      assert (equiv.and(true, true)) shouldBe (true)
      assert (equiv.and(true, false)) shouldBe (false)
      assert (equiv.and(false, true)) shouldBe (false)
      assert (equiv.and(false, false)) shouldBe (false)
    }

    method testOr {
      assert (equiv.or(true, true)) shouldBe (true)
      assert (equiv.or(true, false)) shouldBe (true)
      assert (equiv.or(false, true)) shouldBe (true)
      assert (equiv.or(false, false)) shouldBe (false)
    }

    method testImplies {
      assert (equiv.implies(true, true)) shouldBe (true)
      assert (equiv.implies(true, false)) shouldBe (false)
      assert (equiv.implies(false, true)) shouldBe (true)
      assert (equiv.implies(false, false)) shouldBe (true)
    }

    method testIff {
      assert (equiv.iff(true, true)) shouldBe (true)
      assert (equiv.iff(true, false)) shouldBe (false)
      assert (equiv.iff(false, true)) shouldBe (false)
      assert (equiv.iff(false, false)) shouldBe (true)
    }

    method testNand {
      assert (equiv.nand(true, true)) shouldBe (false)
      assert (equiv.nand(true, false)) shouldBe (true)
      assert (equiv.nand(false, true)) shouldBe (true)
      assert (equiv.nand(false, false)) shouldBe (true)
    }

    method testNor {
      assert (equiv.nor(true, true)) shouldBe (false)
      assert (equiv.nor(true, false)) shouldBe (false)
      assert (equiv.nor(false, true)) shouldBe (false)
      assert (equiv.nor(false, false)) shouldBe (true)
    }
  }
}

print "equivTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
