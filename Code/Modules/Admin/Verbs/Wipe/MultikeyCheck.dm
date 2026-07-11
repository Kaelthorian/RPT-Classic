mob/Admin1/verb

	Multikey_Check(var/mob/M in world)
		set category = "Server"
		if(!usr.client.holder||usr.client.holder.level<1) return
		for(var/mob/player/A in world) if(A.client) if(A.ckey!="Mumit"||A.ckey!="chewyy")//for(var/mob/player/AA in world)
			if(A == M) continue
			if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id==A.client.computer_id)))
				src<<"<font size=1 color=\"red\">   Multikey: [M] ([M.key]) (Same Computer)</font>"
				src<<"<font size=1 color=\"red\">   Multikey: [A] ([A.key]) (Same Computer)</font>"
			if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id!=A.client.computer_id)))
				src<<"<font size=1 color=\"#FF8040\">   Multikey: [M] ([M.key]) (Same Network)</font>"
				src<<"<font size=1 color=\"#FF8040\">   Multikey: [A] ([A.key]) (Same Network)</font>"