/datum/status_effect/noir
	id = "noirmode"
	tick_interval = -1

	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

	var/list/sensed_blood = list()

/datum/status_effect/noir/on_apply()
	. = ..()
	owner.add_client_colour(/datum/client_colour/monochrome/noir)
	owner.mob_mood.add_mood_event("noir", /datum/mood_event/detective_noir)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(update_bloodsense))
	update_bloodsense()

/datum/status_effect/noir/on_remove()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/monochrome/noir)
	owner.mob_mood.clear_mood_event("noir")
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	if(owner.client)
		for(var/obj/effect/decal/cleanable/blood/blood_decal as anything in sensed_blood)
			owner.client.images -= sensed_blood[blood_decal]
	sensed_blood.Cut()

/datum/status_effect/noir/proc/update_bloodsense()
	if(!owner.client)
		sensed_blood.Cut()
		return

	for(var/obj/effect/decal/cleanable/blood/blood_decal as anything in sensed_blood)
		owner.client.images -= sensed_blood[blood_decal]

	sensed_blood.Cut()

	FOR_DVIEW(var/obj/effect/decal/cleanable/blood/blood_decal, 7, get_turf(owner), INVISIBILITY_MAXIMUM) // grrr this is expensive but its the det so he can have it.
		if(!HAS_TRAIT(blood_decal, TRAIT_MOVABLE_FLUORESCENT))
			continue

		if(sensed_blood[blood_decal])
			continue

		var/image/I = image(blood_decal)
		I.appearance = blood_decal.appearance
		I.invisibility = INVISIBILITY_VISIBLE
		I.alpha = 255
		I.color = COLOR_LUMINOL
		I.loc = blood_decal.loc
		sensed_blood[blood_decal] = I
		owner.client.images += I
	FOR_DVIEW_END

/// Noir-in-area, removed if the user leaves the given area.
/datum/status_effect/noir_in_area
	id = "noirinarea"
	tick_interval = -1

	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

	var/area/noir_area
	var/pinned_to_chair = FALSE
	var/getup_check_modifier = 0// Starts out impossible

/datum/status_effect/noir_in_area/on_creation(mob/living/new_owner, area/tracked_area)
	. = ..()
	if(!.)
		return

	noir_area = tracked_area

/datum/status_effect/noir_in_area/on_apply()
	. = ..()
	owner.add_client_colour(/datum/client_colour/monochrome/noir)
	owner.mob_mood.add_mood_event("forcednoir", /datum/mood_event/noir_victim)
	RegisterSignal(owner, COMSIG_ENTER_AREA, PROC_REF(owner_entered_area))

/datum/status_effect/noir_in_area/on_remove()
	. = ..()
	owner.mob_mood.clear_mood_event("forcednoir")
	if(pinned_to_chair)
		clear_intimidation_signals(owner.buckled)

/datum/status_effect/noir_in_area/proc/clear_intimidation_signals(atom/movable/buckled_to)
	if(buckled_to)
		UnregisterSignal(buckled_to, list(COMSIG_MOVABLE_PRE_UNBUCKLE_MOB, COMSIG_MOVABLE_UNBUCKLE))
	UnregisterSignal(owner, list(COMSIG_ENTER_AREA, COMSIG_PARENT_ATTACKBY, COMSIG_ATOM_GET_GRABBED, COMSIG_HUMAN_DISARM_HIT, COMSIG_ATOM_ATTACK_HAND))

/datum/status_effect/noir_in_area/proc/owner_entered_area(datum/source, area/entered)
	SIGNAL_HANDLER

	if(entered != noir_area)
		qdel(src)

/datum/status_effect/noir_in_area/proc/on_unbuckle_attempt(datum/source, mob/buckled)
	SIGNAL_HANDLER
	if(buckled != owner)
		return

/datum/status_effect/noir_in_area/proc/on_unbuckle(datum/source, mob/buckled, force)
	SIGNAL_HANDLER
	clear_intimidation_signals(source)

/// If the owner is possibly attacked in anyway, free them from the chair.
/datum/status_effect/noir_in_area/proc/on_owner_attack(datum/source)
	SIGNAL_HANDLER

	clear_intimidation_signals(owner.buckled)
