mob/Admin1/verb

	Player_Panel(mob/M in Players)
		set category = "Server"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(!ismob(M)) return
		var/dat = "<html><head><title>Options for [M.key]</title></head>"
		var/foo = "\[ "
		if(M.client)
			foo += text("<A href='?src=\ref[usr.client.holder];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.sfIsMuted(M.client) ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[usr.client.holder];givemenu=\ref[M]'>Give Menu</A> | ")
			foo += text("<A href='?src=\ref[usr.client.holder];privatemessage=\ref[M]'>Private Message</A> | ")
			if (Players.Find(M))
				foo += text("<A HREF='?src=\ref[usr.client.holder];observe=\ref[M]'>Watch</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];sendToSpawn=\ref[M]'>Send to Spawn</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];assess=\ref[M]'>Assess</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];giveobj=\ref[M]'>Give Obj</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];kill=\ref[M]'>Kill</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];knockout=\ref[M]'>Knockout</A> | ")
//				if(usr.client.holder.level>=2) foo += text("<A HREF='?src=\ref[usr.client.holder];CapStats=\ref[M]'>Cap Stats</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];heal=\ref[M]'>Heal</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];revive=\ref[M]'>Revive</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];readmind=\ref[M]'>Player Journal</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];getlog=[M.lastKnownKey];portion=0'>Check Logs</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];emoteaudit=\ref[M]'>Mark Emote Audit</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];subtlemessage=\ref[M]'>IC Message</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];summon=\ref[M]'>Summon</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];jumpto=\ref[M]'>Jump to</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];XYZTele=\ref[M];'>XYZ Teleport</A> | ")
				if(usr.client.holder.level>=2) foo += text("<A href='?src=\ref[usr.client.holder];command=edit;target=\ref[M];type=view;'>Edit</A> | ")
				//foo += text("<A HREF='?src=\ref[usr.client.holder];starterboost=\ref[M]'>Starter Boost</A> | ")
				//foo += text("<A HREF='?src=\ref[usr.client.holder];statredo=\ref[M]'>Give Redo Stats</A> | ")
				//foo += text("<A HREF='?src=\ref[usr.client.holder];alterstats=\ref[M]'>Alter Stats</A> | ")
		foo += text("<A href='?src=\ref[usr.client.holder];boot2=\ref[M]'>Boot</A> | ")
		foo += text("<A href='?src=\ref[usr.client.holder];newban=\ref[M]'>Ban</A> \]")
		dat += text("<body>[foo]</body></html>")
		usr << browse(dat, "window=adminplayeropts;size=500x130")