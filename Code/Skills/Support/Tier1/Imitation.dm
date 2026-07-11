Skill/Support/Imitation

	desc="You can use this on someone to imitate them in almost every way, so much so that you may be confused with them. You can hit it again to stop imitating."
	var/imitating
	var/imitatorname
	var/list/imitatoroverlays=new
	var/imitatoricon
	var/imitatetext
	verb/Imitate()
		set category="Skills"
		if(usr.RPMode) return
		if(!imitating)
			imitating=1
			imitatorname=usr.name
			imitatoroverlays.Add(usr.overlays)
			imitatoricon=usr.icon
			var/list/People=new
			for(var/mob/A in oview(usr,10)) People.Add(A)
			var/Choice=input("Imitate who?") in People
			for(var/mob/A in People) if(A==Choice)
				usr.icon=A.icon
				usr.overlays.Remove(usr.overlays)
				usr.overlays.Add(A.overlays)
				usr.AFKRemove()
				usr.name=A.name
//				usr.Signature_True = usr.Signature
//				usr.Signature = A.Signature
				imitatetext=usr.TextColor
				usr.TextColor=A.TextColor
				var/properAge = "Infant"
				if(A.Age>1) properAge="Young"
				if(A.Age==A.InclineAge||A.Age>A.InclineAge) properAge="Prime"
				if(A.Decline-A.Age<15) properAge="Mature"
				if(A.Decline-A.Age<5) properAge="Old"
				if(A.Age>A.Decline) properAge="Elderly"
				usr.FakeAge=properAge
				usr.FakeGender=uppertext(A.gender)
				usr.FakePortrait=A.Portrait
				if(!A.ShowGender) usr.FakeGender="???"
				usr.FakeHeight=A.Height
				usr.FakeWeight=A.BodyWeight
				usr.FakeBackstory=A.Backstory

				imitating=1
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] imitates [key_name(A)].\n")
		else usr.ImitationCancel()

mob/proc/ImitateRevert()for(var/Skill/Support/Imitation/II in src) if(II.imitating)
	II.imitating=0
	name=II.imitatorname
	overlays.Remove(overlays)
	overlays.Add(II.imitatoroverlays)
	icon=II.imitatoricon
//	Signature = Signature_True
	TextColor=II.imitatetext
	II.imitatoroverlays.Remove(II.imitatoroverlays)
	FakeAge=null
	FakeGender=null
	FakePortrait=null
	FakeHeight=null
	FakeWeight=null
	FakeBackstory=null
//	Signature_True=null
	saveToLog("| | ([x], [y], [z]) | [key_name(src)] deactivates imitate.\n")
mob/proc/ImitationCancel() for(var/Skill/Support/Imitation/II in src) if(II.imitating) ImitateRevert()