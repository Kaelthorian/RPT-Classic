obj/items/Repair_Kit
	icon='Lab.dmi'
	icon_state="Tool2"
	desc="Restores full durability to any item. (Target must be on the ground)"
	verb/Repair()
		var/list/repairlist=list()
		for(var/obj/items/A in view(usr,1)) if(A.Durability<A.MaxDurability) repairlist+=A
		repairlist+="Cancel"
		var/obj/items/c=input("Repair what?") in repairlist
		if(c=="Cancel") return
		else
			c.Durability=c.MaxDurability
			if(c.Durability>c.MaxDurability) c.Durability=c.MaxDurability
			view(usr)<<"[usr] repaired the [c] to [c.Durability] Durability!"
			del(src)