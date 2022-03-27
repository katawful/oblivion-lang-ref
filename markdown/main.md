  title: oblivion-language
  description: 
  authors: kat
  categories: 
  created: 2022-01-14
  version: 0.0.11

Oblivion

Table of Contents

# Oblivion Scripting Language Reference for xOBSE v22.6.1
Oblivion Language (obl) is a dynamically typed interpreted language for the video game _The Elder
Scrolls IV: Oblivion_. While language within development tools refers to "compilation" of scripts,
it is only a temporary transpilation to, mildly human readable, internal game (not machine)
bytecode. It is thus purely interpreted in function, running all scripts as they finish serially
in a single thread. The order of execution is based on the order of internal ID the script _or_
object attached to script is bound to.
language-reference core test- verify that "compilation" is just parsing

`obl` has been expanded upon by the community, first with **OB**livion **S**cript **E**xtender
(OBSE), then in recent years with xOBSE. Because of the wide spread usage and the greatly expanded
syntax, this documentation will simply be assuming the features provided with the original game
are not solely valid. Any problems related to that will be discussed as they arrive.

[Language Notation](#notationmd)
[General Language Constructs](#constructsmd)

## Language
[Lexical Conventions](#languagelexicalmd)
[Operators](#languageoperatorsmd)
[Available Types](#languagetypesmd)
[Script Types](#languagescripttypesmd)
[Variable Types](#languagevariablesmd)
[Language Statements](#languagestatementsmd)

[Main Details](#expressionsmainmd)

vim:tw=100:ft=norg:norl: