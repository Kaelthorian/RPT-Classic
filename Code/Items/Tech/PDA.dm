obj/items/PDA
	icon='Cell Phone.dmi'
	desc="This can be used to store information."

	var/notes={"<html>
<head><title>Notes</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
</body><html>"}
	verb/Name()
		var/n=input("Naming PDA") as text
		if(n&&n!=" ") name=n
	verb/View()
		usr<<browse(notes,"window= ;size=700x600")
	verb/Input()
		notes=input(usr,"Notes","Notes",notes) as message
/*		notes=sanitize_n(notes)
		if( length(notes) > 800 )
			debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] client: [usr.client ? usr.client : "null"] message([length(notes)]): [notes]"
*/