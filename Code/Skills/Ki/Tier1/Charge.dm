Skill/Attacks/T1/Charge
//	Fatal=1


	icon='20.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge. With training its explosiveness and refire speed can increase."

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_POW	= DMGS_TIER_1
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Charge()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		usr.Ki=EnergyCalculation(src,usr)
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		charging=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.3
		Delay += 3
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
//		A.light_power = 5
//		A.light_range = 5
//		A.light_color = "#ffffff"
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_OFF		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_SPD		= 0
		A.DMGSOURCE_END		= 0
		A.LT				= HEAD
		A.UL				= HEAD
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		var/MaskDamage=0
		var/MaxSwordPercent=100

		if(usr.HasWeaponizedKi)
			for(var/obj/items/Sword/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Hammer/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Gauntlets/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			if(usr.BoundWeaponOn) MaskDamage=usr.BP*(0.4+(usr.BoundWeaponOn*0.1))
			if(usr.KiBlade)
				if(usr.HasBladeOfLight) MaskDamage=usr.BP*0.4
				else MaskDamage=usr.BP*0.3
			if(usr.KiHammer)
				MaskDamage=usr.BP*0.6
			if(usr.SpiritSword)
				MaskDamage=usr.BP*0.7
			if(usr.KiFists) if(MaskDamage<=usr.BP*0.18)
				MaskDamage=usr.BP*0.18

			if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP

		if(usr.MaskOn)
			for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Power=0
		A.Offense=0
		A.Explosive=0
		A.Explosive=1
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0
		charging=0
//		A.update_light()

