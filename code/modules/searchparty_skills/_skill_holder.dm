/// This is the object used to store and manage a character's skills.
/datum/skill_holder
	/// A dictionary of skills. K: path -> V: instance.
	VAR_PRIVATE/list/skills = list()

/datum/skill_holder/New()
	. = ..()
	for(var/datum/skill/path as anything in subtypesof(/datum/skill))
		if(path == path.abstract_type)
			continue
		var/datum/skill/new_skill = new path
		skills[path] = new_skill

/datum/skill_holder/Destroy()
	. = ..()
	QDEL_LIST(skills)

/// Return the total or pure score of the given stat.
/datum/skill_holder/proc/get_stat(stat_path, include_bonus = TRUE)
	var/datum/skill/A = skills[stat_path]
	return A.get_score(include_bonus)

/// Sets the score of the given stat.
/datum/skill_holder/proc/set_stat(stat_path, amount)
	var/datum/skill/A = skills[stat_path]
	A.set_score(amount)

/// Return the instance of the given stat.
/datum/skill_holder/proc/get_stat_datum(stat_path)
	RETURN_TYPE(/datum/skill)
	var/datum/skill/A = skills[stat_path]
	return A

/datum/skill_holder/proc/add_stat_mod(stat_path, amount, source)
	var/datum/skill/A = get_stat(stat_path)
	LAZYSET(A.modifiers, source, amount)
	A.update_modifiers()

/datum/skill_holder/proc/remove_stat_mod(stat_path, source)
	var/datum/skill/A = get_stat(stat_path)
	if(LAZYACCESS(A.modifiers, source))
		A.modifiers -= source
		A.update_modifiers()

/*/datum/skill_holder/proc/randomize_attributes(min_score, max_score)
	for(var/datum/skill/A in skills)
		A.set_score(rand(min_score, max_score))*/

/datum/skill_holder/proc/randomize_abilities(min_score, max_score)
	for(var/datum/skill/cognitive/A in skills)
		A.set_score(rand(min_score, max_score))

/*/datum/skill_holder/proc/is_health_affecting(stat_path)
	var/datum/skill/A = get_stat(stat_path)
	return A.affects_health_pool*/
