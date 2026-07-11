obj/items/Statue
	Health=1000000000
	density=1
	var/BigStatue=0
	Savable=1
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
			return

	New()
		..()
		var/image/AA=image('Statue_Base.dmi',pixel_y=-7)
		underlays+=AA
		if(BigStatue) animate(src, transform = matrix()*2, time = 0)