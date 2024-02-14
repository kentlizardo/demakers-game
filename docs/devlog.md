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
# Day 11 2024-02-13
Have been incredibly busy, due to working on actual job/career stuff.
I finally figured out the right way to do the Cabinet system. I decided to just use RefCounteds as components for MainPlayerBind!

Other sad news, I looked at a bunch of games my friends reviewed cause I asked for retro shooters!
I feel like my game is a total ripoff of ULTRAKILL now... I've been writing notes and design drafts for how this game for more than a year now and I never really looked at it? I mostly took inspiration from games like Hades and Evoland, so I'm incredibly surprised and disappointed at how my ideas came to be so similar.  The idea of robot angels and ascending hell as a story made so much sense with ascending to fight the Demaker as a fallen archangel. Honestly I don't know what to do anymore. Hopefully I can find some way to make my game different?

Also looked into managing my design notes in a different way, I drafted a weird little note-taking app design combining my haphazard note-taking methods of Discord messages + text channels and random Google docs. I really like markdown and plaintext notes so much more. Wondering if I can make a suite of apps that focus on portability with plaintext and VCS support, maybe one for Kanban workflows?

TODO: Create 3 enemy types.
## Faction System (Draft)
I think to draft most enemy behaviours, one thing needs to be defined. How exactly should an Enemy react to other entities(Players, and Entities)?

Since enemies all interact within the 3D space (not 2D yet until we implement the Warden enemy; although, this would probably be transforming 3D rendering to 2D instead.), I'm going to make the behavior system tightly coupled into the 3D engine with **PhysicsBody3D**s in groups.

For factions, the node group name is going to be peppered with "fac_", incase we need to use groups for other things. I wish we could extend methods in GDScript so I can just do `enemy.get_faction_groups()` but we'll probably have to use a service/singleton.

We're probably going to have to manually add "fac_" to every group name in a PhysicsBody3D. Maybe if something like group groups were implemented, or group categories. I really don't want to use Resources for this kind of thing.

Actually, if we use Resources, we can establish Faction relation table resources. And instead have Resource store an underlying group_name. The issue with this is, we cannot extend the functionality of Node3D to have a Faction (Resource), unless we edit the engine code. Ugh, this would be one good use case for C# as GDExtension bindings.

There's also metadata, but I really dislike using it in Godot because it introduces unneeded complexity/handling.

I think the approach right now will be to use magic strings for group_names. I doubt this needs any more complexity than that. One issue that could come up is dynamically changing the relations between factions, but I think that can just be worked around with just switching the entities to a specialized faction. It's also doesn't seem like it's going to be a very common occurrence.

I wonder how we're going to handle multiple factions.
## Multiple Factions,
Most likely can just +1/-1 to a discrete likeability score, with the likeability score being the main determining factor for behavior.
## Upgrading
I'd like to see this improved, with specific behaviors and trees of factions. Like, enemies from a certain act/setting, like for example, enemies from `underworld` would probably attack `benthic gravesite (sealife)` on sight, since the Leviathan destroyed their city. Also would probably attack `benthic gravesite (sealife) (deep sea)`
Maybe have an individuality factor that determines whether a faction acts with herd mentality vs individual entity.
Look into hierarchical FSMs?
TODO: Look into upgrading faction system.
TODO: Look into visualizing this with a generated 2 way table
Wait. Why don't we just have a manually inputted 2 way table?
	Probably multiplies into a lot of work, especially if we have derived faction groups.

## Alternative Idea to Blending Animations
The art style is supposed to be super retro, or at least reminiscent of it. I have an idea to implement simple stagger/interrupt animations an enemy without blendtrees. Most likely, for an X stagger amount, depending on the enemy's staggerability (or a fixed one), the animation speed is slowed by X \* k. This would look linear, and not very good. The next step is to make it additive, as well as having a curve. As long as we follow the added curve having an area similar to that of X \* k, it should be fine.
## Stagger System?
What if the stagger system was progressive?
Stagger (only slows down animation speed, maybe accuracy) -> Interrupt (can reverse animation speed) -> Canceled (animation has been cancelled? maybe stun? maybe switch to a different one while locking this one out.) -> Stunned (can't do anything)