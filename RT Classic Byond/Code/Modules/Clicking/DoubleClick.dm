turf/DblClick(turf/T)
	if(!istype(T, /turf/))
		return 0
	var/HasIT=0
	if(usr.SplitFollowsMouse)
		for(var/mob/Splitform/B in view(usr,25)) if(B.lastKnownKey==usr.key)  B.DoChoice("Click Target",T)
		for(var/mob/Drone/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",T)
		for(var/mob/Doll/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",T)
	if(locate(/Skill/Support/InstantTransmission) in usr) HasIT=1
	if(usr.HasEnergyMovement) HasIT=1
	if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")if(!usr.attacking||HasIT)
		if(usr.client.eye!=usr) return
		if(locate(usr) in src) return
		if(!usr.RPMode) if(usr.LBCD<1) for(var/Skill/Spell/Lightning_Bolt/LB in usr)if(LB.CostOnUse) /*if(usr.Spell_CD == 0)*/
			for(var/obj/Mana/M in usr)
				if(M.Value >= LB.CostOnUse)
					M.Value -= LB.CostOnUse
					usr.DrainKi("Lightning Bolt", 0, 50)
					usr.LBCD=(usr.Refire*2)+20
					var/obj/Lightning_Strike/S = new
					S.loc = locate(T.x,T.y + 3,T.z)
					S.Power = LB.Power
					S.Dest = T
					return
					break
				else
					usr << "You do not have enough mana to continue using this spell."
					LB.CostOnUse=0
			return
		for(var/Skill/Attacks/T3/Explosion/K in usr) if(K.On&&!K.Using_Explosion&&!usr.RPMode&&usr.getCooldown("[K]")<world.time)
			if(usr.Ki>=1)
				K.CD=usr.Refire*2 //K.CD=((usr.Refire*2)/(max(0.5,K.Experience/100)))
				K.CDTick(usr)
				usr.attacking=3
				K.Using_Explosion=1
				K.On = 0
				spawn(usr.Refire*2)
					if(usr)
						usr.attacking=0
						K.Using_Explosion=0
//				ExplosionCEffect(T)
				ExplosionEffect(T)
				if(Level>4)Crater(T)
				else SmallCrater(T)
				var/exprange = range(K.Level,T)
				for(var/turf/A in exprange) if(prob(95))
					for(var/atom/X in A)
						if(X.Flammable)
							X.Burning = 1
							X.Burn(X.Health)
					for(var/mob/B in A) if(!B.afk&&!B.RPMode)
						var/didShield=0
						for(var/obj/items/Force_Field/S in B) if(S.Level>0)
							S.Level = max(0, (S.Level - 1000*((usr.Pow/B.End)*(usr.BP/B.BP)*Ki_Power))) // damage
							S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
							didShield=1
						var/Mult=1
						if(B.Shielding||didShield) Mult=0.7
						/*if(prob(25))
							var/BodyPart/Ears/L =locate(/BodyPart/Ears) in B
							B.Injure_Hurt(30,L,"Explosion ([usr])")*/
						if(B.icon_state == "Flight") if(prob(25))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(!B.Flying)
							B.TakeDamage(usr, 7.5*((usr.Pow/B.End)*(usr.BP/B.BP)*Mult*Ki_Power), "Explosion")
						B.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						B.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					for(var/obj/B in A)
						B.TakeDamage(usr, usr.Pow*5, "Attack")
						//B.Health-=usr.Pow*5
						if(B.Health<=0)
							SmallCrater(B)
							del(B)
					ExplosionEffect(A)
					if(usr.HasSmolder) new/obj/Hazard/Burning_Embers(A)
					if(!A.density)
						A.Health=0
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.TakeDamage(usr, usr.Pow*5, "Explosion")
						//A.Health -= usr.Pow*5
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					if(prob(20))
						sleep(1)
				usr.DrainKi("Explosion",1,50)//usr.Ki -= 50
				hearers(10,usr) << sound(pick('Explosion1.mp3','Explosion2.mp3','Explosion3.mp3','Explosion4.mp3'),volume=20)



			else
				usr<<"You do not have enough energy."
			return
		if(locate(/obj/Door) in T) return
		for(var/Skill/Support/InstantTransmission/A in usr) if(A.Zon)
			if(!T.density) if(usr && usr.client.eye==usr) if(usr.KOd==0)
				usr.Ki*=0.998
				if(!T.density&&!T.Water)
					flick(usr.CustomZanzokenIcon,usr)
					usr.loc=locate(x,y,z)
					return
		for(var/Skill/Zanzoken/A in usr)
			for(var/Skill/Attacks/AA in usr) if(AA.charging||AA.streaming||AA.Using) return 0
			if(usr.RPMode) return
			if(!A.Zon) return
			if(StunCheck(usr)) return
			if(usr.Frozen) return
			if(usr.S) return
			if(A.Charges<1) return
			if(usr.isGrabbing&&usr.Race!="Yardrat") return
			if(T.z!=usr.z) return
			if(usr.icon_state=="KB"||usr.KB) return
			if(T in view(15,usr))
				hearers(10,usr) << sound(pick('Zanzoken1.mp3','Zanzoken2.mp3','Zanzoken3.mp3'),volume=20)
				A.Charges--
				usr.CombatOut("[A.Charges] Zanzoken charges remain.([((usr.Refire*2)+5)/(1+usr.HasZanzokenMaster)] seconds per charge.)")
				spawn(((usr.Refire*2)+5)/ (1+usr.HasZanzokenMaster)) A.Charges++
				var/Drain = 5
				if(usr.HasZanzokenMaster) Drain*=0.05
				if(Drain > usr.MaxKi) Drain = usr.MaxKi
				if(!T.density && usr.Ki >= Drain)
					ZanzoDust(usr)
					//if(usr.Race=="Android") flick('Black Hole.dmi',usr)
					flick(usr.CustomZanzokenIcon,usr)
					var/turf/Can = get_step_to(usr,T,0)
					if(Can == null)
						usr << "You can't seem to reach there..."
						return
					if(isturf(Can))
						if(blankBlocked2(usr,Can))
							usr << "You can't seem to reach there..."
							return
						var/OldDir = usr.dir
						if(usr.Zanzoken>999) usr.AfterImage()
						usr.Move(T)
						usr.dir = OldDir
						usr.Zanzoken += 0.5*usr.ZanzoMod
						usr.DrainKi(A,1,Drain)//usr.Ki=max(0,usr.Ki-Drain)
					if(prob(10)) usr.SpdMod+=0.01*usr.SpdMod*StatGain*usr.GravMulti*usr.CatchUp()*usr.StatCapCheck(usr.SpdMod/usr.SpdMod)
				return