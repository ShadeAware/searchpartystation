
//full of weird and wacky mob spawns. this is probably the darkest corner of mob spawns even after cleanup so be ready for shitcode

///dead ai, blue screen and everything.
/obj/effect/mob_spawn/corpse/ai
	mob_type = /mob/living/silicon/ai/spawned

/obj/effect/mob_spawn/corpse/ai/create(mob/user, newname)
	var/ai_already_present = locate(/mob/living/silicon/ai) in loc
	if(ai_already_present)
		return
	. = ..()

/obj/effect/mob_spawn/corpse/ai/special(mob/living/silicon/ai/spawned/dead_ai)
	. = ..()
	dead_ai.set_real_name(src.name)

///dead slimes, with a var for whatever color you want.
/obj/effect/mob_spawn/corpse/slime
	mob_type = /mob/living/simple_animal/slime
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey baby slime" //sets the icon in the map editor
	///the color of the slime you're spawning.
	var/slime_species = "grey"

/obj/effect/mob_spawn/corpse/slime/special(mob/living/simple_animal/slime/spawned_slime)
	. = ..()
	spawned_slime.set_colour(slime_species)
