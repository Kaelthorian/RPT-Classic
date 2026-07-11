obj/items/Gravity
	Health=5000
	proc/GravityGen()
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER-1)
		icon_state="on"
		for(var/turf/G in view(RangeSet,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			if(Grav_Setting>1&&Battery>=1) G.overlays+=I
		if(!IsOn&&Battery>=1&&Grav_Setting>1)
			IsOn=1
			while(Battery>0&&IsOn&&Grav_Setting>1)
				Battery--
				for(var/turf/G in view(RangeSet,src))
					G.Gravity=Grav_Setting
				if(prob(2)) view(src)<<"The Gravity Machine vibrates... ([round(Battery/MaxBattery*100)]% Battery)"
				if(Grav_Setting<=1) Deactivate()
				else if(Battery<=0)
					Battery=0
					Deactivate()
				else if(!IsOn) Deactivate()
				sleep(540)
	Move()
		Deactivate()
		..()
	Del()
		Deactivate()
		..()
	layer=MOB_LAYER+5

	density=1
	desc="Place this anywhere on the ground to use it, it will affect anything within its radius."
	var/Max=1
	var/Range=1
	var/RangeSet=1
	var/Battery=100
	var/MaxBattery=100
	var/tmp/IsOn=0
	var/tmp/Grav_Setting = 0
	icon='gravmach.dmi'

	proc/Deactivate()
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER-1)
		for(var/turf/G in range(RangeSet,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			G.Gravity=0
		Grav_Setting=0
		IsOn=0
		icon_state=""
		SaveItem(src)

	Click() if(usr in range(1,src))
		if(src.Grav_Setting>1)
			Deactivate()
			view(src)<<"[usr] sets the Gravity multiplier set to normal."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to normal. \n")
			return
		var/Grav=input("Gravity Multiplier: Machine Maximum output is [Max]x ([round(Battery/MaxBattery*100)]% Battery remaining)") as num
		if(Grav>Max) Grav=Max
		if(Grav<0) Grav=0
		if(!Grav) Grav=1
		view(src)<<"[usr] sets the Gravity multiplier set to [Grav]x"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to [Grav]x \n")
		Grav_Setting = Grav
		GravityGen()
		SaveItem(src)
	verb/Bolt()
		set src in oview(1)
		DeleteSaveItem(src)
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

	verb/Set_Field_Size()if(Range>1)
		set src in view(1)
		SaveItem(src)
		Deactivate()
		var/FStrength=input("What would you like to set the field size to ([Range] Max)") as num
		if(FStrength<=1) FStrength=1
		if(FStrength>=Range) FStrength=Range
		RangeSet=FStrength
		range(20,src)<<"[usr] sets [src]'s field to range [RangeSet]."

	verb/Upgrade()
		set src in view(1)
		SaveItem(src)
		var/obj/Resources/A =locate(/obj/Resources) in usr
		var/list/Choices=new
		if(Max<1000) if(Max<(usr.Int_Level-50)*6) Choices.Add("Field Limit ([round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
		if(Range<5) if(A.Value>=1000*Tech/usr.Int_Mod)if(usr.Int_Level>=50) Choices.Add("Field Range ([round((75000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))])")
		if(MaxBattery<1000) if(usr.Int_Mod>=2)if(usr.Int_Level>=20) Choices.Add("Max Battery ([round((3000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
		if(Battery<MaxBattery) Choices.Add("Refuel (5000 x Unit)")
		Choices.Add("Cancel")
		if(!Choices)
			usr<<"You have reached the limit of this machine or do not have enough resources."
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Cancel") return
		if(Choice=="Refuel (5000 x Unit)")
			var/MaxF=round(MaxBattery-Battery)
			var/AM=input(usr,"How many units? (0-[MaxF])","Refueling") as num
			if(AM<=0) return
			if(AM>MaxF) AM=MaxF
			AM=round(AM)
			var/Cost=AM*5000*(1-(0.15*usr.HasDeepPockets))
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost
			Battery+=AM
			if(Battery>MaxBattery)Battery=MaxBattery
			view(usr)<<"[usr] refuels the [src] to [Battery] Units."
			return
		if(Choice=="Field Limit ([round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
			var/UPG=input("Increase the maximum field limit to what number? ([Max] - [(usr.Int_Mod*GravTune)] the server max is 240") as num
			UPG=round(UPG)
			if(UPG<=Max) return
//			if(UPG>(usr.Int_Level-50)*6) UPG=(usr.Int_Level-50)*6
			if(UPG>(usr.Int_Mod*GravTune)) UPG=(usr.Int_Mod*GravTune)
			if(UPG>240) UPG=240
			var/Cost=round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))*(UPG-Max)
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			Max=UPG //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Limit level [Max].\n")
			view(usr)<<"[usr] upgrades the [src] to Field Limit level [Max]."
		if(Choice=="Field Range ([round((75000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))])")
			var/Cost=round((75000*(0.8*Range))/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			Range++ //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Range [Range].\n")
			view(usr)<<"[usr] upgrades the [src] to Field Range [Range]."
		if(Choice=="Max Battery ([round((3000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
			var/UPG=input("Increase the battery to what number? ([MaxBattery] - 1000)") as num
			UPG=round(UPG)
			if(UPG<=MaxBattery) return
			if(UPG>1000) UPG=1000
			var/Cost=round((30000*(0.1*MaxBattery))/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))*(UPG-MaxBattery)
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			MaxBattery=UPG //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Range [Range].\n")
			view(usr)<<"[usr] upgrades the [src] to [MaxBattery] Max Battery."
//		Tech++
		desc=null
		if(Max==1000) desc+="<br>Field Max: [Max] ([Max]x) <font color=red>MAXED</font>"
		else desc+="<br>Field Max: [Max] ([Max]x)"
		if(Range==5) desc+="<br>Field Range: [Range] <font color=red>MAXED</font>"
		else desc+="<br>Field Range: [Range]"
		if(MaxBattery==1000) desc+="<br>Maximum Battery: [MaxBattery] <font color=red>MAXED</font>"
		else desc+="<br>Maximum Battery: [MaxBattery]"
	verb/Info()
		set category=null
		set src in oview(1)
		usr<<"[desc]"