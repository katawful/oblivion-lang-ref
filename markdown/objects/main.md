
# Objects
Most interactions within Oblivion is with constructs known as "objects". These objects should not
be thought of in the same thought as typical programming objects, they are bits of data that are
stored by the game itself. One can't create new objects at will, and for the most part cannot
create new objects of a specified type at will via `obl`. However, that is not to say that you
cannot take similar ideas from traditional programming objects.

# Object Features
Features of an object vary from object type to type. 

# Base Objects
Base objects are the actual, 6+2 hexadecimal notated, data that store the information about the
base attributes of the object specified. For instance, for armor this will store it's base armor
rating and weight among other attributes. These generally must be created in the plugin you are
designing, rather than through `obl`.

Two main groups of attributes are defined by the type of base object created:

## Quality
In `obl`, a quality is generalized feature that an object can have. Qualities are generally
shared by by multiple object types. For instance, a container and a door both have the "Audible"
quality. They will make sounds when activated with this quality.

## Type
In `obl`, a type is what features the object provides to the game. Generally, these are headered
by a 4 letter character string within the tree of the plugin ('ACTI' for activators). Features of
these types are predetermined by the engine, and unless expanded upon by an OBSE plugin, cannot
be added to.

# References
References are references to base objects. They contain all of the features from said base
objects, as well as some additional features. All objects physically placed within the game world
are references, even if they go unnamed.

References that need to be referred to must be given a unique name. Since all names share the same
scope, reference names must be the same themselves. A recommended method is to simply append 'REF'
to the end of the base object's name. If multiple references are needed from said base object, add
a double digit number to the end. For example, if you need 3 references to the base object
"Apple", make your 3 references: "AppleREF01", "AppleREF02", and "AppleREF03". This simply a
recommended standard, one found in the base game and in many other plugins found online.

### Persistence
As Oblivion is a video game, there must be a way to handle how objects are accessed and stored
in memory.

Objects that are referenced at all, even if the object referring to it is in the same loaded
area (and thus share the same pool of memory), must always be loaded into memory. Scripts
included. This is known as a "persistent reference". Persistent references don't load the full
3D model, but all other object data that can be regularly addressed is loaded into memory. Care
should be taken to not make a reference persistent when unneeded.

Objects that are not referenced by others are simply "non-persistent references".
This value can be set within the data tab of the object in question.
