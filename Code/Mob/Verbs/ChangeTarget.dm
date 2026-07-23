mob/var/list/tmp/TargetList =new

mob/verb/Change_Target()
	set category= "Team"



mob/verb/AddToTargetList()
	set category= "Team"
	var/mob/A=input(usr,"Choose someone to add to your target list.") as mob in oviewers(20)
	TargetList.Add("[A.name]")
	usr<<"[A.name] is now in your target list."

mob/verb/RemoveFromTargetList()
	set category= "Team"
	var/mob/A=input(usr,"Choose someone to remove from your target list.") in TargetList
	TargetList.Remove("[A.name]")
	usr<<"[A.name] is no longer in your target list."

mob/verb/Check_Target_list()
	set category = "Team"
	for(var/B in TargetList)
		usr<<"[B]"