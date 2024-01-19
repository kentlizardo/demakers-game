# Day 1 2024-01-17

Decided to scaffold a completely new project for Demaker's. I've already tried to make this game multiple times before. Once with GDScript. Then switched to C#, waited a couple months, recreated that project in C#. What a mess. I've finally decided to use GDscript and going to try to stubbornly stick with that. My reasons for doing so is because I've found that all of my game jams in C# and projects so far have had a _lot_ slower development time than the GDScript projects. Mostly having headaches trying to understand OOP + dependence and inheritance trees while trying to mix that into a Godot Node-based workflow. Going to paste a pros/cons list from the trello into here.

## C#

**Pros**

-   Static typing
    -   Verbose type hints are good enough until Typed Arrays and Dictionaries.
-   Value types, tuples/structs
-   OOP (Interfaces and Abstract classes)
-   Tasks/Async
-   Private/hidden variables and properties
    -   Imitatable with properties
-   Namespaces/packages
-   High performance when used correctly with Engine Interops
    -   I don't think I need _that_ much performance. And if I do, I can always use C# interfacing with GDScript.And it's also unlikely for performance to be from the scripting end since this (from this point), project doesn't seem to have any usecases requiring massive processing efficiency.
-   Compilation is separate from editor build. Although this is still undetermined to be a pro or a con. This helps to separate destructive @tool development concerns.

**Cons**

-   Not really meant for node and scenetree composition workflow
-   Script binding system workflow is difficult
-   Slower iteration speed than GDScript
-   More difficult to mod/patch/additional content (Need libraries like Harmony or dll creation)
-   Slightly difficult to implement GodotSteam (Not an issue during development as you could just make glue code)
-   Difficult to trace debug output. (however this is being improved still)

## GDScript

**Pros**

-   Much faster iteration/development speed
-   Out of the box incremental .pcks make dynamic content easy to implement
-   Tied into the engine, first-class support gets more updates frequently
-   Verbose error debugging
-   Higher performance with static typing

**Cons**

-   No structs/value types
-   No OOP (abstraction)
-   Cluttered namespaces

I would switch to a C# project/binary if the following was implemented however.
https://github.com/godotengine/godot-proposals/issues/7895

For now, I'm going to try to recreate functionality up to the 3rd version, which is the basic App structure with game loading and an _very basic_ environment/location system(just print statements.)

# Day 2 2024-01-18

I wasn't able to get much done besides adding editor icons and configuring Git LFS to handle svgs due to classwork.
