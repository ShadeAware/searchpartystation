//wrapper for retrieving a st_stat datum from the storyteller stat holder
/mob/living/proc/sk_get_stat_datum(stat_path)
	RETURN_TYPE(/datum/skill)
	if(!skill_holder)
		return null
	return skill_holder.get_stat_datum(stat_path)

//wrapper for getting a stat in the storyteller stat holder
/mob/living/proc/sk_get_stat(stat_path, include_bonus = TRUE)
	if(!skill_holder)
		return 0
	return skill_holder.get_stat(stat_path, include_bonus)

/*
* wrapper for setting a stat's value in the storyteller stat holder
* Causes total hp recalculation if the modded stat affects the hp pool.
*/
/mob/living/proc/sk_set_stat(stat_path, amount)
	if(skill_holder)
		skill_holder.set_stat(stat_path, amount)

//wrapper for adding a stat modifier in the storyteller stat holder
/mob/living/proc/sk_add_stat_mod(stat_path, amount, source)
	if(!skill_holder)
		return
	skill_holder.add_stat_mod(stat_path, amount, source)

//wrapper for removing a stat modifier in the storyteller stat holder
/mob/living/proc/sk_remove_stat_mod(stat_path, source)
	if(!skill_holder)
		return
	skill_holder.remove_stat_mod(stat_path, source)
