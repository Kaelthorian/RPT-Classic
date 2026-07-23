mob/proc/CookingLevelCheck()
	if(Cooking_XP>=Cooking_Next&&Cooking_Level<TechCap)
		Cooking_XP-=Cooking_Next
		Cooking_Next=round(Cooking_Next*1.06)
		Cooking_Level++
		if(Cooking_XP>=Cooking_Next&&Cooking_Level<TechCap)CookingLevelCheck()
	if(Cooking_Level>=TechCap) Cooking_XP=0
