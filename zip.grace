// zip.grace

import "utils" as utils
import "gUnit" as gU

factory method together(xs) {
    method asString { "Zip({xs})" }
    method do(block1) { iterator.do(block1) }
    method map(block1) { iterator.map(block1) }
    method fold(block1) startingWith(initial) { iterator.fold(block1) startingWith(initial) }
    method filter(selectionCondition) { iterator.selectionCondition }
    factory method iterator<T> {
      inherits iterable.trait<T>
      var index := 1
      method hasNext { index <= smallestSize }
      method next {
        if (!hasNext) then { Exhausted.raise "on Zip" }
        def result = xs.map { each -> each.at(index) }.asList
        index := index + 1
        result
      }
    }
    method smallestSize {
      def sizes = xs.map { each -> each.size}.asList
      sizes.fold { left, right ->
        if (left == done) then { 
          print("- right: {right}")
          right 
        } else { 
          utils.min(left, right) 
        }
      } startingWith (sizes.at(1))
    }
}

// Tests

def zipTest = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)
        
        method testAsString {
          def zip = together(list.with(
            list.with(1)
          ))
          assert (zip.asString) shouldBe ("Zip([[1]])")
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
            assert (together(l1).smallestSize) shouldBe (1)
            //assert (together(l2).smallestSize) shouldBe (2)
            //assert (together(l3).smallestSize) shouldBe (3)
        }
        method testIterator {
           def zip = together(list.with(list.with(1)))
           def i = zip.iterator
           assert (i.hasNext) shouldBe(true)
           assert (i.next) shouldBe(list.with(1))
           assert (i.hasNext) shouldBe(false)
           //assert (i.next) shouldRaise(Exhausted)
        }
        method testMap {
          def zip = together(list.with(
            list.with(1,2),
            list.with(3,4,5)
          ))
          def result = list.with(
            list.with(1,3),
            list.with(2,4)
          )
          assert (zip.map{each -> each}.asList) shouldBe (result)
        }
    }
}

print "zips"
gU.testSuite.fromTestMethodsIn(zipTest).runAndPrintResults
