obj/items/Medicine_Cabinet
	icon='Lab.dmi'
	icon_state="Cabnit"
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="CabnitTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000
	Grabbable=1

	Flammable = 1
	density=1
	layer=4
	desc="This will increase the Regeneration rate of those within 1 tile."