obj/ranged/Blast/SpiritBall/Genki_Dama
//	Explosive=1
	density=1
	var/Size

	New()
		spawn if(src) Health=Damage
	proc/Medium(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=5)
		overlays.Add(A,B,C,D)
	proc/Large(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-32,pixel_y=-32,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=0,pixel_y=-32,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=32,pixel_y=-32,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=-32,pixel_y=0,layer=5)
		var/image/E=image(icon=Icon,icon_state="5",pixel_x=0,pixel_y=0,layer=5)
		var/image/F=image(icon=Icon,icon_state="6",pixel_x=32,pixel_y=0,layer=5)
		var/image/G=image(icon=Icon,icon_state="7",pixel_x=-32,pixel_y=32,layer=5)
		var/image/H=image(icon=Icon,icon_state="8",pixel_x=0,pixel_y=32,layer=5)
		var/image/I=image(icon=Icon,icon_state="9",pixel_x=32,pixel_y=32,layer=5)
		overlays.Add(A,B,C,D,E,F,G,H,I)
	/*Move()
		var/Distance=0
		if(Size) Distance=Size
		for(var/atom/A in orange(Distance,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()*/
Skill/Attacks/SpiritBomb
	desc="Calculates damage using Offense. Cast it to begin charging and when done charging clicking with the mouse will cause it to move continuosly towards the mouse click."
	UB1="Kaioken"
	UB2="Arcane Power"
	var/IsCharged
	var/Mode="Small"
	NoMove=1
	KiReq=200



//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Ki_Settings()
		set category="Other"
		switch(input("Choose a size. It will affect the power and speed in different ways.") in \
		list("Small","Medium","Large"))
			if("Small")
				Mode="Small"
			if("Medium")
				Mode="Medium"
			if("Large")
				Mode="Large"
	verb/Spirit_Bomb()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		if(usr)
			usr.Ki=(usr.Ki-EDT)
			var/obj/ranged/Blast/SpiritBall/Genki_Dama/A=unpool("Genki_Dama")
			A.Belongs_To=usr
			A.loc=usr.loc
			A.y+=7
			if(!A||!A.z) return
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.name				= "GenkiDama"
			A.Health=1000000000000
			A.Explosive=1
			A.DoNotTrack=1
			if(Mode=="Small") A.icon='SBomb.dmi'
			if(Mode=="Medium")
				A.Size=1
				A.DMGSOURCE_POW	= DMGS_TIER_4*1.1
				A.Explosive=2
				A.Medium('Spirit Bomb.dmi',100,200,250,180)
			if(Mode=="Large")
				A.Size=1
				A.DMGSOURCE_POW	= DMGS_TIER_4*1.2
				A.Explosive=2
				A.Large('Spirit Bomb.dmi',0,0,0,180)
			usr.attacking=3
			charging=1
			hearers(10,usr)<<sound(pick('SpiritBombCharge1.mp3','SpiritBombCharge2.mp3'),volume=20)
			usr.overlays+='SBombGivePower.dmi'
			var/Delay = usr.Refire * 2
			if(Mode=="Small") Delay += 1
			if(Mode=="Medium") Delay += 3
			if(Mode=="Large") Delay += 5
			for(var/mob/M in range(20,usr))
				M.CombatOut("[usr] begins to charge a [src]!")
			sleep(Delay)
			charging=0
			hearers(10,usr)<<sound('SpiritBombFire.mp3',volume=20)
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			for(var/Skill/Zanzoken/Z in usr)if(Z.Zon)
				Z.Zon = 0
				usr.BuffOut("Zanzoken toggled off.")
			if(A)
				IsCharged=1
				//A.SpiritBall=1
				A.maxSteps*=2
				walk_towards(A,usr.Target)
				//usr.overlays+=usr.BlastCharge

