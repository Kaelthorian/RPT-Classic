Skill/Buff/Giant_Mode
	RequiresApproval = 0
	BP=1.45
	End=1.2
	Str=1.3
	Pow=1
	Anger=1

	var/tmp/Clicks=0
	buffon="becomes a Giant!"
	buffoff="shrinks to normal size."
//	var/ICON
//	var/list/OVERLAYS=null
	icon='Judgement_fitted.dmi'

	layer=MOB_LAYER+1
	/*GetDescription(mob/Getter)
		if(Getter.Race=="Namekian") return "Using this ability will increase your BP by [BP]x, End by [End]x and Str by [Str]x."
		else return "Using this ability will increase your BP by [BP]x, End by [End]x, Str by [Str]x and Max Anger by [Anger]x."
		..()*/
	verb/Giant_Mode()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		desc="Giant Mode , BP x [BP] , Endurance x [End], Strenght x [Str]"
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)

//2.7-2.8