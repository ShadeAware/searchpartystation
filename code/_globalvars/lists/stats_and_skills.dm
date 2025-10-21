GLOBAL_LIST_INIT(public_skill_stats, init_skill_stats())

/proc/init_skill_stats()
	var/list/stat_list = list()
	for(var/datum/skill/path as anything in subtypesof(/datum/skill))
		if(path == path.abstract_type)
			continue
		var/datum/skill/new_trait = new path
		stat_list[path] = new_trait
	return stat_list
