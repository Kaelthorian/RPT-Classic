
mob/var/Shielding=0
Skill/Buff/Shield
	End=1.05
//	var/SMEnd=1.1
	buffon="begins to shield themselves."
	buffoff="stops using the shield technique."


	New()
		icon=pick('Shield, Legendary.dmi','Pride_Shield.dmi','Basic_Shield.dmi')
		icon+=rgb(rand(1,200),rand(1,200),rand(1,200))
		..()
	icon='Shield, Legendary.dmi'
	/*GetDescription(mob/Getter)
		return "This ability will take 30% of your recovery ticks and convert it into a shield which increases your endurance by [End]x while active. This will also grant a 10% chance to deflect projectiles, reduces beam damage by 10% and reduces explosion damage by 50%."
		..()*/
	buffslot=0
	Using = 0
//	layer=MOB_LAYER+3
	var/Master=0
	verb/Shield()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(usr.Ki<=0)
			usr<<"Not enough energy"
			return
		if(usr.HasShieldMaster)End=1.15
		else End=1.10
		use(usr,null,0,0,0,0,0,0,1)




/*
atom
	var
		Blocking=0
		CounterParry=0
		CounterBlock=0
		SonicSway=0
		BlockShield=25
Icon_Obj/Effects/Shield
	icon='BlockSprite.dmi'
	Grabbable=0
proc
	BlockDamage(mob/m,Damage)
		var/NewDamage=Damage
		if(m.Blocking&&!m.KO)
			if(m.BlockShield=="Breaking")
			else
				NewDamage/=2
				m.BlockShield-=NewDamage
				if(m.BlockShield<=0)
					m.BlockShield="Breaking"
					//animate(m.Blocking,transform=matrix()*2)
					flick("Shatter",m.Blocking)
					m.OMessage(10,"[m]'s defense shatters!","[m]([m.key]) 'had /his block broken.")
					animate(m.Blocking,alpha=0,time=5)
					Stun(m,3)
					spawn(10)
						BlockStop(m)
					spawn(100)
						m.BlockShield=0
		return sqrt(NewDamage)/2
mob
	Players
		verb/Block()
			set category="Skills"
			if(KO) return
			if(src.Knockbacked)
				for(var/obj/Skills/MartialArts/AerialRecovery2/x in src)
					src.Skill1X("AerialRecovery",x)
					return
			if(Blocking)
				del Blocking
				src<<"You take a more <font color=green>offensive</font color> stance."
			else
				if(BlockShield>0)
					var/Icon_Obj/Effects/Shield/S = new
					Blocking=S
					Blok(src)
				//	src<<"You take a more <font color=green>defensive</font color> stance."
					sleep(10)
					del Blocking
proc
	Blok(atom/m)
		if(m.Blocking)
			m.Blocking:loc=m.loc
	BlockStop(atom/m)
		del m.Blocking
	BlockHealth(atom/m)
		if(m.Blocking)
			if(m.BlockShield>=initial(m.BlockShield)*0.66)
				m.Blocking:icon_state="3"
			else if(m.BlockShield<66&&m.BlockShield>initial(m.BlockShield)*0.33)
				m.Blocking:icon_state="2"
			else if(m.BlockShield<initial(m.BlockShield)*0.33)
				m.Blocking:icon_state="1"
*/