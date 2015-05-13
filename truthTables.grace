method not(p) { !p }

method and(p, q) { p && q }

method or(p, q) { p || q }

method xor(p, q) { ( p || q ) && !( p && q ) }

method implies(p, q) { (!p) || q }

method iff(p, q) { implies(p, q) && implies(q, p) }

method nand(p, q) { !and(p, q) }

method nor(p, q) { !or(p, q) }