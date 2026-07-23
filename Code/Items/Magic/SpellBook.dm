obj/items/Spell_Book
	name="Spell Book"
	var/ManaMult=1
	var/ExtraManaMult=0
	/*icon='Magic Items.dmi'
	icon_state = "spell book"*/
	icon='enchantmenticons.dmi'
	icon_state="BoTS"

	desc="This is a magical book full of spells. Keeping it on you while drawing on ambient forces will increase the rate you attain mana."
	New()
		name="Level [ManaMult] Spell Book (+[ExtraManaMult])"
		..()
	verb/Enhance()
		set src in view(1)
		if(usr.Magic_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=((100000/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
		var/Max_Upgrade=(A.Value/Cost)+ManaMult
		if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
		if(ManaMult>=Max_Upgrade)
			usr<<"It is already upgraded beyond what you can manage."
			return
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<ManaMult) return
		Cost*=Upgrade-ManaMult
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		ManaMult=Upgrade
		name="Level [ManaMult] Spell Book (+[ExtraManaMult])"
		//desc="Level [ManaMult] Spell Book"
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src