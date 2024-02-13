# Day 1 2024-01-17
Decided to scaffold a completely new project for Demaker's. I've already tried to make this game multiple times before. Once with GDScript. Then switched to C#, and then a couple months after,I recreated that project in C# but with "cleaner code". What a mess. I've finally decided to use GDscript and going to try to stubbornly stick with that. My reasons for doing so is because I've found that all of my game jams in C# and projects so far have had a _lot_ slower development time than the GDScript projects. Mostly having headaches trying to understand OOP + dependence and inheritance trees while trying to mix that into a Godot Node-based workflow. Going to paste a pros/cons list from the trello into here.
## C\#
**Pros**
- Static typing
- Verbose type hints are good enough until Typed Arrays and Dictionaries.
- Value types, tuples/structs
- OOP (Interfaces and Abstract classes)
- Tasks/Async
- Private/hidden variables and properties
- Imitatable with properties
- Namespaces/packages
- High performance when used correctly with Engine Interops
- I don't think I need _that_ much performance. And if I do, I can always use C# interfacing with GDScript.And it's also unlikely for performance to be from the scripting end since this (from this point), project doesn't seem to have any usecases requiring massive processing efficiency.
- Compilation is separate from editor build. Although this is still undetermined to be a pro or a con. This helps to separate destructive @tool development concerns.
**Cons**
- Not really meant for node and scenetree composition workflow
- Script binding system workflow is difficult
- Slower iteration speed than GDScript
- More difficult to mod/patch/additional content (Need libraries like Harmony or dll creation)
- Slightly difficult to implement GodotSteam (Not an issue during development as you could just make glue code)
- Difficult to trace debug output. (however this is being improved still)
## GDScript
**Pros**
- Much faster iteration/development speed
- Out of the box incremental .pcks make dynamic content easy to implement
- Tied into the engine, first-class support gets more updates frequently
- Verbose error debugging
- Higher performance with static typing
**Cons**
- No structs/value types
- No OOP (abstraction)
- Cluttered namespaces

I would switch to a C# project/binary if the following was implemented however.
https://github.com/godotengine/godot-proposals/issues/7895

For now, I'm going to try to recreate functionality up to the 3rd version, which is the basic App structure with game loading and an _very basic_ environment/location system(just print statements.)
# Day 2 2024-01-18
I wasn't able to get much done besides adding editor icons and configuring Git LFS to handle svgs due to classwork.
# Day 3 2024-01-23
Spent a couple days doing a game jam. Going to return back to work on the locations system.

Had some interesting drafts that I'm going to base the current impl. of the Run and Story system.

Sublocations - Locations can be entered. More locations can be entered on top of that.
This feature is "safe". As long as the Location invariant is true.

1. When a Location is entered, there is a way to exit(succeed/leave by entering the outer level) the current level. It may not be satisfied immediately, but there must be an achievable way to exit.
2. The previous location before an "enter" is stored.

Assertion: A Sandbox can be failed. If so, the current run will "fail" and the (Save)Game can generate a new run. This means that the Run singleton has to be responsible for creating/deleting/handling Sandboxes and Stories.

This then means that creating the Sandbox shouldn't be a singleton/service, but a result of what happens due to Story location changes.

TODO: I think I'll separate the Github Repos for this game for the Open-Source version which will have the bulk of the systems for easy updating of public demo content.
And one private repo for game content.

IDEA: What if consoles created their own player model?
# Day 4 2024-01-24
Made basic location system with virtualizing frontier nodes.
Issue with this is it's difficult to store progression of a Location. Especially with tying win conditions to signals.
## Sublocations?
Another idea: Another way to make locations?
The structure for something like this.
-> points to frontier location
The frontier location being entered in no matter what makes it very easy to save games.

0. Start with basic story.

-   Story (new)

1. Story is entered, calls build since it is not built

-   ->Story (built) with current_act = Act 1
    -   Act 1 (new)
    -   Act 2
    -   Act 3

2. Story is entered. The current_act is set to Act 1. It starts an animation transitioning and loading into Act 1.

-   Story (built) with current_act = Act 1
    -   ->Act 1 (new)
    -   Act 2
    -   Act 3

3. Act 1 is now entered. Calls build since it is not built.

-   Story (built) with current_act = Act 1
    -   ->Act 1 (new)
        -   Levels
    -   Act 2
    -   Act 3

4. (simplified) All levels are completed in Act. (Derived Acts will handle this "completion" themselves). Story will now be entered.

Since "entering" a Location is actually the equivalent of "proceeding", the following holds.
Entering an already entered Location from it's sublocation means that you've "completed" it's current sublocation.
Entering a newly built Location starts you off in an initial location

-   ->Story (built) with next_act = Act 2
    -   Act 1 (new)
        -   Levels
    -   Act 2
    -   Act 3
5. Story is entered, starting an animation and transitioning into Act 2. Calls build.
-   Story (built)
    -   ->Act 2
        -   Levels
6. etc.
Oh wow these lists are really painful to write in markdown using prettier.
TODO: Reformat once https://github.com/prettier/prettier/pull/15526 gets formatted.
## Other notes

Items should just have a single effect when you pick them up. This simplifies their implementation (no need for ordering of instancing)
# Day 5 2024-01-25
Okay I implemented the above system!
(res://dev/test_location_autostep_menu.gd)
The autoclosures work.

I think I need to start making a real example of this to truly connect it since the logic is conventions based,
and really depends on a "correct" impl. in the concrete classes.

Wow! The game I did for the jam I just did is getting a lot of attention... I really don't wanna switch tracks to that game for full production at the moment though. I'm pretty conflicted, so we'll see how that game goes with audiences.
# Day 6 2024-01-26
Made ConsoleView using the previous way it was done. Still not quite perfect, but it will do for now.
Going to try to make a basic EntityBind system for game entities.

TODO: Make a draft of how Player Inventory -> PlayerBind

Renaming "Entity" to CombatEntity since Entity is a very general name. Combat Entity makes sense, it's only used during combat.
Entity is a very light term, maybe Entity <-> Node.

Modules are really, ModuleItem (Representation as it sits in the player's inventory) -> StateNode

Instead of Consoles, call them Loadouts.
# Day 7-8 2024-01-27,28
Created a basic loadout system. And modules system.

IDEA: Instead of having a 3d model for each weapon, a subviewport is created?
Pro: Auto visualizing of weapons only to their own consoles. Also can do things like 2d weapons and 3d weapons easily.
Con: 3d weapons aren't affected by the world. Maybe this is actually good/stylistic thing?
Experiment maybe with copying worldenvironment.

TODO: Make Sandbox instead an Autoload.

How about PlayerLoadouts are constructed from a template? A Console resource.

UH OH: Due to the way ConsoleView resizes the Screen so that a MinViewRegion matches the screen, but with the
target region only being a small part of it. Having an excess horizontal ratio causes there to be distortion
between the "naked viewport" and the console viewport.
Proposed Solution: Making Screen always match aspect ratio of the "naked viewport" but cropping so that it only fits the MinViewRegion.
# Day 9-10 2024-01-30,31
Was pretty busy due to some classwork this week.

Created a basic "imposter" shader. It just stretches the vertex along an axis.
Going to try to find out how to get this to do the 4/8 direction billboard later.

Also wrote down a bunch of ideas for how the acts are going to work, plus more.
I think I definitely overscoped but we'll see.
