mob/Admin1/verb

	Check_Allow_Rares()
		set category = "Admin Other"
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains: [list2params(global.AllowRares)]"
		for(var/atom/I as anything in AllowRares)
			src << "[I] is a [I.type]"