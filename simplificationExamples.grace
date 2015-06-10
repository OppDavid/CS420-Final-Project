import "logic" as logic

def a = logic.predicate("A")
def b = logic.predicate("B")
def c = logic.predicate("C")

var exp
var exp2
var exp3
var exp4
var exp5
var exp6
def CON = logic.contradiction
def TAU = logic.tautology

print("Sample Logic.grace simplifications\n")

// removeNots
print("\nRemove Nots Simplification\n")
exp := a.not.not
exp2 := exp.removeNots

print("  Let exp = {exp}")
print("  exp.removeNots -> " ++ exp2);

// removeImplies
print("\nRemove Implies Simplification\n")
exp := a.implies(b)
exp2 := exp.removeImplies

print("  Let exp = {exp}")
print("  exp.removeImplies -> " ++ exp2);

// removeIff
print("\nRemove If and Only If Simplification\n")
exp := a.iff(b)
exp2 := exp.removeIff

print("  Let exp = {exp}")
print("  exp.removeIff -> " ++ exp2);

// distributeAndOverOr
print("\nRemove Distribute And Over Or \n")
exp := a.and(b.or(c))
exp2 := exp.distributeAndOverOr

print("  Let exp = {exp}")
print("  exp.distributAndOverOr -> " ++ exp2);


// distributeOrOverAnd
print("\nRemove Distribute Or Over And \n")
exp := a.or(b.and(c))
exp2 := exp.distributeAndOverOr

print("  Let exp = {exp}")
print("  exp.distributAndOverOr -> " ++ exp2);

// distributeNot
print("\nDistribute Not (DeMorgan's Law)\n")
exp := (a.and(b)).not
exp2 := (a.or(b)).not
exp3 := exp.distributeNot
exp4 := exp2.distributeNot

print("  Let exp = {exp} and exp2 = {exp2}")
print("  exp.distributeNot -> " ++ exp3);
print("  exp2.distributeNot -> " ++ exp4);

// idempotent
print("\nIdempotent\n")
exp := (a.and(a))
exp2 := (a.or(a))
exp3 := exp.idempotent
exp4 := exp2.idempotent

print("  Let exp = {exp} and exp2 = {exp2}")
print("  exp.idempotent -> " ++ exp3)
print("  exp2.idempotent -> " ++ exp4)

// complimentation
print("\nComplimentation\n")
exp := (a.and(a.not))
exp2 := (a.or(a.not))
exp3 := exp.complimentation
exp4 := exp2.complimentation

print("  Let exp = {exp} and exp2 = {exp2}")
print("  exp.complimentation -> " ++ exp3)
print("  exp2.complimenation -> " ++ exp4)

// identity 
print("\nIdentity\n")
exp := (a.and(TAU))
exp2 := (a.or(TAU))
exp3 := (a.and(CON))
exp4 := (a.or(CON))

print("  Let exp = {exp} and exp2 = {exp2}")
print("  And exp3 = {exp3} and exp4 = {exp4}")
print("  exp.identity -> " ++ exp.identity)
print("  exp2.identity -> " ++ exp2.identity)
print("  exp3.identity -> " ++ exp3.identity)
print("  exp4.identity -> " ++ exp4.identity)

print()
