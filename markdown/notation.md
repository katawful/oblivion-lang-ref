# Notation
`obl` is a line-based language, i.e. each line must contain a valid execution of code. This is
similar to scripting languages like Vimscript and Bash. However unlike those languages, constructs
are literal and cannot be expanded. A statement must start and end on the same line. Like other
line-based scripting languages, `obl` is mostly based on statements. Though while the languages
mentioned do indeed make heavy use of expressions on each line of code, it's much better to think
of `obl` as a language that exists to update game states first and foremost. In that regard, `obl`
only allows statements on each line, as that is what updates the game state ultimately.
Statements, of course, can include expressions.

The reason for this is an important distinction, and thus separate from similar languages like the
aforementioned Bash and Vimscript, is that there is not a way to create localized functions. One
can only create new scripts entirely, regardless of returned values.

Additionally, as will be explained later, functions themselves are game objects and should be
treated as such. Information on game functions can be found at a later point, but they are not
objects like the object oriented programming model provides. This is the ultimate reason for this
discrepancy and why `obl` shall be considered a statement first language.

For the purposes of this documentation, an extended Backus Naur form (eBNF) is used for notation.

Also note, for the sake of this documentation, a 'construct' will be defined as any valid object
of code related to this language. This definition is solely to discuss all aspects of the language
in a more concise manner.

