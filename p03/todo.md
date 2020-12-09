# Compilers - Project 3

Due: Friday, December 11, 2020 at 11:59 p.m. 

## Objective

* Build a parser for MYC++ language. 

## MYC++ has the following form:

* `PROGRAM declarations BEGIN body END;`

* Variable declarations look like this:
  `type variable;`
  * Where `type` can be `INTEGER`, `REAL`, or `STRING`, and the variable 
    has to follow the format described in Project 2. 
    * **TODO: EXPAND ON THIS**
    
  * Both parts, `declaration` and `body`, can have any number of statements 
  (separated by semicolons). In `body`, there are three types of statements: 
  assignment, write, and expression:

      `variable := expression;`

  * Expressions can have one of the following forms:
    - `operand binary_op operand` 
    - `operand` 

  * `binary_op` could be any of the following operators: +, -, +, /, and **. 
  An `operand` can be either a variable or a number. Operands must have the 
  same data type. For example, `5 + 5.5` should result in a syntax error. 
  Operations can be performed on integer and real numbers. Operations 
  cannot be performed on strings. String variables can be declared, and 
  strings can be assigned to string variables or printed on the string using 
  `WRITE` statements. 

  * Operations are prioritized as follows: 
    - Parentheses
    - ** 
    - * and / 
    - + and -

  * All operations have left to right associativity (except **, which has 
  right to left associativity). 
    
