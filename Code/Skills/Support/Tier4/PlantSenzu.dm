Skill/Support/PlantSenzu
	UB1="Bestial Wrath"
	UB2="Fungal Plague"
	desc="This is how you grow senzu beans. You get 1.5 beans a year.."

	var/Uses=0
	var/MaxUses=1
	verb/Plant_Senzu()
		set category="Other"
		MaxUses=round(Year*1.5)-(TeachYear-7)
		if(Uses>=MaxUses)
			usr<<"You must wait to use this."
			return
		usr<<"[MaxUses-Uses] remaining seeds..."
		var/obj/items/Senzu/A=new
		Uses++
		A.loc=usr.loc



obj/items/Senzu
	icon='Senzu.dmi'
	name="Senzu"
	desc="Eating this will temporarily increase Regeneration by 3x butIt will decrease over time , will increase Willpower by +60 and fix all your broken/maimed limbs."
	var/Increase=6
	var/division=1
	var/HealPower=60
	Flammable = 1

	New()
		pixel_x+=rand(-16,16)
		pixel_y+=rand(-16,16)

	verb
		Eat()
			for(var/BodyPart/Throat/A in usr)
				if(A.Status == "Broken"||A.Status =="Missing"||A.Status =="Maimed")
					usr<<"You can't eat with your throat like that!"
					return
			if(usr.KOd==0)
				if(usr.LastUsedSenzu==Year)
					usr<<"You can only eat one of these a year."
					return
				usr.LastUsedSenzu=Year
				if(usr.Senzu<6) usr.Senzu+=Increase
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
				view(usr)<<"[usr] eats a [src]"
				usr.Calm()
				usr.Willpower+= HealPower
				for(var/BodyPart/P in usr)
					usr.Injure_Heal(200,P,1)
				if(usr.Willpower>usr.MaxWillpower)usr.Willpower=usr.MaxWillpower
				DeleteSaveItem(src)
				spawn del(src)
			else usr<<"You can't eat a Senzu while unconscious"
		Throw(mob/M in oview(usr))
			view(usr)<<"[usr] throws a Senzu to [M]"
			missile('Senzu.dmi',usr,M)
			sleep(3)
			view(usr)<<"[M] catches the Senzu"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
			Move(M)
		Use_on(mob/M in oview(1))
			if(M.KOd)
				for(var/BodyPart/Throat/A in M)
					if(A.Status == "Broken"||A.Status =="Missing"||A.Status =="Maimed")
						M<<"You can't eat with your throat like that!"
						return
				if(M.LastUsedSenzu==Year)
					usr<<"You can only eat one of these a year and they have already."
					return
				M.LastUsedSenzu=Year
				view(usr)<<"[usr] gives a [src] to [M]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
				M.icon_state=""
				if(M.Senzu<6) M.Senzu+=Increase
				M.Willpower+=15
				for(var/BodyPart/P in M)
					M.Injure_Heal(200,P,1)
				if(M.Willpower>M.MaxWillpower)M.Willpower=M.MaxWillpower
				M.Un_KO()
				spawn del(src)
			else usr<<"You can only use this on an unconscious person."
		Split()
			if(Increase<=1)
				usr<<"This is too small to split any further"
				return
			view(usr)<<"[usr] splits a [src] in half"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] splits a [src] in half.\n")
			var/amount=2
			while(amount)
				var/obj/items/Senzu/A=new
				A.HealPower=HealPower*0.5
				A.division=division*2
				A.Increase=Increase*0.5
				A.name="1/[A.division] Senzu"
				usr.contents+=A
				amount-=1
			del(src)