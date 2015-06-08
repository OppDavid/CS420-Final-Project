method min(x, y) { if (x <= y) then { x } else { y } }
method max(x, y) { if (x >= y) then { x } else { y } }

method setCrossProduct(set1, set2) {
  //
  // NOTE: This should be a method of the set objects
  //
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

def identity = { x -> x }
