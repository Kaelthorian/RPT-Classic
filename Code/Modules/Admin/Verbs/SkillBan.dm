Skill/var/Banned
var/list/SkillBanned = new()

mob/Admin1/verb
	Ban_Skill()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

		var/Skill/Ob = input(src,"Name of the skill","Pick what you want to Ban") as text
		if(!Ob)return
		SkillBanned+=Ob
		usr<<"Skill added to the ban list [Ob]"
		log_admin("[key_name(usr)] banned [Ob] from the game.")
		var/savefile/S=new("Data/SkillBanned.bdb")
		S["SkillBanned"]<<SkillBanned

	Remove_Ban_Skill()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

		var/Skill/Ob = input(src,"Name of the skill","Pick what you want to unBan") as text
		if(!Ob)return

		for(var/T in SkillBanned)
			if(Ob == T)
				SkillBanned.Remove(Ob)
				log_admin("[key_name(usr)] unbanned [Ob] from the game.")
				var/savefile/S=new("Data/SkillBanned.bdb")
				S["SkillBanned"]<<SkillBanned

	Check_Ban_Skill()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/S in SkillBanned)
			usr<<"Name [S]"


