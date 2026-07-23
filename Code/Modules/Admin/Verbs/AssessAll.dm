mob/Admin1/verb

	Assess_All()
		set category = "Admin"   //<font color="#CCCCCC"><style type="text/css"><!--body {color:#449999;background-color:black;font-size:14;}table {font-size:12;}//--></style><body>
		var/list/Powers=new
		var/Power_Window={"<html><body style="background-color:#212121" text="#80d8FF"><font color=#80d8FF><font size=10>Assess All<hr><table border=1 cellspacing=5 font size=6><font size=6>"}
		for(var/mob/player/A in Players) Powers += A.Base
		for(var/P in Powers)
			var/Lowest_Power=min(Powers)
			for(var/mob/player/A in Players)
				if(Lowest_Power==A.Base) //if(P==A.BP)
					if(A in Power_Window) continue
					var/text = "<td><font color=[A.TextColor]>[A]<font color=#80d8FF> ([A.Race]) [A.Class=="Undefined Class" ? "" : "([A.Class])"]</td> <td>BP: [Commas(A.BP)] ([A.BPMult] Mult)</td> <td>Energy: [Commas(A.BaseMaxKi)] ([A.KiMod])</td> <td>Base:"
					text += " [Commas(min(Powers))] ([A.BPMod] Mod)</td><td>(BP Rank [round(A.BPRank)])</td><td>[round(A.WeightedStats)] Weighted Stats</td><td>(Stat Rank [round(A.StatRank)])</td><tr>"
					Power_Window += text
					Powers-=min(Powers)
		usr << browse(Power_Window,"window=World Assess;size=880x720")
		//log_admin("[key_name(src)] used assess all.")