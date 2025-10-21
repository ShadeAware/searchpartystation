/datum/preference/numeric/age
	explanation = "Biological Age"
	savefile_key = "age"
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = AGE_MIN
	maximum = AGE_MAX

/datum/preference/numeric/age/apply_to_human(mob/living/carbon/human/target, value)
	target.age = value

/datum/preference/numeric/chronological_age
	explanation = "Chronological Age"
	savefile_key = "age"
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = CHRONOAGE_MIN
	maximum = CHRONOAGE_MAX

/datum/preference/numeric/age/apply_to_human(mob/living/carbon/human/target, value)
	target.age = value

/datum/preference/numeric/chronological_age/apply_to_human(mob/living/carbon/human/target, value)
	target.chronological_age = value
	if(value >= 120)
		log_admin("Client [target.ckey] has set an extremely high chronological age of [value] and may be abusing skill point benefits. Watch closely.")
		message_admins("Client [target.ckey] has set an extremely high chronological age of [value] and may be abusing skill point benefits. Watch closely.")

