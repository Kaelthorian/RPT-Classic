Skill/Support/Telekinesis

	verb/Toggle_Telekinesis()
		set category="Other"
		if(usr.TK)
			usr.TK = 0
			usr << "Telekinesis toggled off."
			return
		else
			usr.TK = 1
			usr << "Telekinesis toggled on."
			return
Skill/Spell/Telekinesis_Magic

	verb/Toggle_Magical_Telekinesis()
		set category="Other"
		if(usr.TK_Magic)
			usr.TK_Magic = 0
			usr << "Magical telekinesis toggled off."
			return
		else
			usr.TK_Magic = 1
			usr << "Magical telekinesis toggled on."
			return