obj/items/Bookcase
	icon='Lab.dmi'
	icon_state="Books"
	Flammable = 1
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="BooksTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000

	Grabbable=1
	density=1
	layer=4
	desc="It's a book-case.  This will boost intelligence and magic gains by 10% for those within 1 tile."