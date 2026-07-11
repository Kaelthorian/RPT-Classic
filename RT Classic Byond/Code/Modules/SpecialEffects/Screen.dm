mob/var/HUDOn=0
mob/verb/Show_HUD()
	set category=null
	if(!HUDOn)
		spawn() winshow(usr.client,"CharaBox",1)
		HUDOn=1
	else
		spawn() winshow(usr.client,"CharaBox",0)
		HUDOn=0

mob/verb/Screen_Size()
	set category=null
	ViewX=input("Enter the width of the screen, limits are 5 - 35.") as num
	ViewY=input("Enter the height of the screen, limits are 5 - 35.") as num
	if(ViewX<5) ViewX=5
	if(ViewY<5) ViewY=5
	if(ViewX>35) ViewX=35
	if(ViewY>35) ViewY=35
	ScreenConfigure()

mob/proc/ScreenConfigure()
	if(isnum(ViewX)&&isnum(ViewY)) client.view="[ViewX]x[ViewY]"
	winset(src.client,"mapwindow.map","icon-size=[icon_sizeSave]")
	x_view = ViewX
	y_view = ViewY
	//usr.RemoveStatOverlays()
//	if(usr.KOd) usr.KOOverlay()