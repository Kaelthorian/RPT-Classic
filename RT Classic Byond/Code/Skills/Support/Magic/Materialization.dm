Skill/Support/Materialization


	desc="You can use this to materialize clothing that has different weights. The more energy you get the higher weight you can make."
	verb/Materialize()
		set category="Other"
		switch(input("") in list("Check Lift","Make Weights","Cancel"))
			if("Check Lift")
				var/list/Mobs=new
				for(var/mob/B in view(usr)) Mobs+=B
				var/mob/A=input("Who?") in Mobs as mob|null
				alert("[A] can lift [Commas((A.StrMod+A.EndMod)*2)] pounds. You make up to [Commas(usr.MaxKi*usr.KiMod)]")  //Was .5
				if(usr.Confirm("Make [A] weights? ([Commas(((A.StrMod+A.EndMod)*2)*5*(1-(0.15*usr.HasDeepPockets)))] Mana)"))
					var/Cost=((A.StrMod+A.EndMod)*2)*5*(1-(0.15*usr.HasDeepPockets))
					var/obj/Mana/AA
					for(var/obj/Mana/B in usr) AA=B
					if(AA.Value<Cost)
						usr<<"You do not have enough mana."
						return
					AA.Value-=Cost
					var/WM=(A.StrMod+A.EndMod)*2
					var/WR
					if(WM>usr.MaxKi*usr.KiMod)
						WR=WM-(usr.MaxKi*usr.KiMod)
						WM=usr.MaxKi*usr.KiMod
					WM=round(WM)
					var/obj/items/Weights/WA=new(get_step(usr,usr.dir))
					WA.Weight=round(WM)
					WA.name="[round(WA.Weight)]lb Weights ([A])"
					WA.icon='Clothes_Wristband.dmi'
					if(WR)
						WM=WR
						WR=0
						if(WM>usr.MaxKi*usr.KiMod)
							WR=WM-(usr.MaxKi*usr.KiMod)
							WM=usr.MaxKi*usr.KiMod
						WM=round(WM)
						var/obj/items/Weights/WA2=new(get_step(usr,usr.dir))
						WA2.Weight=round(WM)
						WA2.name="[round(WA2.Weight)]lb Weights ([A])"
						WA2.icon='Clothes_Wristband.dmi'
						if(WR)
							WM=WR
							WR=0
							if(WM>usr.MaxKi*usr.KiMod)
								WR=WM-(usr.MaxKi*usr.KiMod)
								WM=usr.MaxKi*usr.KiMod
							WM=round(WM)
							var/obj/items/Weights/WA3=new(get_step(usr,usr.dir))
							WA3.Weight=round(WM)
							WA3.name="[round(WA3.Weight)]lb Weights ([A])"
							WA3.icon='Clothes_Wristband.dmi'
			if("Make Weights")
				var/Weights=input("How heavy? Between 1 and [Commas(usr.MaxKi*usr.KiMod)] pounds. You can lift [Commas((usr.StrMod+usr.EndMod)*2)] pounds (Costs [5*(1-(0.15*usr.HasDeepPockets))] mana per pound.)") as num
				if(!Weights) return
				if(Weights>usr.MaxKi*usr.KiMod) Weights=usr.MaxKi*usr.KiMod
				if(Weights<1) Weights=1
				Weights=round(Weights)
				var/Cost=5*Weights*(1-(0.15*usr.HasDeepPockets))
				var/obj/Mana/AA
				for(var/obj/Mana/B in usr) AA=B
				if(AA.Value<Cost)
					usr<<"You do not have enough mana."
					return
				AA.Value-=Cost
				var/obj/items/Weights/A=new(get_step(usr,usr.dir))
				A.Weight=round(Weights)
				A.name="[round(A.Weight)]lb Weights"
				var/style=pick("Cape","Shirt","Wristbands","Scarf","Turban")
				switch(style)
					if("Cape") A.icon='Clothes_Cape.dmi'
					if("Shirt") A.icon='Clothes_ShortSleeveShirt.dmi'
					if("Wristbands") A.icon='Clothes_Wristband.dmi'
					if("Scarf") A.icon='Clothes_NamekianScarf.dmi'
					if("Turban") A.icon='Clothes_Turban.dmi'
				var/RGB=input("") as color|null
				if(RGB) A.icon+=RGB
				hearers(10,usr) << sound('Pop.wav',volume=20)
			if("Make Sword")
				var/obj/items/Sword/A=new
				A.Health+=usr.Base*usr.KiMod
				A.desc="[Commas(A.Health)] BP Sword"
				A.loc=get_step(usr,usr.dir)
				hearers(10,usr) << sound('Pop.wav',volume=20)
			if("Make Armor")
				var/obj/items/Armor/A=new
				A.Health+=100
				A.desc="[Commas(A.Health)] Durability Armor"
				A.loc=get_step(usr,usr.dir)
				hearers(10,usr) << sound('Pop.wav',volume=20)