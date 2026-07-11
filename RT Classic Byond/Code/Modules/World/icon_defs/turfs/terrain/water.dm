turf/atom/Water/proc/GenerateFishes()
	if(prob(1))
		HasFish=1
		var/FishIcon=pick('Fish.dmi','Fish1.dmi','Fish2.dmi','Fish3.dmi')
		overlays+= FishIcon

turf/Terrain
	Water
		plane=-2
		var/tmp/HasFish=0
		New()
			..()
			GenerateFish()
		proc/GenerateFish()
			if(prob(1))
				HasFish=1
				var/FishIcon=pick('Fish.dmi','Fish1.dmi','Fish2.dmi','Fish3.dmi')
				overlays+= FishIcon
		Entered(mob/M)
		verb
			Fish()
				set src in view(1)
				return
				if(src.HasFish&&!usr.IsFishing&&!usr.KOd)
					var/HasBoost=0
					if(locate(/obj/items/Anglers_Lure) in usr) HasBoost=15
					var/obj/items/rawfood/ResultingFish=/obj/items/rawfood/Small_Fish
					if(usr.Fishing_Level+HasBoost>20&&prob(1)&&prob(50))ResultingFish=/obj/items/rawfood/Magic_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(1)&&prob(30))ResultingFish=/obj/items/rawfood/BP_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(1)&&prob(30))ResultingFish=/obj/items/rawfood/Energy_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(1)&&prob(30))ResultingFish=/obj/items/rawfood/Stat_Fish
					else if(usr.Fishing_Level+HasBoost>15&&prob(5))ResultingFish=/obj/items/rawfood/Mana_Fish
					else if(usr.Fishing_Level+HasBoost>15&&prob(5))ResultingFish=/obj/items/rawfood/Gold_Fish
					else if(usr.Fishing_Level+HasBoost>40&&prob(usr.Fishing_Level-30))ResultingFish=/obj/items/rawfood/Crab
					else if(usr.Fishing_Level+HasBoost>50&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Baby_Shark
					else if(usr.Fishing_Level+HasBoost>30&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Large_Fish
					else if(usr.Fishing_Level+HasBoost>10&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Medium_Fish
					view(usr)<<"[usr] starts to fish in [src]."
					var/R=rand(1,1000)
					usr.IsFishing=R
					var/FishSpeed=rand(300,600)
					if(locate(/obj/items/fishingpole/Super_Rod) in usr) FishSpeed-=200
					else if(locate(/obj/items/fishingpole/Good_Rod) in usr) FishSpeed-=140
					else if(locate(/obj/items/fishingpole/Old_Rod) in usr) FishSpeed-=75
					else if(locate(/BodyPart/Tail) in usr) FishSpeed-=75
					if(usr.Fishing_Level+HasBoost>=15) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=30) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=45) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=60) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=75) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=90) FishSpeed*=0.9
					spawn(FishSpeed) if(src&&usr&&usr.IsFishing==R&&HasFish)
						if(prob(1))
							usr<<"You manage to find some tangled fishing line as well."
							usr.contents+= new /obj/items/ingredients/Fishing_Line
						var/obj/items/rawfood/A=new ResultingFish
						var/XPG=A.GivesXP
						usr.Fishing_XP+=XPG
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
						usr.FishingLevelCheck()
						usr.contents+=A
						usr.IsFishing=0
//						usr.InventoryCheck()
						view(usr)<<"[usr] has caught a [A]!"
						if(!prob(usr.Fishing_Level-10))
							src.HasFish=0
							src.overlays-='Fish.dmi'
							src.overlays-='Fish1.dmi'
							src.overlays-='Fish2.dmi'
							src.overlays-='Fish3.dmi'
							view(usr)<<"[usr] has scared away the fish."
		Water6
			icon='Turfs 1.dmi'
			icon_state="water"
			Water=1

		WaterReal
			icon='Turfs 96.dmi'
			icon_state="water1"
			Water=1

		Water5
			icon='Turfs 4.dmi'
			icon_state="kaiowater"
			Water=1

		LavaFall
			icon='LavaFall.dmi'
			density=1
			layer=MOB_LAYER+1
		WaterFall
			icon='Turfs 1.dmi'
			icon_state="waterfall"
			density=1
			layer=MOB_LAYER+1
			Water=1

		Water3
			icon='Misc.dmi'
			icon_state="Water"
			Water=1

		WaterFast
			icon='water.dmi'
			Water=1

		Water8
			icon='turfs.dmi'
			icon_state="nwater"
			Water=1

		Water1
			icon='Turfs 12.dmi'
			icon_state="water3"
			Water=1

		Water11
			icon='Turfs 12.dmi'
			icon_state="water1"
			Water=1

		Water7
			icon='turfs.dmi'
			icon_state="lava"
	//		luminosity=2

		Water2
			icon='Turfs 96.dmi'
			icon_state="stillwater"
			Water=1

		Water12
			icon='Turfs 12.dmi'
			icon_state="water4"
			Water=1

		Water9
			icon='Turfs 12.dmi'
			icon_state="water1"
			Water=1

		Water10
			icon='Turf 50.dmi'
			icon_state="9.1"
			Water=1

		Water13
			icon='Waters.dmi'
			Water=1
			icon_state="13"

///////////////////////////////////////////////////////////////////////////////////////
////////////////////////Water Levels///////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

turf/WaterLevels/Normal
	Water6
		icon='Turfs 1.dmi'
		icon_state="water"
		Water=1
	Water2
		icon='Turfs 96.dmi'
		icon_state="stillwater"
		Water=1
turf/WaterLevels/Medium
	Water6
		icon='WaterMedium1.dmi'
		Water=1
	Water2
		icon='WaterMedium2.dmi'
		Water=1
turf/WaterLevels/Deep
	Water6
		icon='WaterDeep1.dmi'
		Water=1
	Water2
		icon='WaterDeep2.dmi'
		Water=1

