mob/AdminToggles/verb
	Show_Server_Tab()
		set category = "Admin Other"
		src=usr
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		ServerTab()

mob/proc
	ServerTab() if(src.client.holder)
		winclone(src, "GenericSheet", "Server")
		winshow(client,"Server",1)
		winset(src.client,"Server","title=\"Server Insight\"")
		sleep()
		winset(client,"Server.Grid","cells=0x0")
		var/Row=0
		Row++
		src << output("Server Information", "Server.Grid:1,[Row]")

		Row++
		var/TP
		for(var/mob/M in Players) TP++
		var/AP
		for(var/mob/M in Players) if(M.afk) AP++
		src << output("Total Players: [TP]", "Server.Grid:1,[Row]")
		src << output("Active Players: [TP-AP]", "Server.Grid:2,[Row]")
		src << output("AFK Players: [AP]", "Server.Grid:3,[Row]")

		Row++
		var/ABP
		var/CC
		var/AB
		for(var/mob/player/M in Players) if(isnum(M.Base)) if(isnum(M.BPMod))
			CC++
			ABP+=M.Base/M.BPMod
			AB+=M.Base
		if(CC)
			ABP/=CC
			AB/=CC
		src << output("Average Base:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AB))]", "Server.Grid:2,[Row]")
		src << output("[Commas(round(ABP))] x BPMod", "Server.Grid:3,[Row]")
		Row++
		var/BPPer
		var/HBP
		for(var/mob/player/M in Players) if(M.Base>HBP)
			HBP=M.Base
			BPPer=M
		src << output("Highest Base:", "Server.Grid:1,[Row]")
		src << output(BPPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HBP))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		CC=0
		var/ACBP
		for(var/mob/player/M in Players) if(isnum(M.BP))
			CC++
			ACBP+=M.BP
		if(CC) ACBP/=CC
		src << output("Average BP:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(ACBP))]" , "Server.Grid:2,[Row]")
		Row++
		var/CBPPer
		var/HCBP
		for(var/mob/player/M in Players) if(M.BP>HCBP)
			HCBP=M.BP
			CBPPer=M
		src << output("Highest BP:", "Server.Grid:1,[Row]")
		src << output(CBPPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HCBP))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		CC=0
		var/AEN
		var/AE
		for(var/mob/player/M in Players) if(isnum(M.MaxKi))if(isnum(M.KiMod))
			CC++
			AE+=M.BaseMaxKi
			AEN+=M.BaseMaxKi/M.KiMod
		if(CC)
			AEN/=CC
			AE/=CC
		src << output("Average Energy:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AE))]", "Server.Grid:2,[Row]")
		src << output("[Commas(round(AEN))] x KiMod", "Server.Grid:3,[Row]")
		Row++
		CC=0
		var/ENPer
		var/HEN
		for(var/mob/player/M in Players) if(M.BaseMaxKi>HEN)
			HEN=M.BaseMaxKi
			ENPer=M
		src << output("Highest Energy:", "Server.Grid:1,[Row]")
		src << output(ENPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HEN))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		var/AWS
		for(var/mob/player/M in Players) if(isnum(M.WeightedStats))
			CC++
			AWS+=M.WeightedStats
		if(CC) AWS/=CC
		src << output("Average Weighted Stats:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AWS))]" , "Server.Grid:2,[Row]")
		Row++
		var/WSPer
		var/HWS
		for(var/mob/player/M in Players) if(M.WeightedStats>HWS)
			HWS=M.WeightedStats
			WSPer=M
		src << output("Highest Weighted Stats:", "Server.Grid:1,[Row]")
		src << output(WSPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HWS))]", "Server.Grid:2,[Row]")
		var/HInt
		var/IPer
		for(var/mob/player/M in Players) if(M.Int_Level>HInt)
			HInt=M.Int_Level
			IPer=M
		var/HMag
		var/MPer
		for(var/mob/player/M in Players) if(M.Magic_Level>HMag)
			HMag=M.Magic_Level
			MPer=M
		CC=0
		var/AveInt
		for(var/mob/player/M in Players) if(M.Int_Level>=20)
			AveInt+=M.Int_Level
			CC++
		if(CC) AveInt/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Intelligence:", "Server.Grid:1,[Row]")
		src << output("[round(AveInt,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Intelligence:", "Server.Grid:1,[Row]")
		src << output(IPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HInt))]", "Server.Grid:2,[Row]")
		CC=0
		AveInt=0
		for(var/mob/player/M in Players) if(M.Magic_Level>=20)
			AveInt+=M.Magic_Level
			CC++
		if(CC) AveInt/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Magic Level:", "Server.Grid:1,[Row]")
		src << output("[round(AveInt,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Magic Level:", "Server.Grid:1,[Row]")
		src << output(MPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HMag))]", "Server.Grid:2,[Row]")
		var/HG
		var/GPer
		for(var/mob/player/M in Players) if(M.GainMultiplier>HG)
			HG=M.GainMultiplier
			GPer=M
		CC=0
		var/AGG
		for(var/mob/player/M in world) if(isnum(M.GainMultiplier))
			CC++
			AGG+=M.GainMultiplier
		if(CC) AGG/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Gain Multiplier:", "Server.Grid:1,[Row]")
		src << output("[round(AGG,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Gain Multiplier:", "Server.Grid:1,[Row]")
		src << output(GPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HG))]", "Server.Grid:2,[Row]")
		//Row++
		src<<output("<A HREF='?src=\ref[src.client.holder];servertab=\ref[src]'>Refresh</A>","Server.RefreshG:1,1")