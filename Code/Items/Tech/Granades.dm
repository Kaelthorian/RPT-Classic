obj/items/Explosives
	icon='TBomb.dmi'
	Hand_Grenade
		desc="This is a single use grenade that does Offense damage."
		verb/Hand_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(usr.LastUsedGrenade>world.realtime)
				usr<<"You're throwing grenades too fast! You can throw another one in [(usr.LastUsedGrenade-world.realtime)/10] seconds ."
				return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			usr.DrainKi(src,1,50)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=7.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
			usr.LastUsedGrenade=(world.realtime+(usr.Refire*100))
	Stun_Grenade
		desc="This is a single use grenade that does 1 tick of stun."
		verb/Stun_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			if(usr.LastUsedGrenade>world.realtime)
				usr<<"You're throwing grenades too fast! You can throw another one in [(usr.LastUsedGrenade-world.realtime)/10] seconds ."
				return
			CD=(usr.Refire)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			usr.DrainKi(src,1,50)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=5.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=1
			A.Paralysis=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
			usr.LastUsedGrenade=(world.realtime+(usr.Refire*100))

	Fire_Bomb
		desc="This is a single use grenade that generates tiles of Burning Embers."
		verb/Fire_Bomb()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			if(usr.LastUsedGrenade>world.realtime)
				usr<<"You're throwing grenades too fast! You can throw another one in [(usr.LastUsedGrenade-world.realtime)/10] seconds ."
				return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			usr.DrainKi(src,1,50)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=5.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.MakesFire=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
			usr.LastUsedGrenade=(world.realtime+(usr.Refire*100))
	High_Explosive_Grenade
		desc="This is a single use grenade that does a lot of damage and includes all other grenade effects."
		verb/High_Explosive_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			if(usr.LastUsedGrenade>world.realtime)
				usr<<"You're throwing grenades too fast! You can throw another one in [(usr.LastUsedGrenade-world.realtime)/10] seconds ."
				return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			usr.DrainKi(src,1,50)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=10.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.MakesFire=1
			A.Hellzone=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
			usr.LastUsedGrenade=(world.realtime+(usr.Refire*100))