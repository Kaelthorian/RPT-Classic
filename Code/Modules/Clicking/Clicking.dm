mob/Click()
	if(src==usr) if(usr.HasSSj4) if(usr.KOd==0) if(usr.Ki>usr.MaxKi*0.1) if(!usr.ssj) if(usr.Confirm("Go SSj4?")) if(usr.KOd==0) if(usr.Ki>usr.MaxKi*0.1) if(!usr.ssj) SSj4()
	if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")if(!usr.attacking)
		if(usr.client.eye!=usr) return
		if(locate(usr) in src) return
		if(!usr.RPMode) if(usr.LBCD<1) for(var/Skill/Spell/Lightning_Bolt/LB in usr)if(LB.CostOnUse) /*if(usr.Spell_CD == 0)*/
			for(var/obj/Mana/M in usr)
				if(M.Value >= LB.CostOnUse)
					M.Value -= LB.CostOnUse
					usr.DrainKi("Lightning Bolt", 0, 50)
					usr.LBCD=(usr.Refire*2)+20
					var/obj/Lightning_Strike/S = new
					S.loc = locate(src.x,src.y + 3,src.z)
					S.Power = LB.Power
					S.Dest = src.loc
					return
					break
				else
					usr << "You do not have enough mana to continue using this spell."
					LB.CostOnUse=0
			return
		for(var/Skill/Attacks/BlueCometSpecial/K in usr) if(K.On&&!K.Blue_Comet_Special&&!usr.RPMode&&usr.getCooldown("[K]")<world.time) if(usr.Target)
			if(usr.Ki>=500) if(usr.Target.z==usr.z)
				usr.attacking=3
				K.Blue_Comet_Special=1
				K.On = 0


				usr.DrainKi("Blue Comet Special",1,500)
				K.CD=usr.Refire*4
				K.CDTick(usr)
				var/amount=K.Level
				var/list/spawnArea = oview(src,3)
				spawn()
					while(!usr.KOd&&amount>0)
						amount-=1
						flick(usr.CustomZanzokenIcon,usr)
						var/obj/ranged/Blast/A=unpool("Blasts")
						A.density=0
						A.Belongs_To=usr
						A.pixel_x=usr.pixel_x
						A.pixel_y=usr.pixel_y
						A.icon=usr.icon
						A.overlays=usr.overlays
						A.underlays=usr.underlays
						A.icon+=rgb(0,0,0,155)
						A.overlays+=rgb(0,0,0,155)
						A.name="Blue Comet Special"
						var/spawnSpot=pick(spawnArea)
						A.loc=spawnSpot
						spawnArea-=spawnSpot
						A.dir=usr.dir
						A.Explosive=1
						A.Shockwave=1
						A.Damage=usr.BP*usr.Spd*Ki_Power*7
						A.Power=(usr.BP)*Ki_Power
						A.Offense=usr.Off*2
						spawn(rand(2,5))
							if(A)
								A.density=1
								walk_towards(A,usr.Target,1)
						sleep(1)
				spawn(usr.Refire)
					K.Blue_Comet_Special=0
					usr.attacking=0
				return
		for(var/Skill/Attacks/T3/Explosion/K in usr) if(K.On&&!K.Using_Explosion&&!usr.RPMode&&usr.getCooldown("[K]")<world.time) //if(usr.Target) // for(var/Skill/Attacks/T3/Explosion/K in usr) if(K.On&&!K.Using_Explosion) if(!usr.RPMode)if(usr.CanAttack(50,K.CD)) if(!src.afk&&!src.RPMode)
			if(usr.Ki>=50)
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
				ExplosionEffect(src)
				if(Level>4)Crater(src)
				else SmallCrater(src)
				var/exprange = range(K.Level,src)
				for(var/turf/A in exprange) if(prob(95))
					for(var/atom/X in A)
						if(X.Flammable)
							X.Burning = 1
							X.Burn(X.Health)
					for(var/mob/B in A)
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



	if(src==usr||usr.Target==src) usr.Target=null
	else if(client)
		usr.Target=src
		usr<<"Target Acquired ([usr.Target])"
	//for(var/obj/items/Scanner/A in usr) if(A.suffix) usr<<"Scanner: [Commas(BP)]"
	usr<<"[src] Lethality: [Lethality ? "On" : "Off"] [Spar ? "\[Pulling Punches\]" : ""]"
	if(src!=usr)if(usr.SplitFollowsMouse)
		for(var/mob/Drone/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",src)
		for(var/mob/Splitform/B in view(usr,25)) if(B.lastKnownKey==usr.key)  B.DoChoice("Click Target",src)
		for(var/mob/Doll/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",src)
	if(usr.client && usr.client.holder && usr==src && !usr.Target)
		usr.Target=src
		return