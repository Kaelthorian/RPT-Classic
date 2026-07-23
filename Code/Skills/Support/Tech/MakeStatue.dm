Skill/Technology/MakeStatue

	desc="Using this on someone will make a statue of them."
	verb/Make_Statue(mob/M in view(10))
		set category="Other"
		if(!usr.Confirm("Make a statue of [M]?")) return
		if(usr.Rank!="Judge")
			var/Cost = 15000000
			var/T=input("Use resources or mana to construct the statue of [M]") in list("Mana","Resources","Cancel")
			if(T=="Mana")
				var/Actual = round(initial(Cost)/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets)))
				usr << "Base cost for this skill is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				for(var/obj/Mana/MM in usr)
					if(MM.Value > Actual)
						MM.Value-=Actual
					else
						usr<<"Not enough mana"
						return
			if(T=="Resources")
				var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
				usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
				for(var/obj/Resources/MM in usr)
					if(MM.Value > Actual)
						MM.Value-=Actual
					else
						usr<<"Not enough resources"
						return
			if(T=="Cancel") return
		var/Big=0
		if(usr.Confirm("Make it a large statue?")) Big=1
		var/obj/items/Statue/S = new
		S.BigStatue=Big
		S.icon=M.icon
		S.overlays+=M.overlays
		S.color=list(0.3,0.3,0.3, 0.59,0.59,0.59, 0.11,0.11,0.11, 0,0,0)
		var/IS=input("Which icon state would you like to use?") in list("None","Meditate","Train","KO")
		if(IS!="None") S.icon_state=IS
		if(Big) animate(S, transform = matrix()*2, time = 0)
		S.loc=usr.loc
		S.name="[M] Statue"
		S.Builder="[usr.real_name]"
		//usr.color=list(rr,rg,rb, gr,gg,gb, br,bg,bb, cr,cg,cb)


icon
	proc/GrayScale()
		MapColors(0.3,0.3,0.3, 0.59,0.59,0.59, 0.11,0.11,0.11, 0,0,0)