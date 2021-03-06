# Statements
Statements are constructs that simply declare an action in the game. They do not return anything
as a result. There are 12 main statements in `obl`:

## "Begin" Blocks
`obl` does not have traditional function blocks. Being a game specific language, the language
instead has constructs that wrap around internal game features. All execution happens within
these blocks, and are colloquially known as "begin blocks". For clarity, this documentation will
use this definition to distinguish these constructs from others. A begin block is defined as 2
top-level lines of code, inside of which all programming is achieved. The first line starts the
begin block and defines which game feature this block runs for, the second line terminates the
block:

```ebnf
beginBlock = startBlock, innerBlock, endBlock;
startBlock = "begin", (gameFeature | function), eol;
function = "function", "{", {paramter}, "}";
endBlock = "end", eol;
```

```obse
scn beginBlock
begin gamemode
end
begin function {}
end
```

A script file can contain any number of "gameFeature" blocks in any order, but a script can only
contain one "function" block with no others.

### Begin Block Game Features
Begin blocks must be attached to specific game features, or be a function. Some take
arguments, optionally or no, and multiple. The syntax is like so:

```ebnf
beginBlock = startBlock, innerBlock, endBlock;
startBlock = "begin", (gameFeature 
                    | function 
                    | coeeGameFeature 
                    | coeeFunction)
                    , eol;
gameFeature = featureName, {parameter};
parameter = identifier | identifier, ",";
```

```obse
scn ExampleBeginBlocks
begin GameMode
end
begin MenuMode 1011
end
begin OnAlarm 0, PlayerREF
end
```

The following is a description of each, parenthesized means it is optional:

### General Block Types

|Game Feature | (Number of Arguments) | Type | Description|
|-|-|-|-|
|'GameMode' | 0 | n/a | Runs continuously during normal gameplay|
|'MenuMode' | (menuType) | int | Runs continuously during any menu, optionally within a specific menu type. See [Menu Types](#Menu-Types)|
|'OnActivate' | 0 | n/a | Runs once when scripted object is activated by an actor, blocks normal activation use of scripted object. Must be scripted back in|
|'OnActorEquip' | objectID | ref | Runs once when scripted actor equips objectID|
|'OnActorUnequip' | objectID | ref | Runs once when scripted actor unequips objectID|
|'OnAdd' | (objectID) | ref | Runs once whenever script object is added to an inventory or objectID's inventory. See [OnAdd](#OnAdd)|
|'OnAlarm' | crimeType, (actorID) | int, ref | Runs once whenever scripted actor receives alarm of crimeType, optionally caused by the actorID|
|'OnAlarmVictim' | crimeType, (actorID) | int, ref | Runs once whenever scripted actor receives alarm of crimeType, optionally on the actorID|
|'OnDeath' | (actorID) | ref | Runs once whenever the scripted actor dies, optionally if the actorID kills said actor. See [OnDeath](#OnDeath)|
|'OnDrop' | (actorID) | ref | Runs once whenever the scripted object is removed from an inventory, optionally from the actorID's inventory. See [OnDrop](#OnDrop)|
|'OnEquip' | (actorID) | ref | Runs once whenever the scripted object is equipped, optionally by the actorID. See [OnEquip](#OnEquip)|
|'OnHit' | (actorID) | ref | Runs once whenever the scripted actor is hit, optionally hit by the actorID. See [OnHit](#OnHit)|
|'OnHitWith' | (objectID) | ref | Runs once whenever the scripted actor/object is hit by any weapon, optionally hit by the objectID. See [OnHitWith](#OnHitWith)|
|'OnKnockout' | 0 | n/a | Runs once whenever the scripted actor enters the "knocked out" state|
|'OnLoad' | 0 | n/a | Runs once whenever the scripted object's 3D model loads. See [OnLoad](#OnLoad)|
|'OnMagicEffectHit' | (effectID) | chars | Runs once whenever the scripted actor/object is hit by any magic effect, optionally hit by the effectID. See [OnMagicEffectHit](#OnMagicEffectHit)|
|'OnMurder' | (actorID) | ref | Non-functional block type. See [OnMurder](#OnMurder)|
|'OnPackageChange' | packageID | ref | Runs once whenever the scripted actor changes from the packageID to some other packageID. See [OnPackageChange](#OnPackageChange)|
|'OnPackageDone' | packageID | ref | Runs once whenever the scripted actor finishes packageID. See [OnPackageDone](#OnPackageDone)|
|'OnPackageEnd' | packageID | ref | Alias for OnPackageDone. See [OnPackageDone](#OnPackageDone)|
|'OnPackageStart' | packageID | ref | Runs once whenever the scripted actor starts packageID|
|'OnReset' | 0 | n/a | Runs once when the scripted object's cell is reset due to time expiration|
|'OnSell' | (actorID) | ref | Runs once when the scripted object is sold, optionally when sold by actorID|
|'OnStartCombat' | (actorID) | ref | Runs once when the scripted actor enters combat, optionally when starting combat with actorID|
|'OnTrigger' | (objectID) | ref | Runs continuously whenever anything is colliding with the scripted object, optionally by objectID|
|'OnTriggerActor' | (actorID) | ref | Runs continuously whenever an actor is colliding with the scripted object, optionally by actorID|
|'OnTriggerMob' | (actorID) | ref | Runs continuously whenever a mobile object is colliding with the scripted object, optionally by actorID. See [OnTriggerMob](#OnTriggerMob)|
|'OnUnequip' | (actorID) | ref | Runs once whenever the scripted object is unequipped, optionally by the actorID. See [OnUnequip](#OnUnequip)|

### Magic Effect Block Types

The following are only available for magic effect scripts:

|Game Feature | (Number of Arguments) | Type | Description|
|-|-|-|-|
|'ScriptEffectFinish' | 0 | n/a | Runs once whenever the scripted spell effect finishes. See [ScriptEffectFinish](#ScriptEffectFinish)|
|'ScriptEffectStart' | 0 | n/a | Runs on the first iteration of a scripted spell effect. See [ScriptEffectStart](#ScriptEffectStart)|
|'ScriptEffectUpdate' | 0 | n/a | Runs on the first iteration of a scripted spell effect and each time it runs. See [ScriptEffectUpdate](#ScriptEffectUpdate)|

Notes:
- objectID is the ID of some object of any kind that can be interacted with, such as an actor or item
- actorID is the ID of an actor, i.e. a humanoid
- effectID is an unenclosed 4 letter chars of a magic effect
- packageID is the ID of an AI package

### Menu Types

|General Type|
|-|
|Number | Type|
|-|-|
|1 | Stats, magic, inventory, quest log|
|2 | Any other non-console menu|
|3 | Console: broken functionality, use function `IsConsoleOpen`|

|Specific Type|
|-|
|Number | Type|
|-|-|
|1001 | Message|
|1002 | Inventory|
|1003 | Stats|
|1004 | HUDMain|
|1005 | HUDInfo|
|1006 | HUDReticle|
|1007 | Loading|
|1008 | Container, Barter|
|1009 | Dialog|
|1010 | HUDSubtitle|
|1011 | Generic|
|1012 | SleepWait|
|1013 | Pause|
|1014 | LockPick|
|1015 | Options|
|1016 | Quantity|
|1017 | Audio|
|1018 | Video|
|1019 | VideoDisplay|
|1020 | Gameplay|
|1021 | Controls|
|1022 | Magic|
|1023 | Map|
|1024 | MagicPopup|
|1025 | Negotiate|
|1026 | Book|
|1027 | LevelUp|
|1028 | Training|
|1029 | BirthSign|
|1030 | Class|
|1031 | Attributes|
|1032 | Skills|
|1033 | Specialization|
|1034 | Persuasion|
|1035 | Repair / Ingredient Selection (Alchemy sub-menu)|
|1036 | RaceMenu (Character Generation Screen)|
|1037 | SpellPurchase|
|1038 | Load|
|1039 | Save|
|1040 | Alchemy|
|1041 | SpellMaking|
|1042 | Enchantment|
|1043 | EffectSetting|
|1044 | Main|
|1045 | Breath|
|1046 | QuickKeys|
|1047 | Credits|
|1048 | SigilStone|
|1049 | Recharge|
|1051 | TextEdit|

###### OnAdd
This only behaves as expected with persistent references (see the section on References). An
item added to a container with this block and removed within the same call of this block will
simply do nothing. An additional call is needed.

###### OnDeath
If the scripted actor gets called with `SayTo` while this block activates (i.e. dies while
talking), this block will trigger after `SayTo`. Additionally, this block type does not fire
immediately, do not rely on this for time sensitive functionality.

###### OnDrop
OnDrop only runs when the object is _removed_, not when it no longer exists. It also,
confusingly, doesn't run when the object is dropped (i.e. placed on the ground). Thus this is
not a test for seeing if an object is on the ground.

###### OnEquip
OnEquip does not behave as expected. It'll only run on items that an actor can physically
equip, regardless of status. 
- Broken items and non-equippable items will fire this block
- Potions, poisons, and ingredients do not fire this block
- Books do not fire this block during combat if this feature is disallowed
- Unlike OnActivate, this will not stop the player from reading a book
- Enchanted scrolls will not fire this block
- The game function `EquipItem` **does not** fire this block, use `EquipItem2`/`EquipItem2NS` instead
    - The game function `UnequipItem` **does** fire OnUnequip howeve

###### OnHit
The game function `GetDetected` behaves weirdly inside this block. This block fires _after_
the hit occurs, not as it occurs, thus the actor will be in an aware state no matter what.
Thus `GetDetected` will not provide the true value expected when used in this
manner.

###### OnHitWith
This can work with objectIDs that are 'Activators', but only when the objectID hitting the
scripted object is of the type Ammo. Other weapon types do not work.

###### OnLoad
This block does not work with quest scripts. A 3D object loads whenever you enter the 5x5 cell
grid in an exterior cell, or in any interior cell.

###### OnMagicEffectHit
This works on actors, activators, containers, doors, and furniture. It does not work on lights
or regular inventory items. In addition, the object being hit must have collision meshes.

###### OnMurder
As this is broken, build murder detection with 'OnDeath' instead.

###### OnPackageChange
Interrupt packages, such as combat or conversation packages, do not count towards a package
change. A change only occurs when a new package is chosen by the scripted actor, it must be
different from the specified packageID

###### OnPackageDone
Packages can be completed through a failure state, unless the 'Must Reach Location' or 'Must
Complete' flags of the package are checked. Some packages also have no complete state, and
thus will never trigger this block.

###### OnTriggerMob
Mobile objects are considered: actors (NPCs and creatures), arrows, non-bolt magic
projectiles, and activators with collision.

###### OnUnequip
Broken items do not fire this block, even if they can be equipped/unequipped. To fire this
block, the broken item must be repaired.

###### ScriptEffectFinish
'ScriptEffectUpdate' block with a `return` statement placed before this block will prevent
this block from running. See the section on the [Return Statement](#return-statement) in
[Statements](#statements) for more info.
This block won't fire for scripted apparel enchantments or abilities.

###### ScriptEffectStart
This block won't fire for scripted apparel enchantments or abilities.

###### ScriptEffectUpdate
'ScriptEffectUpdate' block with a `return` statement placed before this block will prevent
this block from running. See the section on the [Return Statement] in [Statements] for more
info.
This block won't fire for scripted apparel enchantments or abilities.

## Variable Declarators
```ebnf
variableDeclaration = varType, variable, eol;
varType = "float"
          |"int"
          |"short"
          |"long"
          |"ref"
          |"array_var"
          |"string_var"
```

```obse
scn VariableDeclarators
float floating
int integer
ref reference
array_var array
string_var string
begin gamemode
end
```

Variable declaration happens outside of "begin blocks". Declaration is different from
definition. A declaration only describes the type that a variable has, it does not initialize a
value. All types will default initialize to 0 for comparative needs.

## Set Statement
```ebnf
setStatement = "set", variable, "to", (expression | literal), eol;
```

```obse
scn SetStatement
int statement
begin gamemode
set statement to 1
end
```

The set statement is the statement found in the original release of `obl`. It it thus the most
simple of the 2 variable statements. The set statement does not work with most OBSE constructs,
however unlike the let statement this statement works with the game's console. This means it can
be used for INI files, see the section on User Interaction for more information on this. It is
also capable of constructing string expressions, unlike the let statement. See the section on
Strings in Expressions for more.

## Let Statement
```ebnf
letStatement = "let", variable, (assignment | compoundAssignment), (expression | literal), eol;
assignment = ":=";
compoundAssignment = "+="
                    |"-="
                    |"*="
                    |"/="
                    |"^=";
```

```obse
scn LetStatement
int statement
begin gamemode
let statement := 1
let statement += 1
end
```

The let statement is the statement introduced with OBSE. It is much more capable, allowing the
full features of OBSE alongside compound assignment. Compound assignment allows you to replace
basic arithmetic on the same variable compared to assigning a variable to the value of the
variable and the basic arithmetic. The example is as shown:

```obse
scn CompoundAssignment
int assignment
begin gamemode
; basic arithmetic without compound assignment
let assignment := assignment + 1
; with compound assignment
let assignment += 1
end
```

## Return Statement
```ebnf
returnStatement = "return", eol;
```

```obse
scn ReturnStatement
int x
begin gamemode
set x to 1
return
; anything below here is not processed
set x to 2
end
```

The return statement is not like other languages. It does not return any values, but instead
stops the script from processing. It can be called at any point in time.

## Conditionals
```ebnf
conditional = if, [{elseIf}], [else], "endif";
if = "if", (expression | literal), eol, [{statement}];
elseIf = "elseif", (expression | literal), eol, [{statement}];
else = "else", [{statement}];
```

```obse
scn Conditional
int x
begin gamemode
set x to y
if 1
  set x to 1
elseif 0
  set x to 0
else
  set x to -1
endif
print
set x to y
end
```

Conditionals in `obl` are standard to most languages for the most part. `obl` accepts the
standard C-style comparator binary operators:

|Symbol | Meaning|
|-|-|
|`==` | Left equal to right|
|`!=` | Left not equal to right|
|`>` | Left greater than right|
|`<` | Left less than right|
|`>=` | Left greater than or equal to right|
|`<=` | Left less than or equal to right|
|`!` | Unary operation, returns opposite truthy/falsy value for an expression|
|`&&` | Left and right are both truthy, AND operation|
|`\|\|` | Left or right is truthy, OR operation|

### Conditions always evaluate
Processing of conditionals is not exactly standard. While most languages will only ever
process a condition until it finds a true value, `obl` will process _every_ condition until it
finds a way to exit the condition, whether this is the end of the condition or a return
statement. This means that scripts will produce runtime errors and even crash the game if you
develop a condition with features that might return null values:

```obse
scn ConditionalProblem
begin gamemode
if RefVar != 0 && RefVar.GetAV Health < 30
  ; game will crash processing right hand condition when RefVar is empty
endif
end
```

Thus the best way to manage this behavior is to nest a condition, where the possible crash is
contained in its own condition. The first condition uses a return statement to end the script
processing:

```obse
scn FixedConditonalProblem
begin gamemode
if RefVar == 0
  return
elseif RefVar.GetAV Health < 30
  ; do something
endif
end
```

### Conditions are slow to process
As conditions always process, large conditions are very slow overall. Nesting large conditions
is always suggested:

```obse
scn LargeCondition
int x
begin gamemode
set x to GetFPS
; first condition is the negation of what we want for our first large condition
if x != 60
  return
elseif
  ; large condition
endif
end
```

Remember that return statements stops all script processing. Physical structuring of the
conditional within the script should be kept in mind when constructing large conditions. For
most ideal use, it is best to use other constructs like while statements or User-Defined
Functions.

### Truthy/Falsy Values
Values that return true are any non-zero values. Values that return false are any 0 values.
Any empty variable is defaulted to 0 regardless of type, any filled variable is a truthy
value. Thus you can simply use a variable as a condition without comparing it to any
truthy/falsy value depending on what you want.

## While Statement
```ebnf
whileStatement = while, [{loopBody}], loop;
while = "while", (expression | literal), eol, [{statement}];
loopBody = statement | "break" | "continue", eol;
loop = "loop", eol;
```

```obse
scn WhileLoop
int i
begin gamemode
while i < 10
  printc "%g", i
  let i += 1
loop
end
```

The while statement loops over the body of the statement as long as the condition is true. The
conditions are standard conditions, however they do not always evaluate like conditionals do. As
well, while statements will process within a script execution time. They will not process per
line.

Remember to have a condition that actually will return [falsy](#truthy/falsy-values)
eventually. The game will lock up otherwise.

### Break Statement
The break statement is a substatement. It behaves like a return statement, but within a loop.
It cancels the execution of the loop.

### Continue Statement
The continue statement is a substatement. It behaves like a return statement, but within a
loop. It stops the current execution of the loop for the next iteration.

## ForEach Statement
```ebnf
forEachStatement = forEach, [{loopBody}], loop;
forEach = destinationVariable, "<-", sourceContainer;
loopBody = statement | "break" | "continue", eol;
loop = "loop", eol;
```

```obse
scn ForEachLoop
array_var iter
string_var string
begin gamemode
let string := "string"
foreach iter <- string
print
loop
end
```

The ForEach statement iterates over each value of a container type. It can iterate over:
strings, arrays, and references that can be physical containers. The destination variable
depends on the type of the source container.

### Array Source
For array source containers, the destination variable is a string map of 2 keys: "key" and
"value". "key" is the current key of the source container. "value" is the current value of the
source container.

### String Source
For string source containers, the destination variable is a string variable of the current
character of the string.

#### Reference Source
For reference source containers (which contain a physical container), the destination
variable is a reference variable of the current item being processed. See the section on
Inventory References for more.

ForEach statements can take the [Break](#break-statement) and [Continue](#continue-statement).

## User-Defined Function Return Statement
```ebnf
functionValue = "SetFunctionValue", {expression}
```

```obse
scn FunctionReturn
begin funciton {}
SetFunctionValue 1 + 1
end
```

User-defined functions (UDF) can return a single value of any type. Multi-value return values
are packed as single arrays for return. This does not end execution of the user-defined function
however. The last call of `SetFunctionValue` will determine the return value of the UDF

See: User-Defined Functions in Expressions for more.

## Label Statement
```ebnf
label = ("label" | "SaveIP"), [labelName];
labelName = identifier;
```

```obse
scn LabelGoTo
int i
int j
begin gamemode
  ; nested for loop using label/goto
  Label 0
  set j to 0
  Label 1
  set j to ( j + 1 )
  if ( j < 3 )
    GoTo 1
  endif
  set i to ( i + 1 )
  if ( i < 5 ) 
    GoTo 0
  endif
end
```

Label statements create points in a block of a script that can be jumped back to arbitrarily.
The 2 keywords used are "Label" and "SaveIP", they have identical functionality. The argument
for a name is optional. If its not used, then using a goto statement without an argument will
goto the unnamed label statement. Additionally the label name is under the same namespace as
regular variable identifiers. Most of the same limitations apply. 

The biggest difference is when using the same label name across different scripts. When a script
indirectly calls scripts via result scripts using `SetStage` or by calling a 'OnActivate' block
on a scripted object, these scripts will run immediately without the current script completing
first. It is best to not use this feature, it is unintentional.

Label statements must be loaded into memory first, a goto statement will not find the label
otherwise.

## GoTo Statement
```ebnf
label = ("goto" | "RestoreIP"), [labelName];
labelName = identifier;
```

```obse
scn LabelGoTo
int i
int j
begin gamemode
  ; nested for loop using label/goto
  Label 0
  set j to 0
  Label 1
  set j to ( j + 1 )
  if ( j < 3 )
    GoTo 1
  endif
  set i to ( i + 1 )
  if ( i < 5 ) 
    GoTo 0
  endif
end
```

GoTo statements return the execution of the script back to the point of the label statement of
label name. If no label name is provided, it goes to the unnamed label statement.

## Game Statements
Being a video game oriented language, `obl` has many statements that update and mutate many game
features which only ever return null. As these return null, the compiler will not compile the
script unless you use OE to ignore this. This will lead to runtime errors instead.

These operate like any regular function, and are typically prefixed with "Set", or are otherwise
self explanatory. A full list will can be found elsewhere. Generally expect to use these to
create side-effects.

