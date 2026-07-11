/*Event/Timer/UltraInstinct
	var/tmp/mob/player
	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 25)
		src.player = D
	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.
		if(isnull(player)){skills_scheduler.cancel(src);return}
		//Focus
		if(player.UltraInstinct_Clicks > 2)
			player.UltraInstinct_Clicks -= 1
			return
		for(var/Skill/Buff/UltraInstinct/A in player) if(!player.RPMode)
			if(A.Using)
				if(player.Ki>=player.MaxKi*0.02)
					player.DrainKi("Ultra Instinct", "Percent", Tier3Drain)
					//player.Ki=max(0,player.Ki-(player.MaxKi*0.2)/A.Experience)
					if(!player.afk&&player.icon_state!="Meditate") A.Experience+=0.5
					if(prob(20)) player.Willpower-=0.25
					if(A.Experience>100) A.Experience=100
				else {player.Cancel_UltraInstinct();player=null}
			else {player.Cancel_UltraInstinct();player=null}


mob/var/tmp/Event/Timer/UltraInstinct/ultrainstinct_event = null
mob/var/tmp/UltraInstinct_Clicks = 0
mob/proc/Cancel_UltraInstinct()
	if (src.ultrainstinct_event)
		skills_scheduler.cancel(src.ultrainstinct_event)
		del(src.ultrainstinct_event)
		src.ultrainstinct_event = null
	src.UltraInstinct_Revert()*/

Skill/Buff/UltraInstinct
	BP=3.5
	Spd=2
	Off=2
	Def=2
	Recov=2
	icon='SatsuiAura.dmi'
	buffon="begins using Ultra Instinct."
	buffoff="stops using Ultra Instinct."
	layer=MOB_LAYER+1
	buffslot=3
	healthdrain=1
	var/Precog=0

	/*GetDescription(mob/Getter)
		return "Increases God Ki by 50%, BP by [BP]x, Speed by [Spd]x, Offense by [Off]x and Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(0,184,184,200)
		//157,95,191
		..()
	verb/Ultra_Instinct()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)






