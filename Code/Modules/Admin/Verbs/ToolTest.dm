mob/Admin1/verb/ToolTest()
	for(var/turf/R in world)
		for(var/T in R.contents)
			world<<"[T]"