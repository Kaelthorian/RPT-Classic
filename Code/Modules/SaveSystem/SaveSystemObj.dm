var/ItemSerial=0

obj/var
	Saved_X
	Saved_Y
	Saved_Z

proc/ItemSerialLoadOld()
	if(fexists("Data/ItemSaves/ItemSerial.bdb"))
		var/savefile/S=new("Data/ItemSaves/ItemSerial.bdb")
		S["ItemSerial"]>>ItemSerial

obj/proc/SaveItem(obj/I)
	var/foundobjects=0
	var/savedobjs = list()
	if(!I.Serial)
		var/Smix1	= rand(1,999999)
		var/Smix2	= pick("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
		var/Smix3	= pick("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
		I.Serial 	= "[Smix2][Smix3][Smix1]"
		DebugLogs("<font color=white>New save created","Saves")
		DebugLogs("Item Name= [I]","Saves")
		DebugLogs("Item Type= [I.type]","Saves")
		DebugLogs("Builder	= [I.Builder]","Saves")
		DebugLogs("Coords	= [I.x],[I.y],[I.z]","Saves")
		DebugLogs("Serial	= [I.Serial]","Saves")
		DebugLogs("Level	= [I.Level]","Saves")
		DebugLogs("Bolt	= [I.Bolted]","Saves")
		DebugLogs("----------------------------","Saves")
	ListCheck(I)
	DebugLogs("<font color=yellow>Savefile modify","Saves")
	DebugLogs("Item Name= [I]","Saves")
	DebugLogs("Item Type= [I.type]","Saves")
	DebugLogs("Builder	= [I.Builder]","Saves")
	DebugLogs("Coords	= [I.x],[I.y],[I.z]","Saves")
	DebugLogs("Serial	= [I.Serial]","Saves")
	DebugLogs("Level	= [I.Level]","Saves")
	DebugLogs("Bolt	= [I.Bolted]","Saves")
	DebugLogs("----------------------------","Saves")
	var/savefile/F=new("Data/ItemSaves/ItemSave[I.Serial].bdb")
	var/list/L=new
	I.savedX = I.x
	I.savedY = I.y
	I.savedZ = I.z
	I.Save_Loc = I.loc
	L += I
	savedobjs += I
	if(foundobjects % 1000 == 0)
		F["SavedItems"] << L
		F=new("Data/ItemSaves/ItemSave[I.Serial].bdb")
		L=new

atom/proc/SaveItemATOM(obj/I)
	var/foundobjects=0
	var/savedobjs = list()
	if(!I.Serial)
		var/Smix1	= rand(1,999999)
		var/Smix2	= pick("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
		var/Smix3	= pick("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
		I.Serial 	= "[Smix2][Smix3][Smix1]"
		DebugLogs("<font color=white>New savefile created","Saves")
		DebugLogs("Item Name= [I]","Saves")
		DebugLogs("Item Type= [I.type]","Saves")
		DebugLogs("Builder	= [I.Builder]","Saves")
		DebugLogs("Coords	= [I.x],[I.y],[I.z]","Saves")
		DebugLogs("Serial	= [I.Serial]","Saves")
		DebugLogs("Level	= [I.Level]","Saves")
		DebugLogs("Bolt	= [I.Bolted]","Saves")
		DebugLogs("----------------------------","Saves")
	ListCheck(I)
	DebugLogs("<font color=yellow>Savefile modify","Saves")
	DebugLogs("Item Name= [I]","Saves")
	DebugLogs("Item Type= [I.type]","Saves")
	DebugLogs("Builder	= [I.Builder]","Saves")
	DebugLogs("Coords	= [I.x],[I.y],[I.z]","Saves")
	DebugLogs("Serial	= [I.Serial]","Saves")
	DebugLogs("Level	= [I.Level]","Saves")
	DebugLogs("Bolt	= [I.Bolted]","Saves")
	DebugLogs("----------------------------","Saves")
//	var/E = 1
	var/savefile/F=new("Data/ItemSaves/ItemSave[I.Serial].bdb")
	var/list/L=new
	I.savedX 	= I.x
	I.savedY 	= I.y
	I.savedZ 	= I.z
	I.Save_Loc 	= I.loc
//	I.Save_Layer	= I.layer

	L += I
	savedobjs += I
	if(foundobjects % 1000 == 0)
		F["SavedItems"] << L
//		E ++
		F=new("Data/ItemSaves/ItemSave[I.Serial].bdb")
		L=new

proc/DeleteSaveItem(obj/I)
	MapNatureScoreCurrent -= I.NatureScore
	if(fexists("Data/ItemSaves/ItemSave[I.Serial].bdb"))
		DebugLogs("<font color=red>Savefile deleted","Saves")
		DebugLogs("Item Name= [I]","Saves")
		DebugLogs("Item Type= [I.type]","Saves")
		DebugLogs("Builder	= [I.Builder]","Saves")
		DebugLogs("Coords	= [I.x],[I.y],[I.z]","Saves")
		DebugLogs("Serial	= [I.Serial]","Saves")
		DebugLogs("Level	= [I.Level]","Saves")
		DebugLogs("Bolt	= [I.Bolted]","Saves")
		DebugLogs("----------------------------","Saves")
		fdel("Data/ItemSaves/ItemSave[I.Serial].bdb")

proc/ItemSerialLoad()

	for(var/A in ItemSerialList)
		if(fexists("Data/ItemSaves/ItemSave[A].bdb"))
			var/savefile/F=new("Data/ItemSaves/ItemSave[A].bdb")
			var/list/L=F["SavedItems"]
			for(var/obj/AA in L)
				if(AA.savedX)
					if(AA.savedY)
						if(AA.savedZ)
							if(AA.Serial)
								AA.loc=locate(AA.savedX,AA.savedY,AA.savedZ)


proc/ListCheck(obj/I)

	for(var/B in ItemSerialList)
		var/A=text2num("[B]")
		if(I.Serial == A)
			return
	ItemSerialList.Add("[I.Serial]")
	var/savefile/S=new("Data/ItemSaves/ItemSerialList.bdb")
	S["ItemSerialList"]<<ItemSerialList

proc/LoadItemSerialList()if(fexists("Data/ItemSaves/ItemSerialList.bdb"))
	var/savefile/S=new("Data/ItemSaves/ItemSerialList.bdb")
	S["ItemSerialList"]>>ItemSerialList

proc/AntiDupProc()
	var/list/Cleaning = new

	for(var/A in ItemSerialList)
		if(A in Cleaning)
			ItemSerialList.Remove("[A]")
		else
			Cleaning.Add("[A]")



