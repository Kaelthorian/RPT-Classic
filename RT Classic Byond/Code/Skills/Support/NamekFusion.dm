Skill/Support/NamekianFusion

	RequiresApproval=1

	desc="You can use this to fuse with another person of the same race. You will die from it, but the \
	other person will gain a very large power boost. If the person was your counterpart, it breaks that \
	bond forever. (You will not gain extra from fusing with your counterpart.)"
	//var/list/Fused=new
	var/tmp/Fusing
	verb/Namekian_Fusion()
		set category="Other"
		set src=usr.contents
		if(usr.RPMode) return
		if(Fusing) return
		if(usr.Dead) return
		if(usr.SaveAge<5)
			usr<<"Your save must be five years old before you can fuse."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.Race==usr.Race) if(usr.Confirm("Fuse with [A]?"))
			if(A.Fusions>=2)
				usr<<"You cannot fuse with this person, they have already fused too many times."
				return
			if(A.client) if(A.client.address==usr.client.address||!A.client||A.Dead||A.Race!=usr.Race)
				usr<<"You cannot fuse with this person"
				return
			if(usr.Offspring)if(findtext(usr.Parents,A.client.key))
				usr<<"You cannot fuse with your parent. (They may fuse into you though.)"
				return
			Fusing=1
			var/Choice=alert(A,"[usr] wants to fuse with you and give you their power, do you accept?","","No","Yes")
			switch(Choice)
				if("Yes")
					A.RemoveBuffs()
					usr.RemoveBuffs()
					view(usr)<<"[usr] fuses with [A]!"
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]")
					alertAdmins("[key_name(usr)] used Fusion with [key_name(A)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]\n")
					A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] fused via Fusion with [key_name(usr)].\n")
					A.Base+=(usr.Base/3)
					A.BaseMaxKi+=(usr.BaseMaxKi/3)
					A.BPMod*=1.1
					A.Decline+=10
					A.Fusions++
					A.Fusions+=usr.Fusions
					if(A.Fusions>=3)A.Fusions=3
					//Fused.Add(A.key)
					if(usr.Counterpart=="[A]([A.key])")
						usr.Counterpart=null
						A.Counterpart=null
					spawn
						usr.Absorbed=1
						usr.Death("sacrificed their life through fusion")
						//usr.Save()
						usr.Reincarnation()
				else view(A)<<"[A] declines [usr]'s offer to fuse"
			Fusing=0
