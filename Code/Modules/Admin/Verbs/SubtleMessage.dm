/client/proc/cmd_admin_subtle_message(mob/player/M as mob in world)
	set category = "Admin"
	set name = "Subtle Message"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	var/msg = input("Message:", text("IC message to [M.key]")) as text

	if (!msg)
		return
	if (usr.client && usr.client.holder)
		M << "(IC) <span class=\"subtle_message\">[msg]<span>"

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	alertAdmins("SubtleMessage: [key_name_admin(usr)] -> [key_name_admin(M)] : [msg]", 1)