# Script Types
Any script can be 1 of 3 types: Quest, Object, and Magic Effect alongside user-defined functions.

## Quest Scripts
Quest scripts can run at any point in time, as long as the quest the script is attached to is
running. Quest scripts should be considered global functions. They are defined in the same
manner but have some unique constructs.

### fQuestDelayTime
Quest scripts run on an interval in order to improve performance. This is handled by the float
variable `fQuestDelayTime`. It can be set to any floating point value, but scripts cannot be
processed faster than the game updates. This means a value of 0.01 is updating at around 60
frames per second (16ms frametime). As well, this value **does not** mean that each line updates
at the value of `fQuestDelayTime`. It means the script **starts** processing at this value. One
should be aware as they make larger scripts, and use profiling tools to make sure script
processing time isn't more than 16ms, the 60fps frametime.

This value defaults to 5 seconds.

### Quest Namespace
All variables declared in a quest script are added to a namespace identified with the name of
the quest the quest is attached to. These variables are thus accessible anywhere, and unlike
the script itself, can be updated anywhere at anytime regardless of if the quest itself is
running. The format is as so:

```ebnf
questVariable = namespace, '.', variable;
namespace = questName;
questName = identifier;
variable = identifier;
```

```obse
scn QuestScript
int questVar
; quest name is "QuestName"
scn OtherScript
begin GameMode
let QuestName.questVar := 1
end
```

All variable limitations apply.

Since quest scripts aren't attached to objects, most block types have no use. Thus the
majority of the use is via `MenuMode` and `GameMode` block types alongside user-defined
functions.

## Object Scripts
Object scripts attach to objects. They use the majority of begin block types. They also serve as
the source type for user-defined functions. See the section on User-Defined Functions for more
details.

## Magic Effect Scripts
Magic effect scripts are used to create magic effects. They are unique in that they only fire
during when 'GameMode' blocks are active but only use the 3 unique 
[Magic Effect Block Types](statements.md#magic-effect-block-types). Some other block types work,
but this behavior is unpredictable. 'MenuMode' is the only one that behaves exactly. These
scripts are mostly designed to run on actors (NPCs and creatures), but will run on actor corpses,
doors, and furniture. When run on these objects, the script will run once.

