import "truthTables" as truthTables 
//import "zip" as zip

factory method expression { 
    def thisObject = self
    method evaluate { abstract }
    method predicates { abstract }
    method not { notOperator(self) }  
    method and (other) { andOperator(self, other) }  
    method or (other) { orOperator(self, other) }  
    method implies (other) { impliesOperator(self, other) }  
    method iff (other) { iffOperator(self, other) }  
    factory method truthTable {
    //    def states = buildTruthTableStates(thisObject.predicates.size)            
    //    def containedPredicates = thisObject.predicates
    //    def results = list.empty() 
    //    // Compute results
    //    {
    //        states.do { state ->
    //            (1..(state.size)).do { i ->
    //                containedPredicates.at(i).state := state.at(i)
    //            }
    //            results.addLast(evaluate)
    //        }
    //    }.apply

    //    method asString {
    //        var output := ""

    //        var header := containedPredicates.fold { result, it -> 
    //            result.asString ++ it.asString ++ " | "
    //        } startingWith ""
    //        header := header ++ outer.asString 

    //        output := output ++ header ++ "\n"
    //         
    //        //zip.together(states, results)

    //        output
    //    }
    }
}

method predicate(id) { predicate(id) withState (true) }
factory method predicate(id) withState (state') {
    inherits expression
    var state is public := state'
    method asString { "{id}" }
    method evaluate { state }
    method predicates { list.with(self) }
    method hash { id.hash }
}

factory method operator { 
    inherits expression
}

factory method unaryOperator(operand) {
    inherits operator
    method predicates { operand.predicates }
}

factory method binaryOperator(operand1, operand2) {
    inherits operator
    method predicates { 
        def newList = operand1.predicates.copy
        operand2.predicates.do { each ->
            if (!newList.contains(each)) then { 
                newList.add(each)
            }
        }
        newList
    }
}

factory method notOperator(operand) {
    inherits unaryOperator(operand)
    method asString { "~{operand}" }
    method evaluate { truthTables.not(operand.evaluate) }
}

factory method andOperator(operand1, operand2) {
    inherits binaryOperator(operand1, operand2)
    method asString { "({operand1}&{operand2})" }
    method evaluate { truthTables.and(operand1.evaluate, operand2.evaluate) }
}

factory method orOperator(operand1, operand2) {
    inherits binaryOperator(operand1, operand2)
    method asString { "({operand1}|{operand2})" }
    method evaluate { truthTables.or(operand1.evaluate, operand2.evaluate) }
}

factory method impliesOperator(operand1, operand2) {
    inherits binaryOperator(operand1, operand2)
    method asString { "({operand1}->{operand2})" }
    method evaluate { truthTables.implies(operand1.evaluate, operand2.evaluate) }
}

factory method iffOperator(operand1, operand2) {
    inherits binaryOperator(operand1, operand2)
    method asString { "({operand1}<->{operand2})" }
    method evaluate { truthTables.iff(operand1.evaluate, operand2.evaluate) }
}

//
// These should be in the set
//
method setCrossProduct(set1, set2) {
  // setCrossProduct([a, b], [c, d])
  // -> [[a, c, d], [b, c, d]]
  def newSet: Set = list.empty
  var newElement: List
  set1.do { eachSet1Element ->
    set2.do { eachSet2Element ->
      newElement := list.empty
      try {
        newElement.addAll(eachSet1Element)
      } catch { exception ->
        newElement.add(eachSet1Element)
      }
      try {
        newElement.addAll(eachSet2Element)
      } catch { exception ->
        newElement.add(eachSet2Element)
      }
      newSet.add(newElement)
    }
  }
  newSet
}

method buildTruthTableStates(numberOfPredicates) {
  // buildTruthTableStates(2) ->
  // [[T, T], [T, F], [F, T], [F, F]] 
  var states := list.with(true, false)
  for (1..(numberOfPredicates-1)) do { i -> 
    states := setCrossProduct(states, list.with(true, false))
  }
  states
}

def A = predicate("A")
def B = predicate("B")
def E = A.and(B)
print(E)
print(E.truthTable)
