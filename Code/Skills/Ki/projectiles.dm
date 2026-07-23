
Skill/Attacks/var/NoMove=0
obj/ranged
	luminosity=2 // Yes, energy attacks give light.
	layer=MOB_LAYER+1
	Savable=0 // This is part of the saving system. Objects that should be savable are set to 1.
	density=1 // A ray of light that hits you like a brick wall.
	Grabbable=0
	var
		tmp
			maxSteps=30 // maxSteps a ranged object can take before it gets deleted.
					// This value is usually assigned upon using the attack, 60 is a default value.
		Damage
		Explosive=0
		Shockwave=0
		Piercer=0
		Paralysis=0
		Sokidan=0
		Beam=0
		Shrapnel=0 //Shrapnel from explosions if any
		Deflectable=1
		Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
		Offense=1
		Special=0
		Radius=0
		Bullet=0
		Stagger=0
		Slowing=0
		DoNotTrack=0
		MakesFire=0
		CausesBurns=0
		ChainTrigger=0
		Hellzone=0
		InUse=0
		IceGrips=0
		HeatSeeking=0
		tmp/mob/Belongs_To
		tmp/mob/Target


	proc/AttackDamage()
		if(!Belongs_To) del(src)
		for(var/mob/P in oview(Radius,src))
			if(P!=Belongs_To)
				spawn()Bump(P)
		for(var/obj/O in oview(Radius,src)) if(O!=src)
			if(istype(O,/obj/ranged))
				var/obj/ranged/R=O
				if(R.Belongs_To==src.Belongs_To) continue
			spawn()Bump(O)
		for(var/turf/T in oview(Radius,src))
			if(T.density)
				spawn()Bump(T)
	Move()
		if(!Belongs_To){del(src);return}
		else
			if(Belongs_To.Target)Target=Belongs_To.Target
			if(!Sokidan) maxSteps --
			if(!maxSteps){del(src);return}
			if(src.x<2||src.x>=(world.maxx-1)||src.y<2||src.y>=(world.maxy-1))
				del(src)
				return
			if(!istype(src,/obj/ranged/Beam)&&!DoNotTrack&&!Radius)
				if(HeatSeeking&&Belongs_To.Target&&get_dist(src,Belongs_To.Target)<9&&Belongs_To!=Belongs_To.Target&&z==Belongs_To.Target.z)
					if(prob(5-Shockwave*2))
						walk(src,get_dir(src,Target),1)
						maxSteps-=8
						return
				if(Belongs_To.HasEnergyMarksmanship&&Belongs_To.Target&&get_dist(src,Belongs_To.Target)<9&&Belongs_To!=Belongs_To.Target&&z==Belongs_To.Target.z)
					if(prob(5-Shockwave*2))
						walk(src,get_dir(src,Target),1)
						maxSteps-=8
						return
				if(Belongs_To.Target&&get_dist(src,Belongs_To.Target)<9&&Belongs_To!=Belongs_To.Target&&z==Belongs_To.Target.z)
					if(prob(3-Shockwave*2))
						walk(src,get_dir(src,Target),1)
						maxSteps-=8
						return
			if(Radius&&InUse) src.AttackDamage()
			return ..()


	New()
		spawn(1) InUse=1
		spawn(300) if(src) del(src)
	Del()
	//	view(src)<<"Pooling [src]"
		if(Hellzone)
			ExplosionEffect(src)
			var/exprange = range(Explosive,src)
			for(var/turf/A in exprange) if(prob(95))
				ExplosionEffect(A)
				for(var/mob/B in A)
					var/didShield=0
					for(var/obj/items/Force_Field/S in B) if(S.Level>0)
						S.Level = max(0, (S.Level - 1000*((Belongs_To.Pow/B.End)*(Belongs_To.BP/B.BP)*Ki_Power))) // damage
						S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
						didShield=1
					var/Mult=1
					if(B.Shielding||didShield) Mult=0.7
					if(B.icon_state == "Flight") if(prob(25))
						view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
						B.Flight_Land()
					if(!B.Flying)
						B.TakeDamage(Belongs_To, 8*((Belongs_To.Pow/B.End)*(Belongs_To.BP/B.BP)*Mult*Ki_Power), "Explosion")
		if(istype(src,/obj/ranged/Beam)) pool("Beams",src)
		else if(istype(src,/obj/ranged/Blast/SpiritBall/Genki_Dama)) pool("Genki_Dama",src)
		else if(istype(src,/obj/ranged/Blast/SpiritBall)) pool("SpiritBall",src)
		else pool("Blasts",src)

	pooled()
		walk(src,0)
		loc=null
		Belongs_To=null
		Target=null
		layer=MOB_LAYER+1
		density=1 // A ray of light that hits you like a brick wall.
		maxSteps=30 // maxSteps a ranged object can take before it gets deleted.
		Damage=1
		Explosive=0
		Shockwave=0
		Piercer=0
		MakesFire=0
		Paralysis=0
		ChainTrigger=0
		CausesBurns=0
		Sokidan=0
		Hellzone=0
		Shrapnel=0 //Shrapnel from explosions if any
		Deflectable=1
		Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
		Offense=1
		Special=0
		Radius=0
		Bullet=0
		Stagger=0
		Slowing=0
		DoNotTrack=0
		HeatSeeking=0
		pixel_x=0
		pixel_y=0
		IceGrips=0
		InUse=0
		name="Blast"
		filters=list()
		animate(src,transform = null,alpha=initial(alpha),time=0)
		..()
	unpooled()
		maxSteps=30
		..()
		spawn(1)
			var/WasMade
			if(Belongs_To)
				WasMade=Belongs_To
				InUse=1
				if(Belongs_To.client)flick("Blast",Belongs_To)
				if(Belongs_To.Target)Target=Belongs_To:Target
				if(HeatSeeking&&prob(30)) Shockwave=0
				if(Belongs_To.HasSmolder) CausesBurns=1
			spawn(300) if(z&&WasMade==Belongs_To) del(src)


	Bump(atom/Z)
		// Please remember that returning TRUE or FALSE will determine if the Bump() proc of either Beam or Blast will also be allowed to run whatever code it has.
		// Returning false means it ends here. Returning TRUE means the child Bump() procs are allowed to execute their code as well.
		if(Z)
			if(Z.type==type&&Z.dir==dir) // If two blasts/beams are bumping but going in the same direction.
				density=0 // Then set their density to 0, allowing for combined beams and attacks.
				spawn(1) if(src) density=1
				return TRUE

			if(ismob(Z)) // They're a mob!
				var/mob/A=Z
				if(A==Belongs_To)
					density=0
					spawn() density=1
					return TRUE
				if(ghostDens_check(A)) return FALSE
				if(A.insideTank) return FALSE
				// They have KI-Absorb. Omnomnom.
/*
				if(A.Blast_Absorb&&A.Ki<A.MaxKi*2&&(A.dir==turn(dir,180)||A.Blast_Absorb>=2)&&A.KOd==0)
					A.Ki+=A.MaxKi*0.01
					A.Blast_Absorb_Graphics()
					del(src)
					return TRUE*/
				return TRUE
			if(istype(Z,/Icon_Obj)) return FALSE
			if(isobj(Z)) // It's an object, but we have no special checks that overrule all ranged attacks (yet). And so we return TRUE as a default.
				return TRUE
			if(isturf(Z))
				// assuming they're stupid enough to fire a beam at a wall/door point blank, then let's treat them to an explosion.
				//if(usr)
				//	if(get_dist(usr,Z)<2) // if there is an object in the adjacent tile they're facing
				//		Explode(forced=TRUE) // Explosions far too big, so disabled for now.
				return TRUE
/*
Procs applicable to all ranged skills.
*/
	//Explosion for skills blast moves here
	proc/Explode() if(Explosive)

		DamageEnviroment(src,1)
//		src.update_light()
		for(var/atom/X in view(Explosive,src))
			if(X.Flammable)
				X.Burning = 1
				X.Burn(X.Health)
		if(Damage>0)
			for(var/mob/A in view(Explosive,src))
				if(A.afk==0&&!A.RPMode)
					var/CanShield
					for(var/obj/items/Force_Field/S in A) if(S.Level>0)
						CanShield=1
						S.Level = max(0, (S.Level - 10*(Damage/(A.BP*A.End))) ) // damage
						S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
					if(!A.Shielding&&!CanShield)
						if(prob(50)) A.Shockwave_Knockback(Explosive,loc)
						if(isnum(A.Health)) A.TakeDamage(Belongs_To, 0.5+(Damage/(A.BP*A.End)), "[src]","energy")
			for(var/obj/A in view(Explosive,src)) if(A!=src&&!istype(A,/obj/ranged/Blast))
				if(isnum(A.Health))
					A.Health = max(0, (A.Health - Damage) )
					if(isnum(A.Health)&&A.Health<=0)
						DeleteSaveItem(A)
						del(A)

			for(var/turf/A in view(Explosive,src)) if(prob(70))
				if(prob(80)) ExplosionEffect(A)
				if(isnum(A.Health)) A.TakeDamage(src, Power*(Damage/Power)*0.001, "Explosion")//A.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)
				if(usr!=0) A.Destroy(usr,usr.key)
				else A.Destroy("Unknown","Unknown")
				if(Belongs_To.HasSmolder) new/obj/Hazard/Burning_Embers(A)
				else if(MakesFire)new/obj/Hazard/Burning_Embers(A)

			while(prob(80)&&Shrapnel)
				var/obj/ranged/Blast/B=new(locate(x,y,z))
				B.Damage=(Damage*0.8)+1
				B.Belongs_To=Belongs_To
				B.icon='Boulder22.dmi'
				B.pixel_x=-4
				B.pixel_y=-4
				animate(B, transform = matrix()*0.5, time = 0)
				if(prob(50)) B.Shrapnel=1
				if(prob(10)&&Explosive) B.Explosive=Explosive-1
				B.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
				walk(B,B.dir,rand(1,2))

//

obj/ranged/Blast
	density=1
	New()
		spawn(200) del(src)

	Bump(mob/A)
		if(istype(A,/turf/atom/TestWall/))
			DamageEnviroment(A,0)

		if(Belongs_To)
			if(isobj(A)||isturf(A))
				if(isnum(A.Health))
					if(isturf(A))
						if(istype(A,/turf/Upgradeable/Walls/))
							if(src.Belongs_To)
								var/mob/M = src.Belongs_To
								if(M.Destroy_Walls) A.TakeDamage(src, (Damage), "Blast","energy")//A.Health = -100
						else A.TakeDamage(src, 50, "Blast","energy")
					else
						if(istype(A,/obj/TrainingEq/Punchometer))
							if(ismob(Belongs_To))A.TakeDamage(src, (Damage)/(A.BP*A.End), "Blast","energy")//A.Health-=Damage/Belongs_To.Pow
						else
							if(ismob(Belongs_To))A.TakeDamage(src, (Damage)/TrueBPCap, "Blast","energy")//A.Health-=Damage/Belongs_To.Pow
							else A.TakeDamage(src, 50, "Blast","energy")//A.Health-=Damage/2000
				if(isnum(A.Health)&&A.Health<=0&&!istype(A,/obj/ranged/Blast))
					//LOG SHIPS
					if(istype(A,/obj/Ships))
						Belongs_To.saveToLog("| [Belongs_To.client.address ? (Belongs_To.client.address) : "IP not found"] | ([Belongs_To.x], [Belongs_To.y], [Belongs_To.z]) | [key_name(Belongs_To)] has destroyed [A].\n")
					if(isturf(A))
						var/turf/B=A
						if(!usr||usr==0||isnull(usr)) B.Destroy("Unknown","Unknown")
						else
							B.Destroy(usr,usr.key)
					else if(!istype(A,/Icon_Obj))
						SmallCrater(A)
						del(A)
				if(istype(A,/obj/ranged/Blast))
					var/obj/ranged/Blast/J=A
					if(J.Damage<Damage)
						del(A)
				Explode(Belongs_To, Damage)
				if(!Piercer)
					del(src)


			//If what we hit is a Mob
			else if(ismob(A))
				//We calculate the dmg
//				world<<"src=[src]"
				var/Damage=DamageCalculator(Belongs_To,A,src)
//				world<<"src.DMGSOURCE_POW=[src.DMGSOURCE_POW]"
//				world<<"Damage=[Damage]"
				if(A.afk)
					del(src)
				var/Life_Decrease=1*(Damage/(A.Base*A.Body*A.End))
				var/shlded=0
				if(Deflectable&&A.Shielding)
					A.Ki = max(0, A.Ki-5)
					shlded=1//ki drain
				if(Belongs_To&&Belongs_To.HasEnergyMarksmanship) if(prob(20)&&A.Precognition) if(A.icon_state in list("","Flight"))
					step(A,turn(dir,pick(-45,45)))
					return FALSE
				else if(prob(50))if(A.Precognition||A.HasPrecognition) if(A.icon_state in list("","Flight"))
					step(A,turn(dir,pick(-45,45)))
					return FALSE


				//We calculate the hit chance here
				var/Hit_Chance=KiAccuracyFormula(src,Belongs_To,A,src)  														 //(60*((((src.Power/global.Ki_Power))*src.Offense)/(A.BP*A.Def)))+(Belongs_To.HasEnergyMarksmanship*15)+(Belongs_To.HasBullsEye*2.5)//30%

				if(prob(Hit_Chance)||!Deflectable||A.KOd) //||A.Frozen)
					if(shlded)
						Damage = Damage * 0.7
					else if(!prob(Hit_Chance)||prob(20*A.Blocking))
						if(prob(10))
							ShockwaveScale(A,Belongs_To.BP)
						Damage = Damage * 0.7

					if(A)
						if(isnum(A.Health)&&A.Health>=1)
							Explode(Belongs_To, Damage)
							A.TakeDamage(Belongs_To, Damage, "[src]","energy")
							A.LastHitter = Belongs_To																		//Read the hit him with an autoattack and save it in LastHitter
							A.HitterListCheck(Belongs_To)																	//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
						else if(isnum(A.Health)&&A.Health<=0)
							if(!A.KOd)
								A.KO(Belongs_To)
								return FALSE
							else
								if(!A.client)
									A.Death(Belongs_To)
									return FALSE
								else
									A.Life-=Life_Decrease
									if(A.Life<=0)
										if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) if(Belongs_To.Lethality) A.Dead=1
										if(Belongs_To.Lethality) A.Death(Belongs_To)
										return FALSE
						if(CausesBurns&&prob(50)) A.BurnDamage(Belongs_To,"Smolder Burn",Damage*0.1)
						if(ChainTrigger) A.BleedDamage(src,"Echoing Slash Bleed",Damage*0.5)
						if(Slowing)if(A) Slow(A,5,Slowing)
						if(IceGrips) A.GripOfIce()
						if(Paralysis) if(A) Stun(A,Paralysis)
						if(Stagger) if(A)
							A.Flight_Land()
							Stagger(A,Stagger)
						if(A&&src&&A.dir==dir&&A.KOd&&locate(/BodyPart/Tail) in A)
							for(var/BodyPart/Tail/T in A)
								A.overlays-=T
								del(T)
							view(A)<<"[A]'s tail is blasted off!"
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off!\n")
							A.Tail_Remove()
							A.Critical_Tail = 1
							for(var/BodyPart/Tail/T in A)
								T.Health=0
								T.Status="Missing"
						if(prob(Shockwave*50)) A.Shockwave_Knockback(Shockwave,Belongs_To.loc)
				else
					dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
					if(A.client) flick("Attack",A)
					loc=A.loc
					src.HeatSeeking=0
					walk(src,dir)
					A.CombatOut("You deflected [Belongs_To]'s [src]!")
					Belongs_To.CombatOut("[A] deflected [src]!")
					return FALSE
				if(!Piercer) del(src)
			..()


