mob/proc/getPortrait() return {"
						<html>
						<body style="background-color:#F3EADB;">
						<img src="[ImageLink]" width="192" height="266"> </center>
						</body>
						</html>
						"}
mob/verb/Check_Profile(mob/M in view(usr,10))
	set category=null
	set popup_menu = 0
	for(var/obj/items/Disguise/A in M) if(A.suffix)
		usr<<"You can not see past their disguise."
		return
	winshow(usr.client,"CharacterProfile",1)
	winset(src.client,"cname","text=\"[M.name]\"")
	var/properAge = "Infant"
	if(M.Age>1) properAge="Young"
	if(M.Age==M.InclineAge||M.Age>M.InclineAge) properAge="Prime"
	if(M.Decline-M.Age<10) properAge="Mature"
	if(M.Decline-M.Age<3) properAge="Old"
	if(M.Age>M.Decline) properAge="Elderly"


	if(M.FakeAge)winset(src.client,"cage","text=\"[M.FakeAge]\"")
	else winset(src.client,"cage","text=\"[properAge]\"")

	if(M.FakeGender) winset(src.client,"cgender","text=\"[M.FakeGender]\"")
	else if(M.ShowGender) winset(src.client,"cgender","text=\"[uppertext(M.gender)]\"")
	else winset(src.client,"cgender","text=\"???\"")

/*
	if(M.ShowSize) winset(src.client,"cbody","text=\"[M.Size]\"")
	else winset(src.client,"cbody","text=\"[M.Size]\"")

*/

	if(M.FakeHeight) winset(src.client,"cheight","text=\"[M.FakeHeight] inches\"")
	else winset(src.client,"cheight","text=\"[M.Height] inches\"")
	if(M.FakeWeight) winset(src.client,"cweight","text=\"[M.FakeWeight] lbs\"")
	else winset(src.client,"cweight","text=\"[M.BodyWeight] lbs\"")
	if(M.FakeBackstory) winset(src.client,"cbackstory","text=\"[M.FakeBackstory]\"")
	else winset(src.client,"cbackstory","text=\"[M.Backstory]\"")
	if(M.FakePortrait) src << output(M.FakePortrait, "cportrait")
	else src << output(M.Portrait, "cportrait")

mob/verb/Profile_Options()
	var/PP=input("Change what option?","Profile Options") in list("Portrait","Description","Height","Weight","Toggle Gender","Cancel")
	switch(PP)
		if("Description") Backstory()
		if("Height") ChangeHeight()
		if("Weight") ChangeWeight()
		if("Portrait") ChangeImage()
		if("Toggle Gender")
			ShowGender=!ShowGender
			usr<<"Show Gender [ShowGender]"

mob/verb
	Backstory()
		set instant = 1
		if((winget(client,"Backstory","is-visible")=="true"))
			winshow(client,"Backstory",0)
			return
		winshow(client,"Backstory",1)
		winset(client, "Backstory.emoteinput", "focus=true")


	BackstoryS()
		set hidden = 1
		var/msg=winget(usr, "Backstory.emoteinput", "text")
		msg = copytext(sanitize_n(msg), 1, MAX_PROFILE_LEN)
		usr.Backstory=("[msg]")
		winshow(client,"Backstory",0)
		winset(usr.client, "Backstory.emoteinput", "text=")

	ChangeHeight()
		set hidden=1
		usr.Height = input("Please select your height (in inches). This will output in your profile") as num

	ChangeWeight()
		set hidden=1
		usr.BodyWeight = input("Please select your weight (in pounds). This will output in your profile") as num

	ChangeImage()
		set hidden=1
		usr.ImageLink = input("Please input a link to the image you would like to use for your profile.  Image will be sized to fit width=165 and height=250") as text
//		getPortrait()
		usr.Portrait= {"
						<html>
						<body style="background-color:#C6D5D7;">
						<img src="[ImageLink]"width="165" height="250"></center>
						</body>
						</html>
						"}
// width="200" height="500" 						<body style="background-color:#F3EADB;">