
# Object Oriented Programming for Oblivion
As Oblivion is a game, most of your interaction will be with objects. `obl` doesn't offer specific
object-oriented programming, however much of the interfacing you will be doing with the language
will be with objects themselves. It can thus be useful to enter the OOP mindset when working in
this language.

## Objects
You cannot, readily, create or destroy new objects from `obl`. Some object types have functions
to achieve that, but it's not something that is the norm. Thus objects in `obl` are immutable and
purely provided for you. However, despite this you are able to access any feature available from
the object within `obl`.

## Getters
Many game functions are designed to return some value of an object. Functions that return a
non-boolean value, such as the numerical monetary value of the item, are usually prefixed with
"Get".

```obse
scn Getter
int intVar
begin gamemode
let intVar := PlayerREF.GetActorValue Strength
; "get" the actor value 'strength' from the reference object
let intVar := GetGoldValue Apple
; "get" the gold value from the base object
end
```

## Setters
Like getters, setters set a value of an object. These functions don't return any value, and are
usually statements. They are prefixed with "Set". You can think of these functions as setting
attributes of a class, only we cannot define classes.

```obse
scn Setter
begin gamemode
PlayerREF.SetActorValue Strength 100
; "set" the actor value 'strength' of the reference object
SetGoldValue Apple 100
; "set" the gold value of the base object
```

## Predicates
These functions ask a question of the object, all prefixing the function name. The list includes:
"Is", "Has", and "Can". These functions all return a boolean as they are all effectively asking a
yes/no question about the object.

- "Is" functions in particular ask about a quality or type of an object.
- "Has" functions usually ask about a mutable state of the object, like their name or if they
  have a specific spell.
- "Can" functions usually return whether or not an actor can do some feature, usually implicitly
  the player object

```obse
scn Predicate
begin gamemode
if IsIngredient Apple
  Print "yes an apple is an ingredient"
endif
if PlayerREF.HasTail
  Print "only if you're an argonian or khajit"
endif
if CanFastTravelFromWorld Tamriel
  Print "of course you can travel in tamriel"
endif
end
```

## Ownership
In Oblivion, there are base objects, which are the source object defined, and references, which
refer to these base objects. You can think of a base object as the parent of the child reference
object. The reference inherits all attributes and features of the base object automatically. If
you create 3 references to the object "Apple" and then change the monetary value of the base
object "Apple", then all 3 references will get that new value. However, children are distinct
from each other. If you only change the monetary value of 1 reference, no other object will
receive this change. It can be very important to remember to work on references when you need to
as to not affect references undesired.

Do note that this is purely language to get one more comfortable with `obl`. The words "parent"
and "child" have a very different meaning in Oblivion, and instead refer to how references can be
grouped together for group management.
