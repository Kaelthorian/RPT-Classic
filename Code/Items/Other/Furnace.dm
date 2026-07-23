obj/items/furnace
	Basic_Forge
		icon='KitchenStove.dmi'
		desc="This will speed up smelting if you are within 2 tiles."
		Health=100000
		Grabbable=1
		Flammable = 0
		density=1
	Basic_Stovetop
		icon='Turf 52.dmi'
		icon_state="stove"
		desc="This will speed up cooking if you are within 2 tiles."
		Health=100000
		Grabbable=1
		Flammable = 0
		density=1
	Advanced_Furnace
		icon='KitchenStove.dmi'
		desc="This will speed up both cooking and smelting significantly if you are within 2 tiles."
		Health=500000
		Grabbable=1
		Flammable = 0
		density=1
		New()
			..()
			icon+=rgb(20,0,0)
			icon-=rgb(0,10,10)