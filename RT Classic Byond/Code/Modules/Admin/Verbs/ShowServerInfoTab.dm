mob/var/ServerInfoOn=0
client/var/ServerInfoOn=0
mob/Admin1/verb
	Show_Server_Info_Tab()
		set category = "Server"
		if(ServerInfoOn) ServerInfoOn=0
		else
			usr<<"ServerInfoOn"
			ServerInfoOn=1