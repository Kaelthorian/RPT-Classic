Skill/Spell
	Enchant
		desc="Allows you to enchant certain equipment to give stat bonuses. (Up to +3% in a single stat, 0.6% per enchant and 15 enchants total (25 enchants with Enchant Master)"
		verb/Enchant()
			set category = "Other"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 40)
				var/Cost = 50000000
				var/Actual = round(initial(Cost)/usr.Magic_Potential/(1+usr.HasEnchantMaster))*(1-(0.15*usr.HasDeepPockets))
				switch(input("Do you want to enchant a sword, hammer, guantlets, helmet or armor piece? The base cost is [Commas(Cost)] mana. For you it will cost [Commas(Actual)] mana.") in list("No","Yes"))
					if("Yes")
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								var/obj/items/X
								var/N = input(usr, "How many times do you want to enchant an item?") as num
								if(N <= 0) return
								if(N >= 5) N = 5
								for(var/obj/items/I in get_step(usr,usr.dir))
									if(I.magical)
										switch(input("Are you sure you want to enchant [I]?") in list("No","Yes"))
											if("Yes") X = I
								if(!X)
									for(var/obj/items/Sword/S in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [S]?") in list("No","Yes"))
											if("Yes") X = S
								if(!X)
									for(var/obj/items/Armor/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Gauntlets/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Helmet/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Hammer/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(X)
									if(X.TotalEnchants>=25)
										usr<<"This is already maxed for your current abilities."
										return
									if(!usr.HasEnchantMaster&&X.TotalEnchants>=15)
										usr<<"This is already maxed for your current abilities."
										return
									switch(input("It will cost [Commas(Actual)] mana for you to enchant [X] and grant it +0.6% in the chosen stat when equipped. Please choose a stat to enhance, up to a max of +3%.") in list("Strength","Durability","Speed","Force","Offense","Defense","Cancel"))
										if("Cancel")
											return
										if("Strength")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_str != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_str += 0.006
															if(X.add_str >= 0.03) X.add_str = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_str*100]% strength."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_str*100]% strength."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_str*100]% strength."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% strength [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% strength [Num - N] times.\n")
												return
										if("Durability")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_end != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_end += 0.006
															if(X.add_end >= 0.03)
																X.add_end = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_end*100]% durability."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_end*100]% durability."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_end*100]% durability."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% durability [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% durability [Num - N] times.\n")
												return
										if("Force")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_force != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_force += 0.006
															if(X.add_force >= 0.03)
																X.add_force = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_force*100]% force."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_force*100]% force."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_force*100]% force."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% force [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% force [Num - N] times.\n")
												return
										if("Speed")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_spd != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_spd += 0.006
															if(X.add_spd >= 0.03)
																X.add_spd = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_spd*100]% speed."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_spd*100]% speed."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_spd*100]% speed."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% speed [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% speed [Num - N] times.\n")
												return
										if("Offense")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_off != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_off += 0.006
															if(X.add_off >= 0.03)
																X.add_off = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_off*100]% offence."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_off*100]% offense."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_off*100]% offense."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% offense [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% offense [Num - N] times.\n")
												return
										if("Defense")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_def != 0.03)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_def += 0.006
															if(X.add_def >= 0.03)
																X.add_def = 0.03
															X.magical = 1
															X.cost += Actual
															X.TotalEnchants++
															usr << "Enchantment applied. Total +[X.add_def*100]% defence."
															hearers(10,usr)<<sound('magic.ogg',volume=20)
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_def*100]% defense."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_def*100]% defense."
														N = 0
												//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% defense [Num - N] times.")
												usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% defense [Num - N] times.\n")
												return

							else
								usr << "Not enough mana! You need [Commas(Actual)]"
								return