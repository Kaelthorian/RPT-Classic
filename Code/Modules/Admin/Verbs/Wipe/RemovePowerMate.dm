mob/proc/
	Remove_Power_Mate(mob/M in Players)
		set category="Admin"
		if(src.Confirm("Remove [M]s mutations?"))
			M.BPMod=M.GeneticBPMod
			M.BaseMaxAnger=M.GeneticMaxAnger
			M.StrMod=M.GeneticStrMod
			M.EndMod=M.GeneticEndMod
			M.SpdMod=M.GeneticSpdMod
			M.OffMod=M.GeneticOffMod
			M.DefMod=M.GeneticDefMod
			M.BaseRecovery=M.GeneticRecovery
			log_admin("[key_name(src)] removed [key_name(M)]'s mutations")
			alertAdmins("[key_name(src)] removed [key_name(M)]'s mutations")