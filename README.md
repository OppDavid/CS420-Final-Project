# Logic Library

# Use

    import "logic" as logic

# Predicates
Predicates are atoms in a logic expression

    def a = logic.predicate("A")
    def b = logic.predicate("B")

# Expressions
Expressions are predicate and operator statements
    
    def expr = a & b

## Available operators
* not:  `~a`
* and:  `a & b`
* or:   `a | b`
* implies:  `a => b`
* if and only if:   `a ≡ b`
  
  The iff operator is unicode U+2261. This operation can also be called by `a.iff(b)`.

## Expression evaluation
Expressions have a set of methods that can be used to determine properties of the expressions.
* Truth
* Truth Tables

    print(truthTable(expr))

* isTautology

Returns true if the expression is a tautology

* isContradiction

Returns true if the expression is a contradiction

* isConditional

Returns true if the expression is conditional

* simplificationRemoveNotNot

Returns an expression with double nots removed

    def expr = ~~a
    def simplified = expr.simplificationRemoveNotNot  \\ a

