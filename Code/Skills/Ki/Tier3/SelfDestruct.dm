Skill/Attacks/T3/Self_Destruct
	UB1="Death"
	UB2="Arcane Power"


	desc="Using this will kill you. It is an extremely powerful attack, one of the top 3 at least. It will affect a large area.This technique reuqires 70 or less Willpower.It will pop up a window asking for confirmation."

//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/Self_Destruct()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(usr.Willpower>70)
			usr<<"This technique requires 70 or less Willpower."
			return
		if(!usr.Lethality) if(!usr.Confirm("Lethality is currently off. Using SD will set lethality on. Continue?")) return
		switch(input("Self Destruct?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&usr.KOd==0)
				usr.Lethality=1
				usr.move=0
				Using=1
				for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
				sleep(10)
				for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
				sleep(10)
				if(usr.KOd)
					Using=0
					usr.move=1
					return
				for(var/mob/player/P in view(12)) P.BuffOut("A huge explosion eminates from [usr] and surrounds the area!")
				for(var/turf/T in view(usr,20))
				//	if(prob(7)) sleep(1)
					if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
					//T.Health-=100*usr.Pow
					T.TakeDamage(src, 75*usr.Off, "Self Destruct")
					spawn(rand(50)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr)if(!M.afk)
						M.TakeDamage(usr, ((usr.BP+usr.Off)/(M.BP+M.End))*1000, "Self Destruct")
						//M.Health-=((usr.BP+usr.Pow)/(M.BP+M.Res))*120
						if(M.Health<=0)
							if(M.Regenerate&&M.KOd==0) if(usr.BP>M.BP*M.Regenerate) M.Absorbed=1
							spawn M.Death(usr)
				usr.Death("Self Destruct")
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct.\n")
				usr.Ki=0
				usr.move=1
				spawn(10) if(usr) src.Using=0
				hearers(10,usr) << sound(pick('Explosion1.mp3','Explosion2.mp3','Explosion3.mp3'),volume=20)

turf/proc/Rising_Rocks()
	overlays-='Rising Rocks.dmi'
	overlays+='Rising Rocks.dmi'
	spawn(rand(20,150)) if(src) overlays-='Rising Rocks.dmi'


var/image/Self_Destruct_Fire=image(icon='Lightning flash.dmi',layer=99)

turf/proc/Self_Destruct_Lightning(B) if(B)
	overlays-=Self_Destruct_Fire
	overlays+=Self_Destruct_Fire
	spawn(B) if(src) overlays-=Self_Destruct_Fire