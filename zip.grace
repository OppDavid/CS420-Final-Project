import "utils" as utils

factory method together(xs) {
    method asString { "Zip({xs})" }
    method do(block1) { iterator.do(block1) }
    method map(block1) { iterator.map(block1) }
    method fold(block1) startingWith(initial) { 
      iterator.fold(block1) startingWith(initial) 
    }
    method filter(selectionCondition) { iterator.selectionCondition }
    factory method iterator<T> {
      var index := 1
      method hasNext { index <= smallestSize }
      method next {
        if (!hasNext) then { Exhausted.raise "on Zip" }
        def result = xs.map { each -> each.at(index) }.asList
        index := index + 1
        result
      }
      method do(block1) {
        while { hasNext } do { block1.apply(next) }
      }
      method map(block1) {
        def results = list.empty
        while { hasNext } do { results.addLast(block1.apply(next)) }
        results
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
