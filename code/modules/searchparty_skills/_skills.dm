/datum/skill
	var/name = ""
	var/description = ""
	var/category = "Unknown"
	var/subcategory = "Unknown"
	VAR_PROTECTED/score = 0
	var/min_score = 0
	var/max_score = 10
	var/bonus_score = 0
	var/cost = 0
	/// A dictionary of modifiers to this attribute.
	var/list/modifiers = list()

	var/base_type = /datum/skill

/datum/skill/proc/get_score(include_bonus = TRUE)
	if(include_bonus)
		return score + bonus_score
	else
		return score

/datum/skill/proc/can_set_score(amount)
	var/new_score = score + amount
	if((new_score < min_score) || (new_score > max_score))
		return FALSE
	return TRUE

/datum/skill/proc/set_score(amount)
	if(!can_set_score(amount))
		return FALSE
	score = clamp(amount, min_score, max_score)
	return TRUE

/datum/skill/proc/can_increase_score(amount)
	var/new_score = score + amount
	if(new_score > max_score)
		return FALSE
	return TRUE

/datum/skill/proc/increase_score(amount)
	if(!can_increase_score(amount))
		return FALSE
	score = clamp(score + amount, min_score, max_score)
	return TRUE

/datum/skill/proc/can_decrease_score(amount)
	var/new_score = score - amount
	if(new_score < min_score)
		return FALSE
	return TRUE

/datum/skill/proc/decrease_score(amount)
	if(!can_decrease_score(amount))
		return FALSE
	score = clamp(score - amount, min_score, max_score)
	return TRUE

/datum/skill/proc/update_modifiers()
	SHOULD_NOT_OVERRIDE(TRUE)
	bonus_score = initial(bonus_score)
	for(var/source in modifiers)
		bonus_score += modifiers[source]
	bonus_score = clamp(bonus_score, 0, 10)
