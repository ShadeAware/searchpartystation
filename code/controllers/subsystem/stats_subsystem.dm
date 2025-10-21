SUBSYSTEM_DEF(stats)
	name = "Character Stats"
	flags = SS_NO_INIT | SS_NO_FIRE

/datum/controller/subsystem/stats/proc/sanitize_stat_list(passed_stats)
	var/new_list = list()
	for(var/stat_path in GLOB.public_skill_stats)
		var/datum/skill/stat = GLOB.public_skill_stats[stat_path]
		var/score = stat.get_score(FALSE)
		if(stat_path in passed_stats)
			score = passed_stats[stat_path]
		new_list[stat_path] = score
	return new_list

/datum/controller/subsystem/stats/proc/apply_stats_from_prefs(mob/living/user, client/applied_client)
	for(var/stat_path in applied_client.prefs.storyteller_stats)
		user.skill_holder.set_stat(stat_path, applied_client.prefs.storyteller_stats[stat_path])
