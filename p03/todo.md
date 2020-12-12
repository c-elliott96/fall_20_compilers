# Compilers - Project 3

Due: Friday, December 11, 2020 at 11:59 p.m. 

## Objective:

* Build a parser for MYC++ language. 

## MYC++ has the following form:

* `PROGRAM declarations BEGIN body END;`

## Variable declarations:

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

  * `binary_op` could be any of the following operators: `+`, `-`, `+`, `/`, 
  and `**` 

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

  * All operations have left to right associativity (except `**`, which has 
  right to left associativity). 
    
## Output 

The output of your parser must be either:

1. A message indicating **no syntax errors** in addition to the output of the 
**write** statements. 

2. An error (exception). For the following errors, the line number where the 
error occurs and a specific error message should be displayed. 
Examples: 
  * Division by zero
  * The use of an undeclared identifier
  * The operands of an expression have different data types
  * Redefinition of a variable

### Self notes:
* We take in a .MYCPP file
* It MUST have the form described above
* We need a way to store variables, along with their types. 
  * Symbol table (hash, or whatever DS ocaml wants for that)
  * Way to save variable types: store a string of the variable, and append a 
    type. 
  * Then, when we use the variable
    1. Retrieve the string from the symbol table
    2. Extract the type from the string
    3. Check to make sure the operation is valid by type
    4. Return the value the expression evaluates to. 
    * Throwing errors when necessary. 