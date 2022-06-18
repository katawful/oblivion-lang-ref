
# Event Handlers

```ebnf
registerEvent = 'SetEventHandler', event, script, [{filterPair}];
event = string;
script = identifier;
filterPair = variable, '::', literal;
```

```obse
scn EventHandler
ref functionScript
ref first
ref second
begin gamemode
let functionScript := someFunction
SetEventHandler "OnActivate" first::Player second::Anusai
end
```

Event handlers allow functions to be called upon the iteration and/or update of an event in the
game, such as loading a save game or inputting a key. The old way to do this was to have a
conditional block always iterating during the game mode desired. Handlers are registered to a
single source, and are thus much faster and less script heavy.

## Events

| Name | Parameters | Note Link |
| - | - | - |
| 'OnHit' | target:ref attacker:ref | - |
| 'OnHitWith' | target:ref weapon:form | - |
| 'OnMagicEffectHit' | target:ref effectCode:int | - |
| 'OnMagicEffectHit2' | target:ref effect:ref | [Note](#OnMagicEffectHit2) |
| 'OnActorEquip' | target:ref item:form | - |
| 'OnDeath' | target:ref killer:form | - |
| 'OnMurder' | target:ref killer:form | - |
| 'OnKnockout' | target:ref | - |
| 'OnActorUnequip' | target:ref item:form | - |
| 'OnAlarm Trespass' | alarmedActor:ref criminal:ref | - |
| 'OnAlarm Steal' | alarmedActor:ref criminal:ref | - |
| 'OnAlarm Attack' | alarmedActor:ref criminal:ref | - |
| 'OnAlarm Pickpocket' | alarmedActor:ref criminal:ref | - |
| 'OnAlarm Murder' | alarmedActor:ref criminal:ref | - |
| 'OnPackageChange' | target:ref package:form | - |
| 'OnPackageStart' | target:ref package:form | - |
| 'OnPackageDone' | target:ref package:form | - |
| 'OnStartCombat' | target:ref opponent:ref | - |
| 'OnActivate' | activated:ref activating:ref | - |
| 'OnVampireFeed' | n/a | [Note](#OnVampireFeed) |
| 'OnSkillUp' | skillAVCode:int | [Note](#OnSkillUp) |
| 'OnScriptedSkillUp' | skillAVCode:int amount:int | [Note](#OnScriptedSkillUp) |
| 'OnDrinkPotion' | drinker:ref potion:form | - |
| 'OnEatIngredient' | eater:ref ingredient:form | [Note](#OnEatIngredient) |
| 'OnActorDrop' | dropper:ref droppedItem:ref | [Note](#OnActorDrop) |
| 'OnSpellCast' | caster:ref spell:form | [Note](#OnSpellCast) |

### OnMagicEffectHit2
Only useful for effects which have valid formIDs at compile-time, such as with effects from
Oblivion Magic Extender plugin.

### OnVampireFeed
Invokes after the player finishes feeding as a vampire.

### OnSkillUp
Invoked after skill increases through use.

### OnScriptedSkillUp
When `ModPCSkill`/`AdvanceSkill` are used to increase skill before the skill is modified.

### OnEatIngredient
Also triggers OnActorEquip event.

### OnActorDrop
The dropped item is the new reference in the game world to this dropped item.

### OnSpellCast
Only invoked when the caster is an actor.

## User-Defined Events
User-defined events can be created that be used like the builtin events.
The function used for the event handler always takes one argument, a StringMap that has the
following two keys:

1. 'eventName': A string indicating the event that occurred
2. 'eventSender': A string indicating the origin of the event. By default it is the filename of
   the mod that dispatched it, unless an alternate name was supplied.

This StringMap can contain additional data sent by the user-defined event.

```obse
scn EventSetup
begin gamemode
end

scn EventHandler
array_var args
begin Function {args}
  print "Event " + args->eventName + " received from " + args->eventSender
  print $arg->activator + " was activated by " + $arg->activatedBy
end

scn EventSender
begin onActivate
  DispatchEvent "Activated" (ar_Map "activator"::GetSelf "activatedBy"::GetActionRef)
end
```
