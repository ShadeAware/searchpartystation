/mob/living/carbon/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if (!isnull(held_item) && !(held_item.item_flags & (ABSTRACT|HAND_ITEM)))
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Offer item"
		return CONTEXTUAL_SCREENTIP_SET

	if (!ishuman(user))
		return .

	var/mob/living/carbon/human/human_user = user

	if (human_user.a_intent == INTENT_HARM)
		context[SCREENTIP_CONTEXT_LMB] = "Attack"

	if (human_user.a_intent == INTENT_GRAB)
		context[SCREENTIP_CONTEXT_LMB] = "Grab"

	if (human_user.a_intent == INTENT_DISARM)
		context[SCREENTIP_CONTEXT_RMB] = "Disarm"

	if (human_user.a_intent == INTENT_HELP)
		if (body_position == STANDING_UP)
			if(deprecise_zone(user.zone_selected) == BODY_ZONE_HEAD && get_bodypart(BODY_ZONE_HEAD))
				context[SCREENTIP_CONTEXT_LMB] = "Headpat"
			else if(user.zone_selected == BODY_ZONE_PRECISE_GROIN && !isnull(getorgan(/obj/item/organ/tail)))
				context[SCREENTIP_CONTEXT_LMB] = "Pull tail"
			else
				context[SCREENTIP_CONTEXT_LMB] = "Hug"
		else if (health >= 0 && !HAS_TRAIT(src, TRAIT_FAKEDEATH))
			context[SCREENTIP_CONTEXT_LMB] = "Shake"
		else
			context[SCREENTIP_CONTEXT_LMB] = "CPR"

	return CONTEXTUAL_SCREENTIP_SET
