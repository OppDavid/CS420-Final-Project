factory method expression { 
    method not { notOperator(self) }  
    method and (other) { andOperator(self, other) }  
    method or (other) { orOperator(self, other) }  
    method implies (other) { impliesOperator(self, other) }  
    method iff (other) { iffOperator(self, other) }  
}


factory method predicate(id) {
    inherits expression
    method asString { "{id}" }
}


factory method operator { 
    inherits expression
}

factory method notOperator(operand) {
    inherits operator
    method asString { "~{operand}" }
}

factory method andOperator(operand1, operand2) {
    inherits operator
    method asString { "({operand1}&{operand2})" }
}

factory method orOperator(operand1, operand2) {
    inherits operator
    method asString { "({operand1}|{operand2})" }
}

factory method impliesOperator(operand1, operand2) {
    inherits operator
    method asString { "({operand1}->{operand2})" }
}

factory method iffOperator(operand1, operand2) {
    inherits operator
    method asString { "({operand1}<->{operand2})" }
}

