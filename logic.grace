import "truthTables" as truthTables 
// import "zip" as zip

factory method expression {
    // We would rather not calculate these values everytime these methods are invoked,
    // but methods were needed instead of defs to use inheritance.
    method states {buildTruthTableStates(self.predicates.size) } 
    method containedPredicates { self.predicates } 
    method results { 
      var returnResults := list.empty() 
      states.do { state ->
        (1..(state.size)).do { i ->
            containedPredicates.at(i).state := state.at(i)
        }
        returnResults.addLast(self.evaluate)
      }
      returnResults
    }
    // These three "is" functions should be done
    // by type checking... Does that work in grace?
    method isPredicate { abstract }
    method isUnaryOperator { abstract }
    method isBinaryOperator { abstract }
    method evaluate { abstract }
    method predicates { abstract }
    method not { notOperator(self) }  
    method and (other) { andOperator(self, other) }  
    method or (other) { orOperator(self, other) }  
    method implies (other) { impliesOperator(self, other) }  
    method iff (other) { iffOperator(self, other) }
    method &(other) { and(other) }
    method |(other) { or(other) }
    method =>(other) { implies(other) }
    method ≡(other) { iff(other) }
    method prefix~ { self.not }
    
    method copy { abstract }
    
    method ==(other) {
        if (self.asString == other.asString) then { return true }
        false
    }
    
    method !=(other) {
        ( self == other ).not
    }
    
    method isTautology {
        results.do { each ->
            if ( !each ) then {
                return false
            }
        }
        true
    }
    
    method isContradiction {
        results.do { each ->
            if ( each ) then {
                return false
            }
        }
        true
    }
    
    method isConditional {
        if (isTautology) then { return false }
        if (isContradiction) then { return false }
        true
    }
    
    method simplificationRemoveNotNot {
        var returnExp := self.copy
        if ( returnExp.isUnaryOperator ) then {
            returnExp.operand := returnExp.operand.simplificationRemoveNotNot
            // The patern to simplify is detected here
            if ( returnExp.isNotOperator ) then {
                if ( returnExp.operand.isNotOperator ) then {
                    returnExp := returnExp.operand.operand
                }
            }
        } elseif ( returnExp.isBinaryOperator ) then {
            returnExp.operand1 := returnExp.operand1.simplificationRemoveNotNot
            returnExp.operand2 := returnExp.operand2.simplificationRemoveNotNot
        }
        returnExp
    }
    
    method conversionImpliesToOr {
        var returnExp := self.copy
        if ( returnExp.isUnaryOperator ) then {
            returnExp.operand := returnExp.operand.conversionImpliesToOr
        } elseif ( returnExp.isBinaryOperator ) then {
            returnExp.operand1 := returnExp.operand1.conversionImpliesToOr
            returnExp.operand2 := returnExp.operand2.conversionImpliesToOr
            // Patern to convert detected here
            if ( returnExp.isImpliesOperator ) then {
                returnExp := orOperator(returnExp.operand1.not, returnExp.operand2)
            }
        }
        returnExp
    }
    
    method conversionIffToImplies {
        var returnExp := self.copy
        if ( returnExp.isUnaryOperator ) then {
            returnExp.operand := returnExp.operand.conversionIffToImplies
        } elseif ( returnExp.isBinaryOperator ) then {
            returnExp.operand1 := returnExp.operand1.conversionIffToImplies
            returnExp.operand2 := returnExp.operand2.conversionIffToImplies
            // Patern to convert detected here
            if ( returnExp.isIffOperator ) then {
                returnExp := andOperator(impliesOperator(returnExp.operand1.copy, returnExp.operand2.copy), impliesOperator(returnExp.operand2, returnExp.operand1))
            }
        }
        returnExp
    }
    
    method distributeAndOverOr {
        var returnExp := self.copy
        if ( returnExp.isUnaryOperator ) then {
            returnExp.operand := returnExp.operand.distributeAndOverOr
        } elseif ( returnExp.isBinaryOperator ) then {
            returnExp.operand1 := returnExp.operand1.distributeAndOverOr
            returnExp.operand2 := returnExp.operand2.distributeAndOverOr
            
            if ( returnExp.isAndOperator ) then {
                if ( returnExp.operand1.isOrOperator ) then {
                    returnExp := (returnExp.operand1.operand1.and(returnExp.operand2)).or(returnExp.operand1.operand2.and(returnExp.operand2))
                } elseif ( returnExp.operand2.isOrOperator ) then {
                    returnExp := (returnExp.operand1.and(returnExp.operand2.operand1)).or(returnExp.operand1.and(returnExp.operand2.operand2))
                }
                returnExp.operand1 := returnExp.operand1.distributeAndOverOr
                returnExp.operand2 := returnExp.operand2.distributeAndOverOr
            }
        }
        returnExp
    }
    
    method distributeOrOverAnd {
        var returnExp := self.copy
        if ( returnExp.isUnaryOperator ) then {
            returnExp.operand := returnExp.operand.distributeOrOverAnd
        } elseif ( returnExp.isBinaryOperator ) then {
            returnExp.operand1 := returnExp.operand1.distributeOrOverAnd
            returnExp.operand2 := returnExp.operand2.distributeOrOverAnd
            
            if ( returnExp.isOrOperator ) then {
                if ( returnExp.operand1.isAndOperator ) then {
                    returnExp := (returnExp.operand1.operand1.or(returnExp.operand2)).and(returnExp.operand1.operand2.or(returnExp.operand2))
                } elseif ( returnExp.operand2.isAndOperator ) then {
                    returnExp := (returnExp.operand1.or(returnExp.operand2.operand1)).and(returnExp.operand1.or(returnExp.operand2.operand2))
                }
                returnExp.operand1 := returnExp.operand1.distributeOrOverAnd
                returnExp.operand2 := returnExp.operand2.distributeOrOverAnd
            }
        }
        returnExp
    }
    
    method removeAllImplications {
        var returnExp := self.copy
        returnExp := returnExp.conversionIffToImplies
        returnExp := returnExp.conversionImpliesToOr
        returnExp
    }
    
    method toCNF {
        var returnExp := self.copy
        returnExp := returnExp.removeAllImplications
        returnExp := returnExp.distributeOrOverAnd
        returnExp
    }
    
    method toDNF {
        var returnExp := self.copy
        returnExp := returnExp.removeAllImplications
        returnExp := returnExp.distributeAndOverOr
        returnExp
    }

    // A series of methods are implemented below to allow
    // for any method traversing an expresion to determine
    // the type of experesion it is looking at.  It may be that
    // this is something that should be implimented using types
    // Consider changing such "is_Operator" methods.
    method isNotOperator {
        if ( self.isUnaryOperator ) then {
            if ( self.symbol == "~" ) then {
                return true
            }
        }
        false
    }
    
    method isAndOperator {
        if ( self.isBinaryOperator ) then {
            if ( self.symbol == "&" ) then {
                return true
            }
        }
        false
    }
    
    method isOrOperator {
        if ( self.isBinaryOperator ) then {
            if ( self.symbol == "|" ) then {
                return true
            }
        }
        false
    }
    
    method isImpliesOperator {
        if ( self.isBinaryOperator ) then {
            if ( self.symbol == "=>" ) then {
                return true
            }
        }
        false
    }
    
    method isIffOperator {
        if ( self.isBinaryOperator ) then {
            if ( self.symbol == "<=>" ) then {
                return true
            }
        }
        false
    }

}

factory method truthTable(exp) {
    method asString {
        var output := ""
        var header := exp.containedPredicates.fold { result, it -> 
                                                 result.asString ++ it.asString ++ " | "
                                               } startingWith ""
        header := " " ++ header ++ exp.asString 

        output := output ++ header ++ "\n"
        
        (1..exp.states.size).do { i ->
          exp.states.at(i).do { each ->
            var S
            if (each) then {
                S := "T"
            } else {
                S := "F"
            }
            output := output ++ " {S} | "
          }
          var R
          if (exp.results.at(i)) then {
            R := "T"
          } else {
            R := "F"
          }
          output := output ++ " {R} " ++ "\n" 
        }

        // zip.together(states, results)

        output
   }
}

method predicate(id) { predicate(id) withState (true) }
factory method predicate(id) withState (state') {
    inherits expression
    var state is public := state'
    method isPredicate { true }
    method isUnaryOperator { false }
    method isBinaryOperator { false }
    method asString { "{id}" }
    method evaluate { state }
    method predicates { list.with(self) }
    method hash { id.hash }
    method copy { predicate(id) }
}

factory method operator(symbol') { 
    inherits expression
    // Should be done with type checking
    def symbol is public = symbol'
    method isPredicate { false }
}

factory method unaryOperator(operand', symbol') {
    inherits operator(symbol')
    var operand is public := operand'
    method isUnaryOperator { true }
    method isBinaryOperator { false }
    method predicates { operand.predicates }
    method asString { "{symbol}{operand}" }
}

factory method binaryOperator(operand1', operand2', symbol') {
    inherits operator(symbol')
    var operand1 is public := operand1'
    var operand2 is public := operand2'
    method isUnaryOperator { false }
    method isBinaryOperator { true }
    method predicates { 
        def newList = operand1.predicates.copy
        operand2.predicates.do { each ->
            if (!newList.contains(each)) then { 
                newList.add(each)
            }
        }
        newList
    }
    method asString { "({operand1}{symbol}{operand2})" }
}

factory method notOperator(operand') {
    inherits unaryOperator(operand', "~")
    method evaluate { truthTables.not(operand.evaluate) }
    method copy { notOperator(operand.copy) }
}

factory method andOperator(operand1', operand2') {
    inherits binaryOperator(operand1', operand2', "&")
    method evaluate { truthTables.and(operand1.evaluate, operand2.evaluate) }
    method copy { andOperator(operand1.copy, operand2.copy) }
}

factory method orOperator(operand1', operand2') {
    inherits binaryOperator(operand1', operand2', "|")
    method evaluate { truthTables.or(operand1.evaluate, operand2.evaluate) }
        method copy { orOperator(operand1.copy, operand2.copy) }
}

factory method impliesOperator(operand1', operand2') {
    inherits binaryOperator(operand1', operand2', "=>")
    method evaluate { truthTables.implies(operand1.evaluate, operand2.evaluate) }
    method copy { impliesOperator(operand1.copy, operand2.copy) }
}

factory method iffOperator(operand1', operand2') {
    inherits binaryOperator(operand1', operand2', "<=>")
    method evaluate { truthTables.iff(operand1.evaluate, operand2.evaluate) }
    method copy { iffOperator(operand1.copy, operand2.copy) }
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
  var states := list.with(list.with(true), list.with(false))
  for (1..(numberOfPredicates-1)) do { i -> 
    states := setCrossProduct(states, list.with(true, false))
  }
  states
}
