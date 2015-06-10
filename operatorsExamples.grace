import "logic" as logic

def a = logic.predicate("A")
def b = logic.predicate("B")
def c = logic.predicate("C")

var exp
var exp2

print("Sample Logic.grace operators\n")

// Not
print("Not operator examples\n")
exp := a.not
print("  a.not -> " ++ exp)
exp := ~b
print("  ~b -> " ++ exp)
print()
logic.printTruthTable(exp)


// And 
print("\nAnd operator examples\n")
exp := a.and(b)
print("  a.and(b) -> " ++ exp)
exp := a & b
print("  a & b -> " ++ exp)
print()
logic.printTruthTable(exp)

// Or 
print("\nOr operator examples\n")
exp := a.or(b)
print("  a.or(b) -> " ++ exp)
exp := a | b
print("  a | b -> " ++ exp)
print()
logic.printTruthTable(exp)

// Implies 
print("\nImplies operator examples\n")
exp := a.implies(b)
print("  a.implies(b) -> " ++ exp)
exp := a => b
print("  a => b -> " ++ exp)
print()
logic.printTruthTable(exp)

// Iff
print("\nIf and only if operator examples\n")
exp := a.iff(b)
print("  a.iff(b) -> " ++ exp)
exp := a ≡ b
print("  a ≡ b -> " ++ exp)
print()
logic.printTruthTable(exp)


// isTautology and isContradiction
print("\nIs Tautology and Contradiction check\n")
exp := a.or(a.not)
exp2 := b.and(b.not)
print("  Let exp = {exp} and exp2 = {exp2}\n")
print("  exp.isTautology -> " ++ exp.isTautology)
print("  exp.isContradiction -> " ++ exp.isContradiction ++ "\n")

print("  exp2.isTautology -> " ++ exp2.isTautology)
print("  exp2.isContradiction -> " ++ exp2.isContradiction)

print()
logic.printTruthTable(exp)
print()
logic.printTruthTable(exp2)

print()
