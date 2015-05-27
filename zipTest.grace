import "gUnit" as gU
import "zip" as zip

def test = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)

        method testAsString {
          def result = zip.together(list.with(
            list.with(1)
          ))
          assert (result.asString) shouldBe ("Zip([[1]])")
        }
        
        method testSmallestSize {
            def l1 = list.with(
              list.with(1)
            )
            def l2 = list.with(
              list.with(1,2),
              list.with(3,4,5)
            )
            def l3 = list.with(
              list.with(1,2,3,4),
              list.with(1,2,3),
              list.with(1,2,3,4,5)
            )
            assert (zip.together(l1).smallestSize) shouldBe (1)
            //assert (zip.together(l2).smallestSize) shouldBe (2)
            //assert (zip.together(l3).smallestSize) shouldBe (3)
        }
        method testIterator {
           def result = zip.together(list.with(list.with(1)))
           def i = result.iterator
           assert (i.hasNext) shouldBe(true)
           assert (i.next) shouldBe(list.with(1))
           assert (i.hasNext) shouldBe(false)
           //assert (i.next) shouldRaise(Exhausted)
        }
        method testMap {
          def result = zip.together(list.with(
            list.with(1,2),
            list.with(3,4,5)
          ))
          def actual = list.with(
            list.with(1,3),
            list.with(2,4)
          )
          assert (result.map{each -> each}.asList) shouldBe (actual)
        }
    }
}

print "zipTest"
gU.testSuite.fromTestMethodsIn(test).runAndPrintResults
