
atom
	proc
		Burn(var/H)
			H=Health
			if(src.Burning)
				for(var/atom/A in range(0,src))
					if(A.Burning) if(A != src)
						src.Burning = 0
						return
				if(isobj(src))
					src.overlays -= 'fire obj.dmi'
					src.overlays -= 'large fire.dmi'
					if(prob(!H)) src.overlays += 'fire obj.dmi'
					else src.overlays += 'large fire.dmi'
//					if(Smokes < 100) SmokeEffect(src)
				if(isturf(src))
					src.overlays -= 'fire turf.dmi'
					src.overlays -= 'large fire.dmi'
					src.overlays += 'fire turf.dmi'
//					if(Smokes < 100) SmokeEffect(src)

				if(H)
					var/dmg = H / 80
					src.TakeDamage(src, dmg, "Fire")
				if(src.Health <= 5) // Mumit attempt to fix infinite fire
					if(isobj(src))
						Ash(src)
						DeleteSaveItem(src)
						del(src)
					if(isturf(src))
						src.overlays -= 'fire turf.dmi'
						new /turf/Terrain/Ground/Ground17(src)
			spawn(5) if(src) src.Burn(H)
