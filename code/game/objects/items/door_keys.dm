/obj/item/key/door_key
	name = "key"
	desc = "A small key."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "key"
	w_class = WEIGHT_CLASS_TINY
	var/door_key_hash = null

/obj/item/key/door_key/Initialize(mapload)
	. = ..()
	if(!door_key_hash)
		desc = "The blade is completely flat, this won't open a thing!"
