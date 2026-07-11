proc
    splittext_limit(text, limit)
        var
            list/parts = new
            part
            line
        for(line in splittext(text, "\n", 1, 0, TRUE))
            part += line
            if(length(part) > limit)
                parts += part
                part = null
        if(part)
            parts += part
        return parts

var/global/UPDATE_VERSION = 1.91
var/global/NewVersion=2.8
mob/var/LastVersionPlayed
var/NewUpdate={"
***Roleplay Tenkaichi version 2.2.1 - New Wipe New fixes   - 03/08/2024
<br>
<br>New:
<br>
<br>-Added:		You now learn sense energy at year 0.
<br>-Added:		Admins now can spawn Ores AND Fishes.
<br>-Added:		OOC now strems to Discord channel OOC.
<br>-Added:		Added a new verb for admins to give skills proprly with the new system.
<br>-Added:		New verb to find the exit of the underground , you have it by default in the Other tab and only works underground.
<br>-Added:		AL to LR connection establish! you can now travel from the LR to the AL with portas , with certain rules, have fun finding the portals!.
<br>
<br>-Changed:	Normalized the movement speed so races with 1 spd mod now move faster.
<br>-Changed:	Race verb now will show you only the race with the higest amount of players playing it in that moment.
<br>
<br>-Removed:	Reformation potions where removed , I will give you a buttonn to reform your build every time you get a new stat point extra from the self learn.
<br>
<br>Bugs:
<br>
<br>-Fixed:		Speed Bug with attack.
<br>-Fixed:		All MPs that boost or nerf your stats now propperly do it and are displayed in your stat tab.
<br>-Fixed:		Fishes now spawn in the new water.
<br>-Fixed:		BP gains fixed.
<br>-Fixed:		Spars now gives the same BP as Meditate.
<br>-Fixed:		You can't see the inside of buildings if you are in the sky map.
<br>-Fixed:		You can't land inside buildings from the skymap.
<br>-Fixed:		If you are alive and not a kaio or a demon you will not be send to the void anymore if you are in the AL.
<br>-Fixed:		Stance is not gain forever every time you use self learn.

"}


proc/LoadUpdates()
	if(UPDATE_VERSION>= NewVersion)
		usr << "<b>Game is up to date!</b>"
		return
	else if(UPDATE_VERSION<NewVersion) UPDATE_VERSION = NewVersion

	if(!TestServerOn)for(var/part in splittext_limit(NewUpdate,1750))
		usr.client.HttpPost("https://discord.com/api/webhooks/894013914168324096/y1S-jyNCGBOtwwZ4QDD68c27dwckgWciK_-2gE_arzl8XRtGEt0bIQ-ZlYpHNYnK6c2L",list(content = part,))
		sleep(10)
	world << "<b>Server updated to Version [UPDATE_VERSION] Successfully</b>"
	world.log << "Server updated to Version [UPDATE_VERSION] Successfully"
	Save_Gain()

var/Recent_Updates={"
***Roleplay Tenkaichi version 2.2 - New Wipe   - 03/05/2023
<br>
<br>New:
<br>
<br>-Added:
<br>
<br>-Changed:	Now you need an X amount of T1s to see all the T2s instead of needing 1 T1 skill to see 1 T2 skill.Meaning there is no skill tree anymore.
<br>-Changed:	There is no longer Melee moves , they are all either Unarmed , Ki or Weapon moves.You can't use swords skills without swords and you can't use unarmed skills with swords.
<br>-Changed:	Exponential growth now gives you 50% more gains if you use punching bags only.
<br>-Changed:	Changellings (Freezer and Coolers) now unlock Form 2 at wipe day 2 , Form 3 at wipe day 9 and Form 4 at wipe day 19 only if they have enough EXP life.
<br>-Changed:	Changellings (Freezer and Coolers) Form 2 from 1.2 to 1.1 , Form 3 from 1.2 to 1.35 , Form 4 from 1.2 to 1.15. (this might change)
<br>
<br>-Removed:	Elixir Of Uncertainty is gone.
<br>-Removed:	A bunch of things related to the Ranks that was left over in the code.(ECs might be affected by this)
<br>-Removed:	Bulldozer admin tool removed until it can save what it bulldoze.
<br>-Removed:	Roleplay Rewards , the gain buff is gone.
<br>-Removed:	Inspiration , the gain buff is gone.
<br>-Removed:	Well Rest , the gain buff is gone.
<br>
<br>Bugs:
<br>
<br>-Fixed:		Save bug where the saves were not being deleted if you were building over an existing obj.
<br>-Fixed:		Artifacts now save properly.
<br>-Fixed:		Pre made objs are now saved and loaded properly.
<br>-Fixed:		The game now tell you the version you should be correctly.
<br>-Fixed:		Stats given by stances now work properly.
<br>
<br>
***Roleplay Tenkaichi version 2.1.11 - Fixing time   - 03/05/2023
<br>
<br>New:
<br>
<br>-Added:		MapEdit verb was added, you can now delete objs/props if you are the builder or if the obj have no builder at all , you just have to click it.
<br>
<br>-Changed:
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Is no longer possible to go beyond the true bp cap no matter what.
<br>-Fixed:		Gravity machies now save properly , sorry for the problems ask for the refund.
<br>-Fixed:		Second attempt to fix Wall of Flame.
<br>-Fixed:		High Tension buff Y/X fixed.
<br>-Fixed:		FBM check now trigger properly.
<br>-Fixed:		Icey Grip fixed.
<br>
<br>
***Roleplay Tenkaichi version 2.1.10 - Fixing time   - 03/04/2023
<br>
<br>New:
<br>
<br>-Added:
<br>
<br>-Changed:	No longer need EXP overflow to reach the cap 1.3.
<br>-Changed:	You can't use a senzu bean on someone who has a broken throat.
<br>-Changed:	Nanite Burst now gives +7 HP instead of +5 HP.
<br>-Changed:	Deep Breathing now gives you 12.5% more energy when hitting someone , per rank.
<br>-Changed:	Fly like a buttefly: Each time you dodge an opponent's attack verb they will lose 5% of their total current energy
<br>-Changed:	Genki Dama now change his dmg and loading time according to the size you pick.
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Sturdy build now show you the proper amount of HP add to your limbs per rank.
<br>-Fixed:		Ki weapons now add BP to their attacks.
<br>-Fixed:		You can now Loot money and mana.
<br>-Fixed:		Genki Dama now have the right icon.
<br>-Fixed:		Echoing slash duplicated dmg
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.9 - Fixing time   - 02/26/2023
<br>
<br>New:
<br>
<br>-Added:
<br>
<br>-Changed:	You now gain 1/5 of the total energy when auto attacking in combo.
<br>-Changed:	Your zanzoken (Click to teleport) now cost 5 energy instad of 50.
<br>-Changed:	Jump Backward now cost 5 Energy.
<br>
<br>
<br>-Removed:	Villain 5% BP extra cap, not 100% if this was what it was making a bug happen but we will see.
<br>
<br>Bugs:
<br>
<br>-Fixed:		First Attempt to fix echoing slash.
<br>-Fixed:		Strange bug where you coudln't attack anymore in some situations.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.8 - Fixing time   - 02/21/2023
<br>
<br>New:
<br>
<br>-Added:		Catch The blade and Riposte are back in the EXP menu.
<br>-Added:		New Ki blade icon.
<br>-Added:		New Ki Hammer icon.
<br>-Added:		Skills Traits for CD are now working.
<br>
<br>-Changed:	Auto Attack math is now following the new math.
<br>-Changed:	Weapon skills no longer get bonus dmg from their weapon extra BP.
<br>-Changed:	Zanzoken is teleport is back , you have to double ckick to make it work.
<br>-Changed:	Stat tab now show you the caps with different colors.
<br>-Changed:	You can't go beyond 1x the BP cap with training.
<br>
<br>
<br>-Removed:	Lighting bolt is shit and will ever be shit , is gone reduce to atoms , will work in a new version of it that doesn't work with clicks.
<br>-Removed:	Zenkai , is gone forever and ever from our life until we came out with a better idea for it.
<br>
<br>Bugs:
<br>
<br>-Fixed:		Consecutive punches , working as intended.
<br>-Fixed:		Quick Jab , working as intended.
<br>-Fixed:		Wolf Fang Fist , no longer drain all your energy.
<br>-Fixed:		Empower Def and attack now follow the proper CD
<br>-Fixed:		Combat Math follow the proper CD.
<br>-Fixed:		FireBall now does dmg.
<br>-Fixed:		Ores spawns when mining them
<br>-Fixed:		Ores now follow the right path of upgrade , Copper , Tin , Iron , Mythril , Silver , Auracite , Masterwork.
<br>-Fixed:		Sword masterwork now is 65 instead of 60 BP
<br>-Fixed:		Sword Auracite now is 60 instead of 65 BP
<br>-Fixed:		Sword Silver now is 55 instead of 60 BP
<br>-Fixed:		Ki weapons now follow the new math.
<br>-Fixed:		Spirit Ball now does dmg.
<br>-Fixed:		Explosion now works again but you now have to double ckick to make the explosion.
<br>-Fixed:		Minor bug with self train , sparring and punching bag fixed.
<br>-Fixed:		March of Fury not letting you attack if you were staggered.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.8 - Fixing time   - 02/07/2023
<br>
<br>New:
<br>
<br>-Added:		Ki Beacon , a move that allow you to send a "SOS" signale with your ki in a wide range.The range change according to your Ki mod and the ones who can sense it may variate according to their ki mod.
<br>-Added:		New skill for admins to ban skills.
<br>
<br>-Changed:	All normal weapons now do a reduced amount of BP add instead of 1%.
<br>-Changed:	Blast now have no CD and drain 5 energy.
<br>-Changed:	If you chose 0 while trying to upgrade an armor you will cancel the upgrade.
<br>-Changed:	Blast now drain according to how many blast you fire at the same time.
<br>-Changed:	Ki Beacon WP lowered to 5.
<br>
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Megaton throw now hits once more.
<br>-Fixed:		Training boost now gives the right amount of boost and not x10
<br>-Fixed:		All the training MPs now work properly.
<br>-Fixed:		You no longer stay meditating , training or studing when you relog.
<br>-Fixed:		You can now learn RoundhouseKick in the learning menu.
<br>-Fixed:		No longer stay online when you log out.
<br>-Fixed:		If you are knockbacked you no longer stay studying or meditating or self training if you were before.
<br>-Fixed:		If you are KOed you no longer studying or meditating or self training if you were before.
<br>-Fixed:		A lot of saving bugs.
<br>-Fixed:		Ice Gryp now works properly.
<br>-Fixed:		Counterpart is a one time decision now.
<br>-Fixed:		Self Train is now working as intended.
<br>-Fixed:		UpperCut CD and Energy fixed.
<br>-Fixed:		You can't knock doors from 10 tiles away.
<br>-Fixed:		Teachin now don't requiere passives.
<br>-Fixed:		You now get roundhouse when buying it.
<br>-Fixed:		You can now train both , int and magic , and gain both , res and mana , if you have persuit of knowledge.
<br>-Fixed:		Ki Skills now follow the right proc for dmg.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.7 - The great sleep   - 09/23/2022
<br>
<br>New:
<br>
<br>-Added:		You now teleport to the other side of the map when you are at the edge of the map instead of bump it.
<br>-Added:		New skill , Study , while you study you will gain int/magic levels and according to what you study you will gain mana or resources.
<br>-Added:		Reworked training system , now we have the following training methods : Meditation , Self train , Training equipement (Punching bags and other methods) , Spars.
<br>-Added:		Caps are back to what they used to be , from 1x to 1.1x , from 1.1x to 1.2x and 1.2x to 1.3x.
<br>-Added:		To move from the 1.2x to 1.3x cap you must have your exp capped and at least 1 point in EXP overflow.
<br>-Added:		You can now boost your training by : Having all your WP , stomach full (Food) , Drugs , Having weights (no matter the amount) , Training in gravity , Being dead , Having a body while dead.
<br>-Added:		Your training will be nerfed if: You have low WP , broken bones (They stack) , low HP.
<br>-Added:		Skills now have Traits , here is the list and what they do:
<br>
<br>#SKILLSHOOT		Extra damage to your attack but it have no homing.
<br>#SPAMMABLE		Lowers the CD of the skill.
<br>#STRONG			Increase base dmg.
<br>#ENERGYFLOW		Lowers the energy req.
<br>#HEAVYPUNCH		Increase the knockback effect.
<br>#FASTLOCK		Increase your hit chances.
<br>#WEAKPOINT		Extra damage to limbs.
<br>#ENERGETIC		You gain energy when you hit someone.
<br>#HOMING			Easier to dodge but travels to your target.
<br>#WINDUP			Higher CD for the skill.
<br>#WEAK			Lower dmg of the skill.
<br>#ENERGYBLOCK	Increase the energy needed for the skill
<br>#LIGHTPUNCH		Lowers the knockback effect.
<br>#AIMLESS		Lowers the hit chance.
<br>#DRAINING		Make you drain energy when you hit someone.
<br>
<br>
<br>-Changed:	Save system for objects is now saved on the fly so we don't need the world save for it.(We will still have world saves but will have no impact on the server lag)
<br>-Changed:	The max screen size is now 35x35
<br>-Changed:	Now when you meditate you can't gain mana nor int/magic levels.
<br>-Changed:	You can't go beyond 1.3x in any stats no matter what you do.
<br>-Changed:	You can only gain spar stats if you use boxing gloves , you must be using boxing gloves.
<br>-Changed:	When you train , no matter the method , all your stats will go up at the same phase and by the same amount.
<br>-Changed:	Gauntlet BP add were all changed to , Copper:5% ,Bronze:10% ,Iron:15% ,Mythril:20% ,Silver:25% ,Auracite:30% ,MasterWork:35% BP add
<br>-Changed:	Sword BP add were all changed to , Copper:35% ,Bronze:40% ,Iron:45% ,Mythril:50% ,Silver:55% ,Auracite:60% ,MasterWork:65% BP add
<br>-Changed:	Hammer BP add were all changed to , Copper:65% ,Bronze:70% ,Iron:75% ,Mythril:80% ,Silver:85% ,Auracite:90% ,MasterWork:100% BP add
<br>-Changed:	KB on knockback kick reduced to less than the half.
<br>-Changed:	Dash Attack: Reworked , now will knockback you in a straight line based in your str vs your target end.The damage will come from SPD and the amount of steps you do is based in your Spdmod * SpdMult.The futher you travel the more dmg you do.
<br>-Changed:	Wing Clip effect changed from 5 to 10 seconds.
<br>-Changed:	Axe kick now is AoE , 1 tile.
<br>
<br>-Removed:	All beams are gone and now we only have one , the normal beam who can be modify to whatever you want just like the custom beam skill we had.
<br>-Removed:	Gain system that influence how much stats you gain per tic is now gone.
<br>-Removed:	Stat focus , you can't stat focus anymore.
<br>-Removed:	Stats and BPs Ranks are gone all training is now individual.
<br>-Removed:	Stats and BP catch up systems are gone and are no longer needed due the new training system.
<br>-Removed:	Zenkai is removed from the game , pending rework.
<br>-Removed:	Hellzone Granade skill.
<br>-Removed:	Sword Stab wind up before attacking.
<br>
<br>Bugs:
<br>
<br>-Fixed:		Burning Shot: The last attack now does damage.
<br>-Fixed:		Consecutive Normal Punch: The name now match the verb.
<br>-Fixed:		March of Fury: You can't get over the cap energy while using March of Fury anymore.
<br>-Fixed:		Texas Smash: You don't need to wait for the whole CD to use it again and actually triggering the attack.
<br>-Fixed:		Lion Roar: The dash now is 3 tiles and then you do the damage if you hit your target.
<br>-Fixed:		Beams: They no longer eat your energy to 0 in 2 seconds.
<br>-Fixed:		Rock Slide: They no longer collide with each other anymore.
<br>-Fixed:		Time Freeze: Is not possible to chain it forever and stun forever a person.
<br>-Fixed:		Barrage: it will now drain the correct amount of energy instead of 120.
<br>-Fixed:		Mortar Charge: It now show as Mortar Charge in the verb tab.
<br>-Fixed:		Telekinetic Pull: It now show in the tab.
<br>-Fixed:		Solar Flare: Is not possible to set solar flare to more than 20 tiles and less than 1.
<br>-Fixed:		Blaster Meteor: They no longer collide with themselves.
<br>-Fixed:		Death Ball: It now works , just that.
<br>-Fixed:		Genocide: It no longer drain all your energy while using it.
<br>-Fixed:		Kickback Combo: The 2 hit now hit.
<br>-Fixed:		Sku Break now drain energy.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.6 - Small changes   - 09/23/2022
<br>
<br>New:
<br>
<br>-Added:
<br>-Changed:
<br>-Removed:	Reflections worked fine ! but need some small works , will remove it for now.
<br>
<br>Bugs:
<br>
<br>-Fixed:		Small bug when you moved while looking for seeds is now fixed.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.7 - No more fix , now small changes   - 09/23/2022
<br>
<br>New:
<br>
<br>-Added:		Reflections are now in the game , all water source should have it.
<br>-Added:		QoL for admins, they can now see all the skills of every player they assess.
<br>-Changed:	Ki blade and quick jab now are bff and work togther.
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.6 - No more fix , now small changes   - 09/10/2022
<br>
<br>New:
<br>
<br>-Added:
<br>-Changed:	Deep Breathing now gives you 2% more energy gains per stack when you attack for a maximum of 4% extra energy gains per attack.
<br>-Changed:	Chakra Block now stop your opponent from regaining energy from any source.
<br>-Changed:	Float like a butterfly now gives you +5% energy when you dodge and the normal 5% defense.
<br>-Changed:	Quick Jab and Slice are now energy free.
<br>-Changed:	All the msgs when you try to use a skill and you are not allowed to use it was moved to the combat tab and now they tell you exactly the reason why you can't use it.
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.5 - Fix fix fix fix fix fix fix fix fix fix   - 09/5/2022
<br>
<br>New:
<br>
<br>-Added:
<br>-Changed:	You can't use ".click" macros anymore to abuse exploits.
<br>-Changed:	Ki bow now drains 10 ki per arrow , it have an increase homing chance and if you run out of energy you will do a normal attack instead of needing to turning it off.
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Ki fist now follow the accuracy formula.
<br>-Fixed:		Block no longer display 2 sources of dmg and the animation is in coordination with the time it happens.
<br>-Fixed:		Fixed Upper combo doing 0 dmg in the 2 and 3 attack.
<br>-Fixed:		Energy bug stack at creation screen.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.4 - Fix fix fix fix fix  - 09/2/2022
<br>
<br>New:
<br>
<br>-Added:
<br>-Changed:	All the ki moves that are bought from now one are 100% mastered.
<br>-Changed:	Warp attack now regen 10% of your max energy instead of draining your energy in use.
<br>-Changed:	RoundHouse kick is now a T2 (If you have it already it will stay with you)
<br>-Changed:	Zanzoken is now a T1 (T1 are all the auto learn ones).
<br>-Changed:	You can now learn riposte and catch the blade from blockstance.
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Energy gains when you attack now scales from max ki not current ki.
<br>-Fixed:		All the Meele moves now follow the correct accuracy , dmg and CD math.
<br>-Fixed:		Powering up no longer drain you energy as you power to your max.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.3 - Fix fix fix fix fix  - 09/1/2022
<br>
<br>New:
<br>
<br>-Added:		Admins now can see how much Ki the player have in the assess sheet.
<br>-Changed:	Farming crops now give you more money when you sell them (They also avoid taxes when you sell them just like ores and fishes)
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		0 energy bug where you never regen energy unless you meditate.
<br>-Fixed:		All the sword damage related bugs.
<br>-Fixed:		All the sword moves no longer need to be mastered , they are all 100% mastered since you got them.(Soon the other moves will be the same)
<br>-Fixed:		Math problem for CD fixed (Thanks Weasker and Shumba)
<br>-Fixed:		Dash attack now can be used with weapons or not.
<br>-Fixed:
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.2 - Combat Rework  - 08/28/2022
<br>
<br>New:
<br>
<br>-Added:		Farming , you can now look for seeds in grass tiles and plant them for food.
<br>-Changed:	if you have shield on , you will regen 10% less energy per attack.
<br>-Removed:	Block , the temporal old skill , is removed from the game.
<br>
<br>Bugs:
<br>
<br>-Fixed:		You no longer can auto attack while blocking.
<br>-Fixed:		Self train now last longer than 3 seconds with the new energy system.
<br>-Fixed:		Aim for the heart is now once more usable.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.1.1 - Combat Rework  - 08/22/2022
<br>
<br>New:
<br>
<br>-Added:		New toggleable skill , Block , it will set your block chance to 100% and your dodge chance to 0%.
<br>-Added:		You can't move anymore while you are blocking but you can still change the direction you are facing.
<br>-Added:		Now when you block a skill/attack the animation doesn't proc , the status effect (Bleeding , Stun , Knockback, etc..) doesn't apply and you take 50% of the total damage.
<br>-Added:		You can't move while an animation is happening , nor you can take damage from other sources while you are in the animation.(To avoid skill stacks)
<br>-Added:		You now can only gain energy in fights if you block an attack , dodge an attack or attack someone (Doesn't matter if you hit or not).
<br>
<br>-Changed:	Combat Tab is back to the old chatbox where it used to be.
<br>-Changed:	Energy now is a untrainable stat.
<br>-Changed:	You no longer regen energy while standing up , the only way to regen energy outside of combat is while meditating.
<br>-Changed:	Energy no longer lower your BP as you run out of it.
<br>-Changed:	Your learn list now run by your passives not your max energy , meaning that you can't learn more skills the more energy you have anymore.
<br>-Changed:	Buffs no longer requiere 10% of your total energy to be on.
<br>-Changed	Power Control no longer drains energy.
<br>
<br>-Removed:	Armors , Power armors and all the weapons (Except the boxing gloves) no longer take damage.
<br>-Removed:	Passive skills (Unarmed , evasion , swordskill)and everything related with it dmg combat wise is removed from the game , pending redisign.
<br>-Removed:	Stance that are no mastered no longer nerf your damage.
<br>-Removed:	Every single possible way to train energy.(If you find any possible way please report)
<br>
<br>
<br>
<br>Bugs:
<br>
<br>-Fixed:		Cyberize isn't letting folks use Adamantine skeleton.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.0.6 - Minor fixes  - 06/21/2022
<br>
<br>New:
<br>
<br>-Added:		Options for the admins to allow or remove the AL race power.
<br>
<br>-Changed:
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Added some variables to the save world that were not being saved.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.0.5 - Minor fixes  - 06/17/2022
<br>
<br>New:
<br>
<br>-Added:		Option for revive in the crystals if you are a KS/DL
<br>-Added:		New admin command , secret
<br>-Added:		Confirmation pop up for Veil Travel.
<br>
<br>-Changed:	A lot of shit that you can't see but the code is way more organized for the skills and I love it and it deserve to be mentioned.(Cookie for me)
<br>-Changed:	Heal is not possible to be used in a MI fight as long as you have the combat tracker on.
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Fireball no longer does inf dmg.
<br>-Fixed:		Deads can be unjured now (They could only be self injured)
<br>-Fixed:		Gravity no longer cap to max.
<br>-Fixed:		Armor bug where you lose spd if your armor is broken and you have armor mastery.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.0.4 - Minor fixes  - 06/11/2022
<br>
<br>New:
<br>
<br>-Added:		When someone is at 0 WP and you show him mercy , his WP and HP will change to 1 (Tokenblack09#7169 -S#467 )
<br>-Added:		If your throat is broken , missing or maimed , you can't eat senzu beans/food/potions anymore.But if someone use it on you , you can still eat it (Sans#2453 -S#471)
<br>-Added:		Cancel button for team invite(Silver560#7252 -S#443)
<br>
<br>-Changed:
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:		Re-Writed the Crystal power code when you log in and out , it should work properly now.
<br>
<br>
<br>
**Roleplay Tenkaichi version 2.0.3 - Minor fixes  - 06/11/2022
<br>
<br>New:
<br>
<br>-Added:
<br>
<br>-Changed:     Armor Mastery now totally remove the nerf in spd when you use an armor.
<br>-Changed:    Armors durability are the follow now : Copper from 120 to 240 , Bronze from 150 to 300 , Iron/Silver from 150 to 400 , Mythril/Auracite from 200 to 600 , MasterWork from 220 to 1000.
<br>-Changed:    Megaton throw don't need a grab check anymore , is instant now.
<br>-Changed:    PileDrive no longer needs a grab nor proc a grab when trying to use it , is instant.
<br>-Changed:    PileDrive no longer runs a CD if you use it and there is no target in front of you.
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed:        Removed the chance to proc the diagonal movement bug in fights.
<br>-Fixed:        Lossing the crystal power on log in.
<br>
<br>
<br>
<br>***Roleplay Tenkaichi version 2.0.2 - Minor fixes  - 06/10/2022
<br>
<br>New:
<br>
<br>-Added: Read Crystal Energy , will tell you who owns a crystal and the CD of it.
<br>-Added: The AL Crystals now will tell you how far from ending the procces they are once every 15 min.
<br>-Added: Every 15 min the AL Crystals will read if the process was stopped , if so they will stop trying to claim it for the next 2 hours.
<br>-Added: The AL Crystals will now tell you how much time they are from recharging their energy after the attunment was stopped.
<br>
<br>-Changed: Elixir of reformation changed from level 57 to level 25 , mod 4 to mod 6.
<br>-Changed: Elixir of reformation price from 25 mill to 1 mill at mod 6.
<br>-Changed: The AL Crystals now read your real name instead of your Ckey.
<br>
<br>-Removed:
<br>
<br>Bugs:
<br>
<br>-Fixed: Energy tick display in character sheet.
<br>-Fixed: Now only the AL race and those in the AL get the soul alert.
<br>-Fixed: AL Crystal bug where you couldn't finish the claiming if you crashed or log out.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.0.1 - EC problems  - 06/04/2022
<br>
<br>New:
<br>
<br>-Added: LR races who are not dead and in the AL are automatically sent to the LR.(Aka space)
<br>-Added: AL Crystal now need 330 Life time exp to be used.
<br>-Added: More EC keys , and fixed some of them too.
<br>-Added: Exception for admins so they can travel the AL while in admin mode.
<br>-Added: New verb for admins to make EC without the need of them being in the EC list.
<br>
<br>-Removed: The ugly aura from War buff is now gone , is just the wings and horns.(JuiceMakeSugar#7233 -S#521)
<br>
<br>Bugs:
<br>
<br>-Fixed: AL narration for when someone dies.
<br>-Fixed: Bug with the crystal where you couldn't claim it no matter what race you are.
<br>-Fixed: May have found the source of our world save lag , testing it in this update.
<br>-Fixed: Sell all bug , in theory fixed couldn't replicate it.
<br>
<br>
<br>
***Roleplay Tenkaichi version 2.0.0 - AL comeback  - 06/03/2022
<br>
<br>New:
<br>
<br>-Changed: Focus now gives no regeneration boost.
<br>-Changed: Majin , the demons buff , name was changed to Sin Force.
<br>-Changed: Version of the game number now reflect exactly what it should be.
<br>-Changed: Max gravity is now 240.
<br>-Changed: Every 5 years the gravity raise instead of every 2.
<br>-Changed: Oni stats buffed: Anger from 1.5 to 1.4 , Endurance from 2.3 to 2 , Offense from 1.7 to 1.8 , Defense from 1.6 to 1.8 , Recovery from 1.8 to 2.2.
<br>-Changed: Oni big form buffed: Anger from 1.2 to 0 , Endurance from 1.3 to 1.2 , BP from 1.3 to 1.45.
<br>-Changed: Pantheons rework , too big to log it here.
<br>-Changed: Pantheons now came out first , Zeus, Horus, Nauda, Odin , then at trans era Chernobog , Hanuman and in god ki Ravana.
<br>-Changed: Upgrade android is not unlocked at int level 25.
<br>
<br>-Added: Majinized for 500 EXP , 5 magic mod wipeday 10 and EXP life 1450.
<br>-Added:	Majinized persons gain 5% more BP , -5 WP on KO and -10% regene.
<br>-Added:	Majinized can be revert at any time , doing that will make the user lose 20 WP.
<br>-Added: If you are majinized and your karma becomes neutral or good , you lose your majin power.
<br>-Added: Cyborgs and Bio androids can't be majinized anymore.
<br>-Added: You can't majinized a control point owner nor you can get the control point if you are majinized.
<br>-Added: Old AL map is now back to the game.
<br>-Added: AL map gravity now change automaticaly to the max possible in the wipe at that year.
<br>-Added: Ores now spawn in the AL normaly as in like any other planet.
<br>-Added: Demons and Kaios now can be made at year 0 but they spawn in the AL.
<br>-Added: Summon demon , it allow you to summon a non afk demon from the AL to the LR. (Exact same lvl/int mod/magic mod/price as Conjure and Create artificial angel)
<br>-Added: Pray , it allow you to summon a non afk kaio from the AL to the LR.(Exact same lvl/int mod/magic mod/price as Conjure and Create artificial angel)
<br>-Added: New Racial Skill for demons and kaios , Veil Travel , it allow them to travel back to the AL and their summoner whenever they want.
<br>-Added:	Cyborize , you can unlock it at the same exact reqs as ciborize.
<br>-Added:	If you are cyborize you now are permanently powered up , you can't power down but your energy per tick will be the same as if you were at 0% power up.
<br>-Added: You can now Cyborize players no matter what int mod they have but you need the MP for it.
<br>-Added: Cyborized players can't use sense energy.
<br>-Added: If you die as a cybor , you lose your cyber perks and nerfs
<br>-Added: Everyone in the afterlife get a msg every time someone dies and goes to the AL.
<br>-Added: If you are dead and in the AL , you have 100% of your body now.
<br>-Added: If you are dead and in the LR , you have 10% of your body now.
<br>-Added: If you are dead and in the LR someone give you back your body , you are 100% body now.
<br>-Added: If you die while you are dead (With body or not) you are send to the final realm now.
<br>-Added: If you are dead and in the LR , in a MI fight you get 80 more WP dmg on KO.
<br>-Added: If you are dead and in the LR , if you have a body you get 40 more WP dmg on KO.
<br>-Added: If you are dead and 0 WP in the LR without a body , you are automatically teleported to the AL.
<br>-Added: Seance now have a req of 50 fam point with your target.
<br>-Added: Advance seance now have a req of 100 fam point with your target.
<br>-Added: You can't be seanced for 5 years since you die , even if you die again.
<br>-Added: Demons and Kaios now auto learn Revive for revive 440 exp.
<br>-Added: Kaios and Demons now auto learn keep body , for 100 exp they can give body to anyone.
<br>-Added: When you are revived you are sent to the Living realm.
<br>-Added:	All stances now have the 50% more ki per tick core.
<br>-Added: Ritual of power now have no CD and last 1 month.
<br>-Added: Afterlife Crystal , the one who control the 4 of them will be the controler of the afterlife.
<br>-Added: Only Demigods , Kaios , Demons and Onis can claim the afterlife crystals.
<br>-Added: Demigods and Kaios  can sense when a crystal is about to be taken.
<br>-Added: Demigods , Kaios , Demons and Onis are more powerfull in the afterlife than in the living realm.
<br>-Added: Demigods , Kaios , Demons and Onis now auto learn Dispel , to send soul kaios or demons back to the afterlife. (TienShenhan#7012 -S#397)
<br>-Added: You can open the final realm gate , for a prize... if you are a KS/DL.
<br>-Added: You can now open or close the veil travel if you are a KS/DL.
<br>-Added: You can now travel between the AL crystals if you own one.
<br>-Added: Force field generator , it will create a force field around.
<br>
<br>-Removed: Demon and Kaio tech/magic skill to create them is now gone.
<br>-Removed: Cyberize is gone.
<br>-Removed: There is no more 20% chance for you to revert from imitation when KOed.
<br>-Removed: Advance Seance don't give you a body anymore.
<br>-Removed: DarkBargain from magic learn skill untill reworked.
<br>
<br>Bugs:
<br>
<br>-Fixed: Descriptions for DB and Alien transformation.
<br>-Fixed: Bug with seance not sending the soul back when it should.
<br>-Fixed: Lag spike on world save (I want to believe)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.99 - Drop fix  - 09/6/22
<br>
<br>New:
<br>-Added: You can now knock pods and ships doors.(-S#451, Frozen#1659)
<br>-Added: More ECs.
<br>
<br>Bugs:
<br>-Fixed: Capsule tech , is now removed from ships and regen tanks.Only power armors can use it for now.
<br>-Fixed: Artifacts cyber limbs going negative or super high.
<br>-Fixed: Artifacts passives going into negatives or super high.
<br>-Fixed: Artifact bug that proc when you drop things.
<br>-Fixed: Artifact duplication bug (Or I hope)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.98 - Easter egg  - 09/6/22
<br>
<br>New:
<br>-Added: You can see how many catch ups MPs you are missing in the status tab now.
<br>-Added: Sell all in other tab for ores and fishes , (-S#406, daicci#3130)
<br>
<br>Bugs:
<br>-Fixed: Sturdy build fixed , now it gives 5+ HP to limbs.(Ask for a free MP redo , is not retroactive)
<br>-Fixed:	Androids can now use power armor.
<br>-Fixed: Restore WP admin verb missing admin log alert.
<br>-Fixed:	Ritual of Power now reads year AND months.
<br>-Fixed: Androids have Throats and Ears now.
<br>-Fixed: DA in androids , they can't get DA anymore.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.97 - Fix/Logs  - 09/6/22
<br>-Added: Logs to artifacts/DBs for when they are grabbed.
<br>-Added: Sound to Destructive wave charging time.
<br>-Added: ECs keys added.
<br>-Changed: Now you can gain MPs while offline , what this mean? If you make a character at year 20 and logs out , when you logs back in at year 21 you will have 12 MPs (1 per month as usual).
<br>-Fixed: Things that are on fire no longer make smoke , but they still have the fire animation.
<br>-Fixed: Drills/Pylons now start bolted to avoid people forgetting about it.
<br>-Fixed: Bio androids lossing their absorb count should not be a thing anymore.
<br>-Fixed: Self destruct now does enough damage to grant a KO and a broken limb to anything that is hit by it.Also the charge timer went down by a lot and the range is larger.
<br>-Fixed: Medical assess should now show mutations if you have 5 or more int.
<br>-Fixed: Give power , now when you give power you gives all your energy plus 1.3 more to your target.The maximum extra BP you can get from this is 1.3 and it fades away slowly as it used to.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.96 - Fix  - 04/2/22
<br>-Fixed: Artifacts weapons now add bp to the attacks.
<br>-Fixed: Artifacts now tell you when they are dropped by a save and the coords of them so you can keep track of it.
<br>-Fixed: Artifacts and Dragonballs now read months and years , so when you drop them in disconnects or reboots the CD will be a litral year instead of just until the end of the current year.
<br>-Fixed: Dragonballs should no longer bug into the void after a reboot. (Except for this update)
<br>-Fixed: Give EXP verb for admins in the assess sheet.
<br>-Changed: Splitforms now have 3 times less durability but the amount you can make went from 1 to 5.Also they have 20 HP instead of 100.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.95 - Logs,Logs,Logs - 03/31/22
<br>-Changed: Hyper Enzymes bonus changed from 1.5 extra regen to 1.25 , regen math changed to don't make it super OP as well.
<br>-Changed: Split form limit is now 1.
<br>-Changed: Many ECs list members.
<br>-Fixed: Dragonballs/artifacts that have no name will be now fixed with the "Artifact Fix" verb for admins.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.94 - minor fix - 03/24/22
<br>-Fixed: Grand explosion spam is gone now.
<br>-Changed: You don't need a confirmation while using Grand explosion anymore.
<br>-Fixed: Bio android incline changed to 0 , now they stat with 100% body instead of 50%
<br>-Fixed: Androids gravity is now 5.
<br>-Fixed: Bio android gravity is now 5.
<br>-Changed: minimum mining level for mining deep changed to 2.
<br>-Changed: KO msg is now purple , so you don't miss who KO who.
<br>-Changed: Now when you reincarnate you keep some of your fishing/cooking/smithing/mining levels and exp.
<br>-Changed: Moved some of the admin commands from right click to the assess window.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.93 - Overflow BP - 03/17/22
<br>-Added: Selling fish/ores now tell you how much you made.
<br>-Added: New admin option in assess , they can now restore the WP of someone easly.
<br>-Added: New admin verb to remove all the fires in the universe in one go.
<br>-Fixed: Bug where you never stood up if you were at 0WP inside a regen tank.
<br>-Fixed: Android Absorb description.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.92 - Overflow BP - 03/14/22
<br>-Fixed: Beams now colide.
<br>-Added: Androids now can check how many components and what android level they have in the stat panel.
<br>-Added: BP overflow , for each 110 EXP overflow you have you will get 1% BP.It stop at 5% BP with 550 overflow BP.
<br>-Added: Admin tool Who , will now show the amount of EXP Overflow , EXP and MPs the players have left.
<br>-Added: Admin tool Reward EC , it will give the reward for the ECs in the way it must be done.
<br>-Updated: Admin restore now reset the anger system.
<br>-Added: DragonBalls now scatter in their corrct planet when they are scattered.
<br>-Added: DragonBalls wishes: Adminwish(Bargain with us) , Mana , Resources and Revive.(More to come soon)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.91 - Fixing - 03/14/22
<br>-Fixed: Now if you sell fishes for mana it will give you mana and no resources.
<br>-Fixed: Artifacts bug where it didn't matter what you set the BP power of them you always were at 1 BP when holding it.
<br>-Added: Test Flee , you can now do a test roll to check your flee chances.
<br>-Fixed: Herans being taxed when trying to gather mana.
<br>-Fixed: Powering up down or using stabilization power will only be hear 1 tile away (No more spam calls with audio)
<br>-Added: New admin verb , Give EXP , will give EXP to a player in a proper way without bugging them.
<br>-Added: Saiyans and Changelings tails now counts as old rods for fishing , happy fishing day.
<br>-Added: Namekian Counterpart now give you hivemind , so you can speak with your counterpart no matter where he is.(Verb name is hive mind)
<br>-Removed: NPCs are removed just in case it make the rollback bug happens.
<br>-Removed: No more closing time song that will rape your ears.
<br>-Added: More bugs to fix later.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.90 - Quick fix before wipe - 03/11/22
<br>-Fixed: Senzu bean now heal all your limbs from being maimed or broken status.
<br>-Fixed: Senzy beans now heal you 60 WP if they are full , 30 WP for 1/2 , 15 WP for 1/4 and 7.5 WP for 1/8.
<br>-Added: Narrations in each planet now can be changed in game , no longer coder needed for it.
<br>-Changed: AL remap to fit our current AL status
<br>-Added: Mining bag , forge , advance forge , stove and repair kits to magic.
<br>-Fix: Deep pockets and magic/int mod now affect the update verb
<br>-Fix: Mining drills and magic books start at lvl 1 , as they should.
<br>-Changed: Since stances are something that every single one of us have , with 350 lifeEXP the game will let you buy a stance for 0 EXP.
<br>-Added: More bugs to fix in the future.
<br>-Changed: Solar flare range can now be set by the user to a max of 10 (20x20 square).
<br>-Added: Time freeze now counts toward flee roll.
<br>-Changed: All the CDs of T4s have a minimum of 15 sec now.
<br>-Added: New Languages: Oni , Changeling , Earthling , Makyojin and Spiritual.
<br>-Fixed: Common language is now the easier language to learn by far instead of the saiyan language.
<br>-Changed: Every planet now have his planetary language (Arconia have Arconian, Vegeta have Vegetan, Earth have Earthling, Namek have Namky)
<br>-Changed: Every race now have his own Language and is now harder to learn it.
<br>-Changed: Oozaru BP mult from 2.1 to 1.3 and def mult to 0.75 from 0.3 (Now is not an insta "I win" button)
<br>-Changed: To make kaios or demons now you need 990 EXP life time and magic level/int level 40.(Aka day 7)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.88 - Anger system - 03/8/22
<br>-Changed: Anger in lethal combats.
<br>-Added: Anger system , this system will send you back to 50% HP if your current HP reachs 0 (Or the max HP that is allowed by your WP if you WP is lower than 50)
<br>-Info:
<br>	The conditons for the new anger system to happen are the next ones:
<br>	+You must be in a letal fight (with your lethal tracker up)
<br>	+You can't be in RP mode
<br>	+You must have more than 1 WP
<br>
<br>	In addition to the conditions , this system works with the team system , here are the changes for it:
<br>	+Now every lethal fight where more than 2 players take part (More than 1vs1) must use the team system.
<br>	+While you are in a team your chance to proc the HP regen is lower by 20% per player who join your team.So if you are in a 3 vs 1 , the 1 have 100% chance to get the HP regen and the 3 have a 40% chance.
<br>	+You can't get the HP proc work if someone inside your team make you reach 0 HP.
<br>	+When you make someone else proc the HP regen , the next time you hit him and send him down to 0 HP he will be KOed and no HP regen will proc.
<br>	+All this will reset in the next round automaticaly.
<br>
<br>	(More changes might come in the future updates about this)
<br>
<br>-Added: New Team verb , view team.You can now see the team of anyone around you in a pop up window.
<br>-Added: The game will send a msg to let you know when you trigger the new anger system.
<br>-Added: When you are KOed in a lethal and emote a 30+ more words , it will reset your anger counter.
<br>-Removed: Refuse to die MP and mechanic is now removed from the game to test the new anger system.
<br>-Changed: Bio android semi perfect form now only gives 1.3 BP
<br>-Changed: Bio android perfect form now only gives 1.9 BP
<br>-Changed: Bio android FBM lowered from 1.9 to 1 (You better absorb or become weak as hell)
<br>-Changed: Tuffle god ki FBM from 1.27 to 1.18
<br>-Changed: Alien god ki FBM  from 1.2 to 1.18
<br>-Removed: Bio android super perfect form is now removed from the game.
<br>-Added: Granades, ki bow, Guns, Nukes, Time freeze, Blast, Charge, Mortar Charge, Exploding Bolt, Death Ball, Spirit Bomb, Genocide, Scatter Shot, Hellzone granade, Kienzan, Kikoho, ExplosiveDemonWave, GuideBomb, Barrage, Block_The_Sky, BurningBlast, Blaster_Meteor, Dragon_Nova, HyperTornado, Shockwave, KillDriver, IceArrow, MegaBurst, PressurePunch, RockThrow, RockSlide, RockTomb, SuperGhostKamikazeAttack, SkyBreak, EchoingSlash, Frost_Bolt, Fireball, SpiritBall, WallofFlame, FireLionsRoar, BlueCometSpecial, AndroidShip (Yes they ship can fire lazers)     now trigger the new anger system.
<br>-Changed: The max amount of members inside a team went from 5 to 25.
<br>-Added: Every single melee/sword/unarmed move now triggers the new anger system
<br>-Added: Every single beam now triggers the new anger system.
<br>-Fixed: Being the owner of more than 1 CP was making bugs when setting taxes.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.86 - More options for Artifacts - 03/2/22
<br>-Fixed: Artifacts now are now un-equipped if they have 0 durability.
<br>-Fixed: No more than 1 artifact can be on the same tile at the same time.
<br>-Fixed: Artifacts not been able to give skills and other special traits at the same time.
<br>-Added: Artifacts now let you have extra int/magic levels , Death regen charges , avoid taxes , gives android ship controls and can change your max HP/WP.
<br>-Added: Demon Gate skill , it will allow you to make as many demons as you want for free with 1 Year CD (Only able for Artifacts)
<br>-Added: Angelical Doors skill , it will allow you to make as many kaios as you want for free with 1 Year CD (Only able for Artifacts)
<br>-Added: Artifacts have now an special inspect/examine window.
<br>-Added: Artifacts now let you have extra unarmed/evasion/sword skill , extra gravity mastery , more anger level , change your age , android levels , alignment , let you build , extra cooking/mining levels , cyber limbs , hive mind , ignores broken limbs , be inmmortal, change your incline age , have precognicion ,  change the teach slots and flee roll.
<br>-Added: Demons/Onis/Demigods/Kaios will know when a demon/kaio cross the realm with the demon gates or angelical doors skill.
<br>-Change: Medical assessment now don't delete itself after being used and it will give the information in an pop up window.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.84 - Sounds are back , with bio androids as well - 02/25/22
<br>-Added: Artifacts can't be grabbed by anyone else but the last owner (If he logs out) for 1 year. (Attempt 2)
<br>-Added: Artifacts now drop when the world save triggers.
<br>-Fixed: custom alien MPs are now free instead of 4 MP each one.
<br>-Added: Sounds to , Powering up , power stabilization , Jump Back , Fly , Land , Buff up , Throw , KO , Hit , Dodge , Chakra block , Block , Ripost , Guard break and Decisive blows.
<br>-Added: Sounds to , Blast , Charges, zanzoken , explosion , Death Ball , Mortar Charge , Spirit Bomb , Genocide , Scatter shot , DestructoDisc , Kikoho, Explosive Demon Wave , Time freeze
<br>-Added: Sounds to , Make weight , make fruit , IT , False moon , Absorb , Cybernetic Limb , StunGun , Seance , Advance Seance (Careful while playing with ghosts !) , Empowered attacks , empowered defenses , frost nova , frost bolt , fireball , lighting bolt , enchant , create portal , rejuvenate , accelerate , conjure.
<br>-Added: Sounds to , Split Form , all of the beams , Hyper Tornado , Dragon Nova , Blue comet sSpecial , Blaster Meteor , Mega Burst , Rock throw , Rock slide , Rock Tomb , Super ghost kamikaze , Hell zone granade.
<br>-Added: Sounds to.... everything , if I miss anything let me know.
<br>-Added: Makyo star now have light , it will light all the planets and realms (Even space) with red for as long as it stay around.
<br>-Added: Bio android to the EXP window for 500 EXP and year 10 if you have 5 int mod.
<br>-Added: You can only make 1 bio android in your enteire character life spawn.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.83 - Artifacts Update - 02/18/22
<br>
<br>-Added: Artifacts drop when you log out.
<br>-Added: Artifacts can't be grabbed by anyone else but the last owner (If he logs out) for 1 year. (Attempt 1)
<br>-Fixed: Tax CD for faction should work now , 1 year CD between uses.
<br>-Fixed: Artifacts lossing their description.
<br>-Added: You can now sell Fishes and Ores for resources or mana.(The amount of mana/resources you gain from them is related to your int/magic mod mining/fishing skill)
<br>-Removed: Fishing Lures and Prospecting tool kits are no longer in game to avoid infinite money loops.
<br>-Added: Now you need a Heart of the mountain and the old amount of money/mana in order to restore limbs.
<br>-Added: You can't change the icon , color or name of Artifacts.
<br>-Fixed: Dragon balls are back to the game , they now scatter around the universe (1 per planet max) and follow the same rules as Artifacts (You can't have more than 1 at the same time , if you log out you drop it and have a 1 year CD until someone else can grab it,if you have one in your inventory your energy will show as "Mysterious" in the sense skill)
<br>-Added: Artifacts can't be stored inside Vending machines nor Chests anymore.
<br>-Added: While you have an artifact is impossible for you to buy anything from the EXP window (Just need to drop it and you can see the screen again is mainly to avoid bugs)
<br>-Fixed: When you loot or mug someone who have an artifact you now lose all the benefists from the Artifact you had.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.82 - Artifact Update - 02/15/22
<br>
<br>-Added: Artifacts can now be made by any admin.
<br>-Added: Admin tool to find where and/or who have Artifacts.
<br>-Added: You can now make 4 types of artifacts , Armors, Weapons, Consumables and Objects of power.
<br>-Added: Artifacts can buff bp, energy, str, force, endurance, spd, off, def, recovery and regen.
<br>-Added: Artifacts can now give crit, avoid crits, be only saw if you are invisible, inmmune to dmg, have inf HP and durability.
<br>-Added: Artifacts can't be enchanted anymore.
<br>-Added: Artifacts can be sould bind (No one can steal them from you not even if you die).
<br>-Added: Artifacts can now grant you extra EXP and MPs.(the number not the skills).
<br>-Added: Artifacts now appear in the sense tab as "Mysterious energy".
<br>-Added: Save age to the who admin window.
<br>-Added: Tax controls now have a 1 year CD after used.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.81 - Tax Tax Tax Tax - 02/09/22
<br>
<br>-Added: Makyo star now have his own light and will be casted in all the planets for as long as it stay up.(Currently disable)
<br>-Added: In the status tab you can now see the current owner of the planet followed by his faction.
<br>-Added: Having the control point of a planet will give the owner RPP.
<br>-Added: You can now tax up to 90%
<br>-Added: You can't ignore taxes any longer.(Not retroactive for the current wipe)
<br>-Added: New admin tool to manipulate the max RPP the owner of control points can have.
<br>-Added: New admin tool to forge artifacts ( Still in beta is just a window chill)
<br>-Added: Disclamer to the flee and chace rolls , they are all IC now.
<br>-Added: New Admin tool to stop/start the day and night cycle.
<br>-Added: New admin tools for weather: Blizzard , Blood rain , Dust storm , Makyo Star ,Earthquake , Flood , Force moon , Hurricane , Ice storm , Light snow , Light Storm , Snow Storm , Strong Winds , Super Volcano , Volcano , Tornado.(disabled pending lag testing)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.80 - All Of The Lights - 02/08/22
<br>
<br>-Added: New admin tool to replace all the buildings in a Z plane made by 1 player for anything they want.
<br>-Added: New admin tool to replace all the tiles inside X,Y,Z coords.
<br>-Added: Water levels , only for mapping.
<br>-Fixed: Enlage option for admins , it will now allow you to input X and Y variables and it will auto center the icon.
<br>-Updated: Day and Night cycle , now is automatic and will change each week.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.79 - God Ki Rework- 02/05/22
<br>
<br>-Reworked: God Ki should no longer be required for Ascension or era transformations. Now changed to a BP req. Will need tested, so bare with us.
<br>-Removed: Admin Other from all the players is gone , thanks for the testing and reports.
<br>-Added: Caves/Underground now are permantly in dark ,Not absolute dark , around 75% of total black.(This is the first step for day night cycle)
<br>-Added: Blast now glows in the dark (And a little in the day)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.78 - Fuck Grab- 02/04/22
<br>
<br>-Fixed: Throw/Megaton Throw/Pile drive , any related grab and throw skill.(Test number two)
<br>-Fixed: Grab bug.(Thanks Weasker :D )(didn't work D:)
<br>-Fixed: Elixir Of Life , Majin , Blade Of Light , Way Of The Open Palm and Precognition description.
<br>-Fixed: Grab/throw/Piledrive/ any skill related to grab bug , where you run in diagonals when you spam it.(First attempt)
<br>-Added: New faction control window.
<br>-Added: 100 Food icons.
<br>-Added: Fish when cooked now will have 1 of the food icons , is random.(And yes , all of them still taste like fish)
<br>-Added: Weather , rain , thunderstorm and snow.(Only working for Afterlife)
<br>-Added: Ahelps will have a sound now , so you can hear if we PM you back.
<br>-Added: Grab now have 10 charges and then recharge in 5 seconds.
<br>-Fixed: Skeleton and Cyber limbs extra HP now stack instead of being replace , max HP for limbs is now 200HP if you have both at the same time.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.77 - The begining- 01/30/22
<br>
<br>- Added:100 new icons to the build menu.
<br>- Re-Added the old inventory tab , the new one pop up window remains if you want to use it as well.
<br>- Re-Worked the math behind the Combat Power variable (The one that is over the battle power when you target someone).
<br>- Fixed:Moved the combat tab BACK to the chat box.(The pop up should work as well)
<br>- Fixed:Admin Sheet Assess fixed.
<br>- Fixed:Hypermetabolic Digestive Enzymes , it will now actually buff your regen.The nerf on it was "removed" (never was coded in, so description updated).
<br>- Fixed:Deep mine spam bug , where you could get trapped in the mine if you spam the skill more than once.
<br>- Fixed:Imitation bug where your Energy signature reset the contacts.
<br>- Added:Now you can tell if someone is imitating someone if you check the energy signature of your target and compare it to your contact info.
<br>- Fixed:Megaton throw blocking you from doing anything else grab related.(Test number one)
<br>- Fixed:Mortar Charge exploding in your face , it have a 3x1 size.(It will spawn right in front of you so keep in mind , meele mortar charge might now work anymore).
<br>- Fixed:Vegeta and Earth Area not being placed on the planet , this made you able to sense players from Earth on Vegeta and the other way around.
<br>- Removed:Icon from Target ,this might fix the status tab lag.
<br>- Removed: Admin log X player connected spamming in the admin chat.
<br>- Removed: Admin log X player entered the HBTC chamber spamming in the admin chat.
<br>- Added: Day and Night Cycle for testing.(Only working for Afterlife)
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.76 - The Great Retuning (Hotfixes)- 1/04/22
<br>- Android Components now come out at the same time as chasis (Reflected in the charts already, just kept forgetting to change it)
<br>- Fixed Mark of the Beast
<br>- Fixed Speed stacking after KO on Thundering Blows / Bleeding Edge
<br>- Some descriptions updated to reflect actual effects. Please continue to list incorrect descriptions in discord.
<br>- Switched some auto learns from > to >= which will allow them to come out slightly earlier.
<br>- Fixed some typos in the admin Assess window (Thank you Kael)
<br>- RP Rewards should now trigger if you have any EXP in Overflow. Should make it more consistent.
<br>- Most auto learned abilities should now come out by wipe day 2.
<br>- Fly moved to come out on wipe day 4.
<br>- Stat gains increased. Please see discord for discussion regarding future caps.
<br>- Removed gains above 1.05x the BP cap. More noticable extremely early in the wipe.
<br>- Spirit Sword should now be correctly refundable.
<br>- Death Zenkai heavily nerfed to prevent a possible issue. As we don't have an after life, better to just ham fist nerf it than to observe.
<br>- Drills/Pylons now remind people to bolt them when they're created.
<br>- Cyberize should now correctly check MOD rather than Ranks, since I broke that when I adjusted INT mod to be a flat MP cost
<br>- Event Characters should no longer proc Refuse to Die or Decisive Blows
<br>- Refuse to Die and Burning Desire for Victory are now 1 hour cool downs (Reduced to a 10 minute cool down with the Refuse to Lose milestone)
<br>- Burning Shot's BP buff timer should now match it's description.
<br>- Significantly lowered the Resource/Mana cost on some non-group Tech/Mage abilities.
<br>- EXP Catch Up will remain in effect until you are 330 EXP from the cap, rather than 880.
<br>
<br>
<br>
***Roleplay Tenkaichi version 1.75 - The Great Retuning - 11/29/21
<br>
<li>- Leave Planet can now be learned on wipe day 19 with the Flight Master MP.
<li>- Removed the Visit Living Realm verb from dead players. Get seanced.
<li>- Speed now contributes 30% of it's total to off (Up from 17%)
<li>- Speed now contributes 30% of it's total to def (Up from 15%)
<li>- All characters start with 8 MPs at creation. Humans start with 10.8.
<li>- Alien Milestones now are a 0 cost and only one may be chosen.
<li>- Make a SSJ4 will now show up in the EXP window for Techies/Mages on wipe day 41 (God ki era)
<li>- Power Control is now auto learned on Wipe Day 3 instead of being a BP requirement.
<li>- Focus is now auto learned on Wipe Day 7 instead of being a BP requirement.
<li>- Muscle Force and Magic Force are no longer auto learned. Instead, when you learn Focus, you will have the option to select between five different buffs - Each buffs a different stat category (Strength, Force, Endurance, Offense, Defense)
<li>- After purchasing two Tier 1 buffs from the EXP window after learning Focus for free, the other buffs can also be purchased for EXP.
<li>- The Genius and Mystical MPs have been removed from Custom Aliens.
<li>- The 'Pilot' MP has been removed. You no longer need an MP or an INT mod to pilot ships, just physical access.
<li>- Bulls Eye MP cost increased from 1 MP to 2.
<li>- The 'Passive Increase' MPs have been removed. Passives will now train twice as fast as before.
<li>- One-Two Punch price increased from 2 MPs to 3
<li>- The NRA Membership and Elite Gun Training MPs have been removed, pending a gun rework.
<li>- Desperate Struggle increased to a 4 point cost up from 3.
<li>- Will Unbroken dropped from a 4 point cost to 3.
<li>- Zanzoken Mastery down from 5 MPs to 3.
<li>- Hammer Time reduced from 5 MPs to 4.
<li>- Way of the Fist reduced from 5 MPs to 4.
<li>- Smolder increased to 8 MPs from 6. Damage ticks nerfed from 50% damage x 3 to 10% damage x 3. Description updated.
<li>- I Studied the Blade MP removed.
<li>- Way of the Open Palm reduced in cost from 8 MPs to 6.
<li>- Armor buffed across the board. SPD values unchanged, but each has been increased in Endurance.
<li>- Copper Armor 1.15 END -> 1.2 END
<li>- Bronze Armor 1.18 END -> 1.25 END
<li>- Iron Armor 1.23 END -> 1.3 END
<li>- Silver Armor 1.18 END -> 1.3 END
<li>- Mythril Armor 1.03 END -> 1.2 END
<li>- Masterwork Armor 1.0 END -> 1.15 END
<li>- Auracite Armor 1.2 END -> 1.27 END
<li>- Pursuit of Knowledge reduced from 8 points to 4 points.
<li>- INT/MAG milestones will now cost 2 each instead of a scaling cost. (4 ranks, 2 points each)
<li>- Elixir of Uncertainty readded.
<li>- Turtle Shell buffed from 10% End per rank to 15%
<li>- Eat the Rich/Midas now kick in at 50 million resources rather than 100 million.
<li>- Fast Matabolism reduced from 10% damage reduction to 5%.
<li>- Side swipe nerfed from 30% flat accuracy to 10%.
<li>- Cleanse the Wicked now stacks 3 times instead of 2.
<li>- Bleeding Edge no longer reduces speed.
<li>- Thundering Blows no longer reduces speed.
<li>- Grime Reaper now stacks to 3, for 15%
<li>- Challenger's Mark now no longer causes you to take increased damage from those you don't have targeted.
<li>- Anchor Arms reduced to a 4 MP cost, and a 10% benefit (Up from 5%)
<li>- I Like to See You Bleed reduced to a 6 MP cost, +15 WP on a KO (Up from 10)
<li>- Double Attack now has a 20% chance to do a double tap, up from 18%.
<li>- This Drill Will Piece the Heavens increased from ignoring 10% END to 20%.
<li>- Refuse to Lose reduced to a 4 MP cost and description updated to be more clear.
<li>- Mining Expert now increases your END by 2%
<li>- Mana Expert now increases your DEF by 2%
<li>- Moral Compass is now 4 MPs, but now increases your OFF or DEF by 1.1 rather than 1.075 when at a certain alignment.
<li>- Hemophilia now increases your offense by 2.5% (flat addition) in addition to it's other effects.
<li>- King of the Sea now increases your defense by 2.5% (flat addition ) in addition to it's other effects.
<li>- Fire Lord now increases your might by 2.5% (flat addition) in addition to it's other effects.
<li>- Float like a Butterfly now gives 5% defense in addition to it's other effects.
<li>- Agile Nature now adds 5% offense and Defense in addition to it's other effects.
<li>- Bojack now comes out on day 21 rather than day 25
<li>- Super Bojack 2 now comes out on day 31 rather than day 35
<li>- Heran BPM from 2.3 to 2.2
<li>- Heran Strength to 1.9
<li>- Heran Speed to 1.8
<li>- Heran Defense to 1.7
<li>- Heran Offense to 1.8
<li>- Bojack to 1.6 BP, 1.2 strength, 1.2 endurance
<li>- Super Bojack no longer gives Endurance
<li>- Heran FBM lowered from 1.58 to 1.55
<li>- Heran Ascension multi raised from 1.16 to 1.17
<li>- SSJ now comes out on day 21 rather than day 25
<li>- SSJ2 now comes out on day 31 rather than day 35
<li>- Saiyan Strength, Endurance, Speed, Offense, and Defense lowered from 1.8 to 1.7
<li>- SSJ now gives 1.2 Endurance
<li>- SSJ2 lowered from 1.3 to 1.2 BPM
<li>- Saiyan FBM increased to 1.7
<li>- Saiyan god ki multi lowered to 1 from 1.02
<li>- Super Namekian lowered to day 21 from day 25.
<li>- Guns Removed, pending rework
<li>- Embrace the Future increased to 6 MPs, but now reduces the regeneration penalty on limbs by 80%
<li>- Master Blacksmith now increases your effective mining/smithing level by 15 and doubles your chance of finding a Heart of the Mountain.
<li>- Energy Movement Milestone removed
<li>- Keep your Enemies Closer is now 10% damage at 50 CP.
<li>- New Milestones below
<li>- Desperate Resolve - 20% more Endurance when below 50 WP
<li>- Desperate Maneuvers - 20% more Defense when below 50 WP
<li>- Desperate Speed - 20% more Speed when below 50 WP
<li>- SSJ4 Regen down from a 1.5 multi to 1.2
<li>- Nanite Burst no longer prompts for confirmation and no longer costs resources. CD increased to 4 minutes, not reduced by refire.
<li>- PileDriver now scales off of Offense rather than Strength. Baseline Damage reduced from 5.5 to 4.0.
<li>- Earthquake now scales off of Offense rather than Strength. Baseline damage reduced from 5 to 3.5.
<li>- Explosve Wave now scales off of Offense rather than Force. Baseline damage reduced from 5 to 3.5.
<li>- Axe Kick base damage increased from 2.5 to 5. (Note: 1:1 testing showed this ability dealing 3.51 damage. This change should make that 7 damage.)
<li>- Wolf Fang Fist base damage increased from 2 to 3. (Note: 1:1 testing showed this ability dealing 5.23 damage over three hits. This should make that closer to 7.5-8.)
<li>- Quick Jab, a new skill for Unarmed/Gauntlet users that functions similar to Slice, unlocked at the appropriate Unarmed skill.
<li>- Metal Skeletons no longer make you sterile.
<li>- Ritual of Power now undoes your BP nerf from magic milestones completely, but only lasts through the next year (current year + 1). Cool down is now 2 years. Cost reduced from 700,000,000 mana base to 50,000,000 mana base. (10 million at 5x mod)
<li>- Arcane Power (Unique Buff) now undoes the BP loss from Magic Milestones, but also disables ritual of power.
<li>- EXP cap now raises daily at a rate of 110 EXP. The cap will start at 330 EXP due to slowed time at wipe start.
<li>- The cost of a custom stance has been lowered from 400 to 330 EXP.
<li>- EXP Over Flow introduced. When you're RPing and already at the cap, you will gain progressively lower EXP that will go into your Overflow. When the cap raises, on your next emote, the EXP within Overflow will be added to your EXP up to the next cap.
<li>- Namekian base regen down from 4 to 3.
<li>- Unique Buffs have all had their modifiers redone. Please see Discord for the complete list.
<li>- Focus down from 1.25 Regen to 1.15
<li>- Mobs no longer drop tokens.
<li>- Removed references to IP address in the player variables. (Note: Admins, if you find more, let me know)
<li>- Empowered spells from Magic now have a flat CD of 240 ticks.
<li>- Ki Hammer now works off 100% Force and no strength. Weapon BP increased to 80%.
<li>- Spirit Sword is now based on 100% Force and no strength. Weapon BP up to 60% and speed nerf gone.
<li>- Blade of Light with Spirit Sword no undoes the offense nerf rather than reduce the speed loss (see above)
<li>- Spirit Doll FBM increased from 2.0 to 2.1
<li>- Spirit Doll second ascension reduced from 1.2 to 1.14
<li>- Swole Doll now gives 1.2 speed (up from 1) in addition to it's other effects.
<li>- Changeling forms should no longer require a base level of EXPLifeTime (Though the intention was good, it ended up just creating even more of a grind late wipe for new characters)
<li>- Piercer (Tier 4 beam) had it's damage tripled. It was really bad.
<li>- You will no longer auto-learn select INT/MAG skills unless your INT/MAG is greater or equal to 5. Instead these will now scale down in cost via the EXP window from 2-4 INT/MAG. A list is in Discord.
<li>- Tuffles will still auto-learn Tech moves.
<li>- Makyo will still auto-learn Magic moves.
<li>- Pods and Ships no longer have a cool down to launch. Rocket boosters removed.
<li>- Items that come out before 60 INT/MAG have had their prices adjusted to reflect the earlier availability of INT/MAG milestones.
<li>- Tier 3 ships are now unlocked with an INT mod of 5 rather than 6. Ships have had their prices increased.
<li>- Power Armor redesigned. Now comes out at the same time as Ritual Of Power. No longer buffs BP, but will remove the BP loss from INT milestones.
<li>- Due to the above, Power Armor has had it's cost adjusted so that it is now as expensive as Cyberize.
<li>- Power Armor Endurance increased from 1.13 to 1.3 (More in line with other armor)
<li>- Power Armor now requires an INT mod of 3 or the New Type milestone to pilot.
<li>- the Resist skill now comes out at year 5 rather than being based on Energy.
<li>- New admin tools (Thanks Kael!)
<li>- Updates to the Vegeta and Space Station maps (Thanks Kael!)
<li>- New icons for ore added. (Thanks Kobold!)
<br>
<br>
***Roleplay Tenkaichi version 1.74 - Resurrected Edition - 10/2/21
<br>
<li>- Reduced anger mutation from 1.1 to 1.05
<li>- Removed the extra roll for a STR mutation for offsprings. Mutations now roll 1d8 rather than 1d9.
<li>- Configurable Bombs removed from the tech list.
<li>- Bio Android and Majin removed from the EXP list until they can be rebalanced. Don't ask admins to make one - You'll be denied, no exceptions. Hopefully they'll return soon.
<li>- Ascend can't be purchased until wipe day 20+.
<li>- Unique Buffs can't be purchased until wipe day 31+.
<li>- Increased base cost of UBs from 5k EXP to 5.6k (Don't panic, read the line below this)
<li>- Reduction per Point towards a UB increased from 100 to 220
<li>- Max points towards reduction on a UB lowered from 40 to 25
<li>- Net result of the above is that a UB is equal in cost at 20 points to Limit Breaker - A point being 110 EXP spent on a move or 1 milestone point spent on something that counts towards a UB reduction.
<li>- At 25 points towards a UB, that UB is free!
<li>- Fusion Dance removed from the EXP list.
<li>- Removed the print out that said which Milestones gave points towards which UBs. Note: With how cheap UBs should be now, this is being removed to prevent people from trying to min/max.
<li>- Event Characters are now given their EC kit after initial character creation. Special thanks to Jheckaboi for helping me to understand the initial problem and working with me to get it resolved.
<li>- Kanassans finally have a spawn point, and it isn't at the mouth of the river.
<li>- After much yelling and in fighting on the admin team, Yardrats now start with IT. I hate it.
<li>- Level 4 admin exists and has power again.
<li>- Infinite fire finally fixed. Currently it's long fire, but will eventually burn out.
<li>- Ships maybe fixed. I think.
<li>- Planets won't vanish on reboot now.
<li>- Think I cleared all of the old discord webhooks.
<li>- Removed underground gravity increases.
<li>- If your willpower is at 0 you must once again wait out the combat tracker before standing up, or get outside help.
<li>- You can once again use the injure verb when your target is at or below 70 WP.
<li>- (Heran) Mug can now steal items if your target is at or below 50 WP.
<li>- Coolers now correctly unlock their forms without admin intervention. Check the charts when released for info on when these become available, but the game will indicate in a message when you have them.
<li>- Mana pylons should no longer allow you to downgrade them by mistake.
<li>- Lowered some EXP lifetime requirements on Changeling forms to reduce the grind for newer players.
<li>- EC characters now given 550 lifetime EXP at creation so that they can actually use the injure verb.
<li>- EC characters given +15 to their flee roll so that they can exit a situation if they need to go for OOC reasons rather than having to rely on self-destruct all the time.
<li>- Fixed an issue with Kolds related to max WP (Change is not retroactive - If you made a Kold prior to this patch, please admin help to be fixed)
<li>- Reduced Blue Comet Special's damage by about 85% (Removedf a x7 multiplier that was on it) More tuning may be needed.
<li>- Super Ghost Kamikaze reduced from x10 damage to x3
<li>- Hyper Tornado damage reduced from x10 damage to x3
<li>- The SaveYear proc now runs at year tick. This should prevent us from rolling back several months on crashes.
<li>- Reduced the cost to revive someone for Techie/Mages from 750 EXP to 550 EXP
<li>- Limit Breaker cost reduced to 500 EXP
<li>- Regenerator Pods now instantly heal you to 1 WP, even if your combat timer is active.
<li>- Explosion now has a proper CD (User Refire x 2) Minor update: shouldn't require you to target another player, either
<li>- Greatly increased BP gains on the base game up to the current cap. Note: Over caping untouched.
<li>- Nerfed the temporary BP boost of Book of Power from 1.2x to 1.05x. BPM increase untouched.
<li>- Half-Humans now receive 1.35 MPs per MP tick.
<li>- Attempt at a grenade cooldown fix. All grenades have a shared cooldown which should be equal to the user's refire.
<li>- Added Offensive Force, Enduring Force, and Dodging Force. Currently unavailable to players while we test them / evaluate the numbers.
<li>- Shield buffed from 1.05 endurance to 1.1 endurance (1.15 with the Shield Master milestone)
<li>- New skill: Quick Jab. Slice but for unarmed users. Not currently available, but added for testing.
<br>
<br>
***Roleplay Tenkaichi version 1.73 - Cheese: Just Cheese, Nothing Else - 1/13/2021<br>
<br>
<li>- Some stuff I didn't write down.
<li>- Added cheese to NPC drops.
<li>- Catch up EXP now applies if you are more that 880 EXP away from the cap in addition to when you have RP rewards. These will both stack.
<li>- Misc fixes
<br>
***Roleplay Tenkaichi version 1.72 -   - 1/10/2021<br>
<br>
<li>- Some tweaks
<li>- Bound Weapon refund and nerf. (Does not increase force)
<li>- Upgrade Android can now be used on yourself.
<li>- Misc fixes
<br>
***Roleplay Tenkaichi version 1.71 -  - 1/06/2021<br>
<br>
<li>- Willpower will now recover to 1 after being 0 WP for a few minutes. You still need to wait out the combat tracker in order to restore WP.
<li>- Some tweaks
<li>- Misc fixes
<br>

***Roleplay Tenkaichi version 1.70 - While You Were Roleplaying, I Was Studying The Blade - 1/04/2021<br>
<br>
<li>- Anger mutation buffed to +10% from +5%.
<li>- Piercer and Tyrant Lancer now deal damage with Offense instead of Force.
<li>- Non deflectable attacks now penetrate all beams.
<li>- New 2 point MP: Energy Movement, allows you to use zanzoken while charging or firing an attack.
<li>- New 4 point MP: Cleanse the Wicked, deal +5% per kill your target has up to +10% damage.
<li>- New 8 point MP: I Studied the Blade, get a Bound Weapon skill that is essentially a weapon-stance. It counts as both a sword and hammer and can not be used with a regular weapon or ki weapon. (Works with weaponized ki)
<li>- New 8 point MP: Icy Grip, causes attack verb to apply a slow and have a 20% chance to stun for 1 tick, lasts 10 seconds.
<li>- Shield fixed
<li>- Stat gains boosted
<li>- Magic Mod 4+, level 53+ spell, Fireball added. Decent damage, causes burns, homes
<li>- Magic Mod 5+, level 65+ spell, Accelerate added, Grants someone the speed buff, which negates slows and increases hit chance and movement speed.
<li>- Majin absorb fixes
<li>- Refunding an MP now refunds all ranks of it.
<li>- Beam CD increased, drain increased
<li>- New Tier 4 Melee, Torrential Strike Launches an attack that drowns your opponent in a torrent of water and creates water tiles that last for 20 seconds. Drains energy equal to half the damage dealt. Water tiles drain energy and count towards King of the Sea
<li>- All absorbs standardized to only be +30% Base as a 'Absorb BP variable', no longer grants base.
<li>- Boosts to gains inside Majin and while in AL/KSP
<li>- Fixed issue with revive
<li>- 3 Ki Bow skills added, Tier 3 Exploding Bolt (Basically Charge for Ki Bow) Tier 3 Block The Sky (Basically Ki Bow barrage) and Tier 4 Ice Arrow (slowing shot)
<li>- Kill Driver buffed, no longer short range
<li>- Explosion CD fixed
<li>- Underground Mines now generate gravity up to the current tech cap
<li>- Verbs added to command all created splitforms directly instead of needing to click on them. Split_Nearest, Split_Destroy, Split_Stop, Split_Click and Split_Target
<li>- Misc fixes
<br>
<br>
***Roleplay Tenkaichi version 1.69 - Heh Nice - 12/31/2020<br>
<br>
<li>- Stance cores added/adjusted.
<li>- Fire actually fixed.
<li>- Smolder damage fixed.
<li>- EXP costs reduced for Fusion, Limit Breaker, Ascend and create SSj4.
<li>- Custom Beam buffed, now has 5 more points to spend.
<li>- Renamed SEW to Super Destructive Wave.
<li>- Changes with Guide Bomb. (You can now cast it again to detonate early)
<li>- Bio form requirements reduced.
<li>- Cloak/Cloak Controls functionality restored.
<li>- Shield fixes(?).
<li>- Force Fields drain quicker.
<li>- Max EXP from an emote now occurs at 420+ words instead of 200.
<li>- New Arcane Power icons, thanks Kobold.
<li>- Inspired added, basically a beefed up Rested exp.
<li>- Languages master faster.
<li>- Tokens of Pride are now worth 50 EXP. Tokens of Virtue are worth 20.
<li>- Swordsman now grats +8% offense while using a sword.
<li>- Hammer Timer now grants +7% offense and speed while using a hammer.
<li>- Misc fixes
<br>
<br>

***Roleplay Tenkaichi version 1.68 - Volk is Poopy - 12/29/2020***<br>
<br>
<li>- Stuff I didn't write down.
<li>- I put out the fires.
<li>- Side Swipe refunded.
<li>- Boundless Stam buffed
<li>- Misc fixes
<br>
<br>

***Roleplay Tenkaichi version 1.67 - Lettus Cinow: Some stuff, don't at me***<br>
<br>
<li>- Fixed RP rewards.
<li>- Renamed world..
<li>- Misc fixes
<br>
<br>


***Roleplay Tenkaichi version 1.66 - Merry Chrystler: Satan Rides Again - 12/25/20***
<br>
<li>- Added back +20% gains in AL
<li>- Christmas gift added to existing characters.
<li>- Misc fixes
<br>
<br>


***Roleplay Tenkaichi version 1.65 - Unplanned Updates: Just Say No, Abstinence Is The Best Policy  - 12/23/20***
<br>
<li>- Female Spirit Doll icons added
<li>- Mating requires 550+ lifetime EXP
<li>- NPC drop rates adjusted
<li>- Fusion Dance now gives you a choice of who controls it
<li>- New genetic sequencer icon, credit to Rikkulesca
<li>- Digging gives energy, BP and gain mult
<li>- Weights now improve stat gains as well as BP.
<li>- Medical Assessments will now show gain mult after a certain point.
<li>- Misc fixes
<br>
<br>

***Roleplay Tenkaichi version 1.64 - Game of the Year Edition  - 12/18/20***

<ul>
<li>-Skills-</li>
<br>
<li>Charge/Beam alerts are now only in the combat tab again.</li>
<li>Tier 4 skills buffed.</li>
<li>Super Explosive Wave and Grand Explosion costs reduced, damage altered.</li>
<li>New Weapon Tier 4: Burning Slash launches a 3 hit combo attack followed by a blast. (First hit gets +25% Force added to your Strength, second gets +25% Force added to Strength and the third gets +50%. The blast deals bonus weapon damage.)</li>
<li>Earthquake and Explosive Wave will now knock the people they hit to the ground. (Will end their flight)</li>
<li>Projectiles with the 'Stagger' status effect will knock people out of flight.</li>
<li>Support moves buffed/fixed in general.</li>
<li>New Archtype: Ki bow added, 3 tiers - Critical Edge can cause ki bow crits</li>
<li>Bow 1 30% Strength and 80% Force</li>
<li>Bow 2 40% Strength and 90% Force</li>
<li>Bow 3 50% Strength and 100% Force</li>
<li>New Misc Tier 4: Spirit Sword 50% str 80% force, +50% BP -30% Spd -10% Off (40% Str 80% Force)</li>
<li>Other smaller tweaks and adjustments too minor to be worth covering.</li>
<br>
<li>-Milestones-</li>
<br>
<li>Having Blade of Light will cause your ki weapon to apply to Weaponized Ki</li>
<li>weaponzied ki and blade of light/ki blade work</li>
<li>Milestone cost adjustments and rebalancing.</li>
<li>Smolder now costs 6 from 5 mp but now affects all ki moves and not just blast/barrage. Burn damage reduced to 33% of damage from 50%.</li>
<li>Anchor Arms: Converts 5% of Endurance into Strength 8 MP</li>
<li>Will Unbroken costs 4 from 3, reduces resist cost to 3% from 5% and gives +5 WP when you get up from a lethal KO.</li>
<li>The Best Defense This will cause any damage you deal to be applied as a percentage damage reduction on your next tick of damage. Stacks up to 10% DR and resets on taking damage. (i.e. you deal 5 damage, get 5% DR) 8 mp</li>
<li>Numerous tweaks, adjustments and buffs.  I suggest looking through the MP window.</li>
<br>
<li>-Mecahnics-</li>
<br>
<li>New system for determining max EXP and catch up.  EXP cap will now build as the wipe progresses instead of resetting every 5 days, meaning you can join late and catch up on the EXP.  After you have qualified for RP rewards, (550 exp within 5 days), you will begin earning catch up EXP at 150% the rate of normal, if you qualify.</li>
<li>Team damage reduction now -30% instead of -40%</li>
<li>Injuring someone now requires 300+ lifetime EXP and killing someone will require 550+. (This is total earned, not available or spent) Killing someone will require the target to be 0 WP and Injure requires 30 or lower.</li>
<li>killing now requires target to be 0 wp, injure/steal requires 30 (herans can loot at 50)</li>
<li>SSj4 now gives 1.5x regen</li>
<li>Ki weapons now reduce attack speed.  (Ki Hammer/Spirit Sword)</li>
<li>Updated EXP costs:</li>
<li>Tier 2 abilities - 220</li>
<li>Tier 3 abilities - 440</li>
<li>Tier 4 abilities - 880</li>
<li>Cost per extra MP - 660 EXP</li>
<li>Stance Learning - 200 XP per step or 400 for your own</li>
<li>Revive - 750 EXP</li>
<li>Shadow King and Arcane Power now only take 1 buff slot, they have been adjusted accordingly.</li>
<br>
<li>-Tech/Magic-</li>
<br>
<li>Some requirements adjusted. (Drugs unlock much earlier)</li>
<li>Mass Upgrade/Mass Enhance verbs added for Drills/Pylons.</li>
<li>Bombs and grenades had their damage buffed.</li>
<li>Techies with 4+ Int Mod can now make a Bio Android for 1000 EXP without the need for admin intervention</li>
<li>Mages with 4+ Magic Mod can now make a Majin for 1000 EXP without the need for admin intervention</li>
<li>Cybernetic limb descriptions updated. If your limb is removed, you will lose any of its cybernetics.</li>
<li>Adamantine Skeleton reduces wp to 0 when applied and no longer grants limb immunity, instead it increases limb HP by +25.</li>
<li>Drills and Pylons can now only hold about 24 hours worth of drilling benefits.</li>
<li>You can now only make 3x your mod in drills/pylons instead of 5x.</li>
<li>Elixir of Life no longer has a penalty</li>
<li>Ship Launch CDs are now in minutes instead of IC years. (200 minutes on MK1, 100 on MK2, 66 on MK3/MK3Pods)</li>
<li>Mutagens now available year 15.</li>
<li>Androids/Spirit Dolls can now be made much earlier.</li>
<br>
<li>-Misc-</li>
<br>
<li>New UI/Menus</li>
<li>Various old systems removed.</li>
<li>New UB System</li>
<li>New base icons, new clothes</li>
<li>Steroids disabled.</li>
<li>New custom zanzoken icons, thanks Kobold! Once you unlock zanzoken, you will be able to use a custom icon or use one of the 15 Kobold provided.</li>
<li>Aliens can now choose a transformation icon by right-cliking on their creation icons</li>
<li>Majin/Mystic are no longer alignment locked and function as true racials.</li>
<li>Mine Deep requires level 5 mining from 10</li>
<li>NPC limit increased to 150 from 100</li>
<li>Chance for "boss" NPCs to spawn</li>
<li>Rested bonus is now only +25% dig/mana gains</li>
<li>Dig/Mana base gain rate decreased by about 20%</li>
<li>You can now reset all tax offenders (affects all controlled planets and both res and mana)</li>
<li>Kanassa disabled, Precognition mp buffed</li>
<li>Grass tiles now also spawn ore</li>
<li>Soul Doll/Swole Doll now combined</li>
<li>Stuff I forgot to write.</li>
<li>Being Chaotic no longer grants BP %</li>
<li>Fusion fixes/rebalance. Purchasable for 2500</li>
<li>Might now grants 1% damage (0.24% to aliens) per point invested</li>
<li>Endurance now grants 1% damage resist (0.24% to aliens) per point invested</li>
<li>Racial balance adjusted and some math errors corrected.</li>
<li>Auto unlocks for ssj/bojack/alien trans</li>
<li>WP restore now applies on each unlocked trans (ssj2/4/blue and bojack2)</li>
<li>Death Anger buffed to +35% from +25%</li>
<li>Tooltips (Only work on map atm)</li>
<li>The cooldown system has been overhauled, less usage on server resources. </li>
<li>Planets: Alien planets get 2x mana/resources, Dark planet has 5x mana, Icer has 5x resources, Vegeta has 2x resources, Namek has 2x mana</li>
<li>Mate year is now year 3.</li>
<li>Taking a UB disables MP and skill refunds</li>
<li>Power Control Expert disabled pending rework.</li>
<li>Item durability decreaseS faster</li>
<li>UBs rebalanced</li>
<li>Due to energy now following the stat cap formula, you can no longer leech it.</li>
<li>Various fixes.</li>
<li>Androids can unlock god ki now.</li>
<li>Changelings get +10 Max HP.</li>
<li>No nerfs to Namekians</li>
<li>Spirit Dolls get +50% recovery ticks.</li>
<li>Space Pirates get +50% dig/mana rate.</li>
<li>Aliens start with 5 MP instead of 4.</li>
<li>Other things I forgot about.</li>
</ul>


***Roleplay Tenkaichi version 1.63 -   - 9/05/20***
<li>- SSJ4 can now be used with god ki.
<li>- Attempts to fix ascension. If it still isn't working properly Trashman will disable it from the purchase window.
<li>- Megaburst removed from Magic learn list as it now exists within the EXP system.
<li>- SSJ2 rebalanced to be more in line with the era. Saiyans given a god ki ascension multi in compensation.
<li>- Barrage is no longer a spammable ability and should function more similarly to Genocide.
<li>- Balance adjustments to the 'auto hit' ki milestones.
<li>- Elixir of Reformation should now function properly.
<li>- Half-Saiyan FBM altered to match saiyan FBM.
<li>- Fixed the update log HTML because I broke it by accident.
<li>- Attempt at disabling the auto-pop up for assigning contacts at introduction due to issues with it (Was asking you to set a contact with yourself)
<li>- Base damage of Rock throw boosted from 1.2 to 3.5 for testing.
<li>- base damage of Genocide boosted from 1.7 to 5
<li>- RacialPowerAdd disabled for all races (This wipe only.)
<li>- Characters now have enough 'total' stats to train all stats to 1.3x the cap. Stat gains will still decrease as total stats increase however.
<li>- Stats now hardcap at 1.3x the cap.
<li>- Bio androids adjusted to fit more in line with where they land on the wipe. Details below:
<li>- Bio Android FBM changed to 2.4 from a 1.1 multi. Note: This will put them on par with other races at FBM.
<li>- Semi-Perfect BPM mult changed to 1 (You will still gain a temporary boost to base as well as several stat mod multipliers) Note: This puts them on par with SSJ2.
<li>- Perfect BPM mult changed to 1 (You will still gain a temporary boost to base as well as several stat mod multipliers) Note: This puts them on par with SSJ2 + Unique Buffs.
<li>- God ki Ascension Mult changed to 1 / Super Perfect now fills the roll of the Ascension Mult so this multiplier is no longer needed.
<li>- ECs: Attempted to fix passive skills not granted on creation. Uses a sliding scale based on year now (125 + (25 x creation year))
<li>- ECs: ECs now receive a sliding scale of gravity mastery after year 10. - ((TechCap-43)*6), before year 11 they start with 50.
<li>- ECs: Increased stat cap to 1.2 over soft cap. Combined with their extra BP this puts them 25% over a standard player.
<li>- Follow system added. Can't be used in lethal and pauses if you take damage.
<li>- MuF/MaF/Focus is now a pure base BP requirement, admin level 4 and above can set the requirement.
<li>- Bug fixes to ECs. MaxWP is now 150 for them.
<li>- Attempt at fixing Admin verb to give control points to players. Should now properly assign FactionLeaderControl to those who are assigned.
<li>- Taking a Control Point from someone now removes FactionLeaderControl from them and gives it to the one that stole it. *Note - This won't effect your factions, this is a backend thing that assigns proper verbs to access the control point.
<li>- Stat print out fixed to match stat cap rates. Yellow indicates you aren't capped, green indicates capped, gold indicates over capped, and magenta represents max. Gains greatly lower as you progress, slowing to a snail's pace at max.
<li>- TotalStats now updates properly as per the above.
<li>- TotalStats now indicates how much further you have to go until the next plateu.
<li>- Event Characters are now set to the max BP cap a player can hit by day.
<li>- Event Characters now have access to a verb to multiply their BP by a value between 1 - 2. This gives us the ability to have differing levels of power for ECs.(Thanks Xiathyl for the help!)
<li>- *Note to EC players - Recommended value to simulate the 'old EC' experience is 1.285 with a buff loadout to match players.
<p>
<br>

***Roleplay Tenkaichi version 1.62 -  -  07/30/20***



<li>- Ring of Experience/Necklack of Wisdom now have a 1 year CD for their passive instead of on MP earn.
<li>- Vamp Absorb now kills
<li>- Fixes (some stuff was fixed)
<li>- Invisibility skill is now equal to Int 99 cloak instead of int 3 cloak.
<li>- You can no longer invest EXP into passives
<li>- Max team size reduced from 10 to 5.
<li>- Evil alignment no longer grants extra EXP
<li>- Added reforge option for master blacksmith
<p>
<br>

***Roleplay Tenkaichi version 1.61 -  -  07/30/20***

<ul>
<li>- You now master planetary gravity faster. (Non machine/spell gravity only)</li>
<li>- You can now choose to plunder a control point instead of injuring it's leader, it will reset a control point to neutral, reset the tax and give you all its reserves.</li>
<li>- Attack Speed/Refire Formula changed: (( 25/ sqrt(SpdMod) ) / SpdMult ) x (Other Effects such as steroids/weights/MPs)</li>
<li>- Zanzoken Combo now is 3x as fast (from 5x) and does 1/3 damage (from 1/5).</li>
<li>- Friendship Bracelets no longer take inventory space.</li>
<li>- Improvements to some attack logic. (Code stuff, not number changes)</li>
<li>- Post Human removed from auto learn/disabled for Humans.</li>
<li>- Human FBM buffed.</li>
<li>- Radiant Energy gives more  mana/res</li>
<li>- Portals to locations cost less</li>
<li>- Offspring over age 2 will now be offered to change into a toddler icon from the infant. Offspring over age 6 will be offered to change into a child icon.</li>
<li>- Makyo Star now allows spirits to leave the AL for 2 years.</li>
<li>- Stances can now be progressed by spending 100 EXP. You can buy your own stance for 500 or be taught by a Master in a stance. Anyone can now progress to Master status. (If you previously had 5 points on a stance, you can spend 100 EXP for Master, but you won't get an another point.) First spend goes to Intermediate and 4 points, second goes to Master and 5 points.</li>
<li>- Upgrading a Scouter will no longer lower its max scan if you have less Int mod than the previous upgrader.</li>
<li>- ECs no longer get increased max WP.</li>
<li>- New Elder Rewards system that grants you extra EXP on older characters.  You earn + 50 x (# of times rewarded) EXP for every 5 save age.</li>
<li>- Accelerate buffed slightly.</li>
<li>- Epinepherine buffed slightly.</li>
<li>- New icons for aliens, namekians and demons.</li>
<li>- Silver and Auracite weapons deal extra damage to Werewolves and Vampires.</li>
<li></li>
<li>- Burning Slash (Weapon) Tier 4, Launches a 3 hit combo attack followed by a blast. (First hit gets +15% Force added to your Strength, second gets +15% Force added to Strength and the third gets +20%. The blast deals bonus weapon damage.)</li>
<li>- Ki Hammer Tier 3, Makes your melee attacks damage with Force.(30% Strength and 90% Force. Counts as a +60% BP weapon, but reduces Speed and Offense by 15%. Doesn't work with ki fists or ki blade.)</li>
<li>- Exploding Heart Strike (Unarmed) Tier 4, Launch an attack against an opponent that deals delayed damage but has bonus offense damage, staggers and damages their chest. (3s delay)</li>
<li>- Lions Roar (Unarmed) Tier 4, Dashes three tiles and launch an energy blast that deals strength and force damage. The dash gets bonus damage from force.</li>
<li>- Catch The Blade renamed to Catch The Swing, now affects any attack type.</li>
<li></li>
<li>- New MP: Eat The Rich 3 MP Deal +5% damage to anyone with more than 100 million resources and mana on them.</li>
<li>- New MP: Midas Punch 3 MP Deal +5% damage to anyone while you have more than 100 million resources and mana on you.</li>
<li>- New MP: Weaponized Ki 7 MP adds your weapon BP to your charge attack.</li>
<li>- New MP: I Like To See You Bleed 8 MP +10 WP when you knock someone out in lethal, 3 minute CD.</li>
<li>- New MP: Grime Reaper 6 MP adds +1% damage per unique kill up to +5% at 5 kills.</li>
<li>- New MP: Aim For The Heart 8 MP This will cause you to deal 50% less damage but deal 20% of your damage as willpower damage while in lethal.</li>
<li>- Blade Of Light now grants +5% Off/Spd while using Ki Hammer.</li>
<li>- Smolder now costs 5 MP instead of 6 and has a slightly higher proc rate.</li>
<li>- Chakra Blocking is now an on use attack that stops their recovery for 10 seconds and drains 1.5x damage as energy.  Scales with Force and Str. Costs 4 MP now from 5.</li>
<li>- One Two Punch refunded. Now does +10% attack speed per rank.</li>
<li>- Custom Stance now costs 500 exp instead of 5 MP.  People that had it have the option to exchange the 5 MP for 500 EXP.</li>
<li>- Challenger's Mark now costs 7 MP from 6.</li>
<li>- Master Blacksmith now adds +5% defensive BP to armor.</li>
<li>- Forceful Negotiator no longer requires you to be unarmed. Now costs 7 MP.</li>
<li>- Xenophobia now only causes you to take 3% extra damage.</li>
<li>- Zanzoken Mastery refunded.  Now increases Warp Attack damage by 20% as well. Now costs 5 MP.</li>
<li></li>
<li>- Tech: Bombs and Detonators added at level 77+ Int with 4.5+ Int Mod. (All regular combat RP rules apply to bombs. Detonators only work in an 8 tile range.)</li>
<li>- Tech: Tech can now create 'Artificial Angels' which are Kaio. (Can add a password)</li>
<li>- Magic: Conjure reworked to where you now "create" a Demon by summoning it from Heck. (IC is that it's from Heck, but mechanic is that it allows someone to create a demon, Can add a password) Summoning a Demon will make you more evil.</li>
</ul>

<p>
<br>
***Roleplay Tenkaichi version 1.60 -  -  07/23/20***


<li>- Some overlay issues fixed
<li>- Hacking consoles work on pods and ships now
<li>- Fixes
<li>- Cleaned up some combat tab stuff
<li>- One Two Punch nerfed to 0.5 refire from 0.75
<p>
<br>
***Roleplay Tenkaichi version 1.59 -  -  07/23/20***

<li>- Tech/Magic: New item, Elixir of Uncertainty, allows you to refund 1 tier 3/4 skill you bought with EXP. 5 Year CD.
<li>- Magic: Seance no longer requires contact with someone. Advanced still does.
<li>- Misc: 1 time refund of tier 3/4 skills purchased with EXP.
<li>- Misc: Elixir Of Reformation will now refund all refundable MPs.
<li>- Misc: You can now Seize Control Point from the injure menu as an option when winning a round of combat.
<li>- Misc: Killing someone will Seize Control Points from them.
<li>- Misc: Fixes/adjustments/etc.
<li>- Misc: Tier 3/4 Melee/Unarmed/Weapon abilities buffed.
<p>
<br>
***Roleplay Tenkaichi version 1.58 -  07/22/20***

<li>- Skills: Hyper Tornado damage buffed and behavior improved.
<li>- Smithing: Helmets and Practice Swords no longer have higher than typical requirements.
<li>- MP: New MPs that I forgot to list.
<li>- MP: Smoldering Embers damage reduced slightly.
<li>- Misc: Fixes/adjustments/etc.
<li>- Misc: EXP : Passive ratio altered.
<li>- Misc: Helmets now hide you on scan/sense.
<li>- Misc: EXP costs adjusted. (No refunds)
<li>- Misc: Reincarnation will cause you to keep 75% of your mastered gravity.
<li>- Misc: Status tab now shows your weighted stat inside the parenthesis.  This should give you a more accurate understanding of where you are spending your total stats.
<p>
<br>


<b>***Roleplay Tenkaichi version 1.56 - Another One 07/17/20***</b>

<li>- Mechanic: Reincarnation will now carry over 25% of your spent EXP and 100% of your unspent.
<li>- Mechanic: Conversion rate for EXP : Passives changes to now be Invested EXP * max(1,Year/40) = Passive Bonus.  All EXP that was previously spent on passives has been refunded.
<li>- Mechanic: Oozaru timer increased slightly.  Oozaru timer will now properly pause if you turn on RP mode.
<li>- Mechanic: Echoing Slash now applies a bleed instead of the other effect.
<li>- Balance: Movement speed penalty from low HP adjusted.
<li>- Balance: Passive gain rate increased.  Passive's affect on accuracy now capped at 1.25x and 0.8x from 1.3x and 0.77x.
<li>- Milestones: A large number of MP are now refundable that previously were not. Should be retroactive and allow you to refund them, if not please submit a bug report and not an ahelp.
<li>- Milestones: Agile Nature buffed to +25% speed from 22%.
<li>- Milestones: Range of Motion cost reduced to 4 MP from 6 MP. Refunded the difference.
<li>- Tech: Tech can now make a mining bag that works like the cooking bag but for metal.
<li>- Tech: New skill called Stungun that is a stun with a long CD.
<li>- Tech: Methylphenidate is a new drug that works like vitamins for int/magic.
<li>- Tech: You can now replace someone's torso with a cybernetic version for +3% End/Max Energy for -5% Regen.
<li>- Tech: All Cyber limbs are now -5% regen instead of some being 5, some 7.5 and some 10.
<li>- Tech: New item archetype for tech: Grenades. Added Hand Grenades, Stun Grenades, Fire Bombs and High Explosive Grenades. They deal damage using offense.
<li>- Magic: Magic can now make a Disguise item that will conceal your name while worn.
<li>- Tech/Magic: New item added called Utility Belt which adds 3 inventory slots. Can be upgraded using metal with each tier adding a new inventory slot.
<li>- Misc: Inventory space reduced to 12.
<li>- Misc:  Fixes with the drone style spirit dolls.
<li>- Fixes: Bunch of fixes and what not that I didn't list previously.

<p>
<br>
<b>Roleplay Tenkaichi version 1.55 - Avatar: The Last Neckbeard 07/03/20<b>

<ul>
<li>- Balance: Str/Force have been combined into a new base stat called Might.  The process is not yet finished. You no longer gain Might from meditation. You will still have individual strength and force variables, but they will both use the same base stat.  Investing into Might will increase both Str and Force. See this for more depth; <a href="https://cdn.discordapp.com/attachments/399998352583950339/724046327750852648/unknown.png">Guide to Might</a></li>
<li>- Balance: God Ki has been redesigned.  Instead of the prior model, God Ki now works as an energy source to fuel having the form on.  When you first unlock God Ki, you start with 1 max god ki, which will only allow you to have the form active for one tick. You can increase your max god ki by any training that yields energy and you can train your max god ki up to the energy hard cap.  As you have god ki active, it will drain 1 god ki per tick and 10% of any energy you spend (other than percentage based drains, such as buffs/trans), and when you run out of god ki, you will revert from the form. God Ki is not naturally recovered and only regenerates when you are offline, afk or other special methods. God Ki being active will no longer grant 3x to all stats versus those without it, instead it will grant +50% to Might(Str/Force) and +50% to Endurance and increase your recovery ticks by 50% as well as making you drain less willpower to recover HP while it is active.</li>
<li></li>
<li>- Milestones: There are several new milestones at various costs. Several milestones have been changed in effect or in cost. Use this guide to see them all. <a href="https://docs.google.com/spreadsheets/d/1HczuqlBcfpLGOZpxCGFV5Ad-110i3WEvhFKllsOHMdE/edit?usp=sharing">Guide to Milestones</a></li>
<li></li>
<li>- Skills: Special/Unique Beams no longer use Offense and will once again use Force for their damage.  Spirit Bomb and the Explosive Wave variants still use Offense.</li>
<li>- Skills: Several new skills have been added.</li>
<li>- Skills: New pantheons.</li>
<li></li>
<li>- Progression: Spending EXP on passives no longer contribute towards the cap on that passive. Meaning if you have 1000 Unarmed when the cap is 1k and then invest 200 EXP into unarmed, you would be at 1200.</li>
<li>- Progression: Wipe pacing has been adjusted by removing 4 days from the transformation era and 4 days from the FBM era.  This will lead to us hitting god ki faster and should lead to less burn out during that period.</li>
<li>- Progression: Progression redesign.  Progression will no longer be directly connected to being taught your target tier 3-4 skill from a rank, but instead spending the EXP you earn from roleplaying on unlocking the next tier of skill by using a lower rank as the "base" skill. (We are continuously assessing the ranking of the skills within the new progression.  If you feel a skill should be in a higher or lower rank or more or less powerful, please share the feedback. <a href="https://cdn.discordapp.com/attachments/399998352583950339/727206381001900052/unknown.png">Guide to Progression</a></li>
<li></li>
<li>- Tech/Magic: New items added to both and new skills available for each. </li>
<li></li>
<li>- Mechanic: Energy loss will not affect your BP as much for the first 15%.  Anything below 75% will now have increased drain on your BP.</li>
<li>- Mechanic: There is no more concept of "Kill Year" instead, each character is granted a 3 IC year period of death immunity.  Just like with the kill year, though, you may admin help to request this rule be bypassed if someone is especially deserving of an early kill.</li>
<li>- Mechanic: The willpower requirement in order to injure or loot someone has been reduced to 55 from 70.  The requirement to kill someone has been reduced to 25 from 30.</li>
<li>- Mechanic: The flee roll formula has been adjusted to cause more loss when the user is low on willpower.</li>
<li>- Mechanic: Quests are now accessed through the Options drop down menu and choosing Quest Log.</li>
<li>- Mechanic: Body part damage from damage received has been increased significantly in both damage and occurance rate.  This will lead to people being injured organically as a fight progresses.  Various skills will now inflict targetted damage to select limbs.</li>
<li>- Mechanic: Space no longer kills you, but if you do not have a mask and can't breath in space, you will not recover energy while there.</li>
<li></li>
<li>- Races: Racial mods have been adjusted to better reflect intended balance.  Keep in mind, no race is number one or last place forever and the balance of a given wipe is looked at across the wipe as a whole so if a given race feels weak today, that is probably because their time to shine is later, or earlier, in the wipe.</li>
<li>- Races: Racial Transformations no longer have a drain, instead they reduce your recovery ticks.</li>
<li>- Races: Most races have been granted 'sprinkles', that are small mechanic changed to make them feel unique compared to other races.  Some examples include, Tuffles getting extra inventory spaces, Space Pirates being able to evade taxes and not be reported, and Onis offering better sparring gains. </li>
<li></li>
<li>- Misc: NPCs have been added to some surface locations for the starting planets.  NPCs will now inhabit the underground mine.  The NPCs underground are hostile and will always attack using lethal.  If they reduce your WP below 10, you will be teleported back to where you entered the underground from. The intention is to gather feedback and testing and continue to expand upon this system, with the underground eventually being reworked into a progressive dungeon.</li>
<li>- Misc: Various additional changes have been made but have been left out of the update notes in favor of garnering more of a traditional game experience of 'exploration and discovery.'</li>
<li></li>
<li>- Fixes.</li>
</ul>

<p>
<br>
***Roleplay Tenkaichi version 1.54 - 06/14/20***

<li>- Balance: Str/Force have been combined.  The process is not yet finished. You no longer gain Force from meditation.
<li>- Fixes.
<li>- Other changes and tweaks.
<li>- Totally didn't write them as I did them so don't expect a full recollection.

<p>
<br>

<b>Roleplay Tenkaichi version 1.53 continued (Thank Mumrit for this Update <3) - 05/05/20</b>

<li>- Balance: Well Rested and RP Rewards now affect gain multiplier gain rates.  When your yearly emote total is calculated you will earn some gain mulitplier based on emotes.
<li>- Balance: Well Rested increased resouce and mana gained from dig/meditate.
<li>- Balance: Well Rested is now +25% gains instead of +20%.
<li>- Balance: Combat Math now grants 1.2x Force and Strength so it is useful for more than just Str builds.
<li>- Balance: Vending Machines cost less now.
<li>- Balance: Splitforms are now 95% of your BP instead of 90%.
<li>- Balance: Drills and Pylons no longer draw from a total pool of res/mana for a given planet and instead dig at a slower continuous rate. (5x instead of 50x)
<li>- Balance: Aging is now much slower. Newborns with a 16 incline start with around 45% body instead of 75%.
<li>- Balance: Catch UP MPs grant the Human bonus.
<li>- Balance: Beast of Burden and Sturdy Build no longer reduce your Flee roll.
<li>- Balance: Flee roll is now reduced by 50% below 30 WP instead of -1.
<li>- Balance: Made Radiant Energy verbs require 3INT or 3MAG respectively
<li>- Balance: Lowered the amount of resources/mana from Radiant Energy
<li>- Balance: Using Homing blasts will reduce % chance of Knockback and using Knockback will reduce % chance of Homing
<li>- Misc: Humans had their MPs purged in order to fix the issues with missed racials.
<li>- Misc: You no longer need to spam Hacking Console, it will now just work if it is high enough level and not work if it is too low.  (Previously you had a % chance to "work" even if you already had a high enough level to get in.)
<li>- Misc: Ranks can now award themselves EXP.  This is acceptable because they are already expected to RP and be active in order to be a rank in the first place.
<li>- Misc: Teaching a good person while you are good makes you more good.
<li>- Misc: Fixes. (Splitforms, Catch Up MPs, etc)
<li>- Misc: Added more information to the Elixir of Life failure screen (outputs unweighted energy value)
<li>- Misc: Elixir of Life will set your current energy to 10, and require you to regenerate energy.  This is to avoid people from using them as energy refills in combat.
<li>- Bug Fix: All Trans mastery fixed to increase and lower drain based on mastery
<li>- Bug Fix: Aliens no longer able to buy multiple Alien MPs after reincarnating
<li>- Bug Fix: Can no longer toggle buffs during SSj trans / Pantheon selection to grime and get 4 buffs
<li>- Bug Fix: Multiple attacks lacking a cooldown has been resolved (Iai Slash, Cleave Attack, Solar Flare, Sword Stab)
<li>- Bug Fix: Fixed an issue where Shield var would stay on, resulting in energy drain when not using Shield
<li>- Bug Fix: Fixed an issue where a player could spam "Radiant Energy" and receive multiple Radiant outputs
<li>- Bug Fix: Made it so Vending Machines save on the app (along with Dragonballs)
<li>- Bug Fix: Removed Racial Buffs from showing up in Set Student
<li>- Bug Fix: Kaioken Aura should appear (unsure if layering will be correct)
<li>- Bug Fix: Burning Shot not longer teachable by students
<li>- Bug Fix: SSj hair layering issues resolved
<li>- Bug Fix: Possible fix for Saiyan tail layer issue
<li>- Balance: Made it so Blast/Barrage drain while Flying is increased
<li>- Balance: Made it so only Knockback OR Homing can be turned on, not both.
<li>- Bug Fix: FBM requirements fixed


<p>
<br>

<b>Roleplay Tenkaichi version 1.52 (Eastah) - 4/12/20</b>


<li>- Balance: Bash's Stun reduced from 5x to 1.5x. CD increased slightly.
<li>- Balance: Blast damage reduced slightly and delay slightly increased for single tile blast.
<li>- Balance: Beam Expert / Multi Tile Beams now do 75% damage.
<li>- Balance: Base Magic/Int gain rate slowed.
<li>- Balance: Passive skills will now train faster.
<li>- Balance: Kaio/Demon FBM and God Ki Tier buffs tweaked to reflect Majin/Mystic changes.
<li>- Balance: Custom Beams reset. Stats tweaked. Spend the points by going to Character Sheet then right clicking the beam.

<li>- Mechanic: Super Explosive Wave, Grand Explosion and Self Destruct now use Offense instead of Force for damage calculation.
<li>- Mechanic: Thundering Blows is now a 50% chance to occur.
<li>- Mechanic: You can now train someone in your Passive Skills.  There is a 1 year CD between teaches (Resets when you earn an MP).  You can only use it on someone with less than 80% of your skill, it will grant 20% of your total skill and it will never overcap them. Wise Mentor gives you 2 teaches per passive instead of 1.
<li>- Mechanic: RP Rewards and Well Rested gains will now increase Passive Skill gain rate.
<li>- Mechanic: Splitforms will now inherit your evasion and unarmed passives.
<li>- Mechanic: You can spend 1000 EXP on +1 Milestone Point.
<li>- Mechanic: You now earn passive skills each time your yearly emote total is calculated. (Max of +25 per year from this method)

<li>- Misc: Warp Attack and TK Pull will now display CDs.
<li>- Misc: The distant noise message while AFK should be much less spammy.
<li>- Misc: Fixed issues with FBM unlocking early.
<li>- Misc: Live Updates no longer automatically relog you. (May return this function later.)
<li>- Misc: Fixes. (MP issues with aliens, Gravity, Solar Flare, Reincarnation, Stance Teaching, Infinite Riposte loop fixed, Translators, Stone of Understanding, Burning Fist, Uppercut,  etc)


<p>
<br>
<b>Roleplay Tenkaichi version 1.51 (Chewyy Might've Broke Things) - 4/09/20</b>

<li>- Mechanic: Adjusted the Anger increase on Majin down to 10% and the PUCap increase for Mystic down to 10%
<li>- Mechanic: Removed the Endurance and the Speed bonus from Majin/Mystic, respectively
<li>- Misc: Fixed an issue with Discord Set Student Output not outputting the correct Year that can be taught
<li>- Misc: Fixed an issue where training in the AL made you swole
<li>- Musc: Added a message for Reincarnation to tell the user to Relog until it can be fully fixed
<li>- Misc: Implemented a fix to stop the Scouter overlay from blinking (hopefully)

<p>
<br>
<b>Roleplay Tenkaichi version 1.50 (Todd Noward) - 4/03/20</b>

<li>- Mechanic: Self Training and Sparring with Ki Blade on will now only grant Ki Manip and Evasion.  Ki Blade only uses Ki Manip for accuracy/damage purposes, not weapon skill.
<li>- Mechanic: Passives now capped at affected accuracy by 1.3x max from 2x and 0.77x min from 0.5x.
<li>- Misc: You can now only sense alignment if you have 2+ Magic Mod.
<li>- Misc: Added ways to increase passive gains additionally.  Boxing Gloves will improve unarmed rate, Practice Sword made from infusing Tin bar into a Copper bar, Orb of Mastery, magic item, will improve ki manipulation rate, Ninja Scarf, tech item, will improve evasion rate,
<li>- Misc: New intentory sorting order. Res/Mana/Ships up top, then food/metal, then items, then clothes.
<li>- Misc: New maptext overlay for scouter BP. Toggle under graphics options.
<li>- Misc: New maptext overlay for team. Toggle under graphics options.
<li>- Misc: Fixes

<p>
<br>
<b>Roleplay Tenkaichi version 1.49 (Miner Things) - 3/29/20</b>


<li>- Mechanic: Passive Skills are now capped from training/grinding at 100 + (100 x year), gain rate from training/grinding increased. There is no cap on investing EXP into them. The accuracy benefits/penalties from passive skills changed to 2x max, from 4x, and 0.5x minimumn, from 0.25x.
<li>- Misc: Fixes


<p>
<br>

<b>Roleplay Tenkaichi version 1.48 (Cataclysm) - 3/26/20</b>
<ul>
<li>- Mechanic: Gravity will no longer give increased gains if you have already mastered that current level of gravity.  This is to decrease "hutting" mid to late wipe and to improve "accessibility" late wipe. As a result, base gain multiplier gains were improved.</li>
<li>- Mechanic: Self Train no longer granted Speed if you are focused on Strength, Endurance or Balanced.  It will grant Speed if you focus on Skills for self train, though.</li>
<li>- Mechanic: MP purchase/refund overhauled.  You can now refund select MP once every 5 years.  You will get them back as catch up MP.  You can now view your purchased MP and their effects.</li>
<li>- Mechanic: Contacts changed. You can now set notes for contacts. The relationship text for contacts is now largely cosmetic and the familiarity value is the important factor.  Familiarity gains for the relations of Neutral, Enemy and Hated are capped at 25. Any positive relationship (not one of those three) can qualify for death anger if you have 45+ familiarity. Ranks get a special Disciple contact which improves the gains of that person a small amount if they spar.</li>
<li>- Mechanic: Attacking from behind is flat +25% accuracy instead of a +25% boost to Offense stat. Attacking while the target is attacking grants a +10% accuracy.  Slows will add a % to accuracy equal to the slow degree.</li>
<li>- Mechanic: Zenkai now tied to Willpower instead of HP. Death Zenkai no longer counts towards your Zenkai cap. 70% or less WP will cause you to gain zenkai ticks. Most Zenkai mods increased.</li>
<li>- Mechanic: New Language, Baby Talk, only offspring gain this language. It is lost at age 4 and can not be learned or translated.</li>
<li>- Mechanic: Months no longer have days but now have weeks. Year system tied to the Wipe Day timer instead of being independent. Less frequent ticks will mean less server overhead too.</li>
<li>- Mechanic: Taxation system implemented.  Whichever faction is in control of the planet will control the tax rate and be able to use those proceeds to pay their faction and etc. Taxes are taken out of drills and pylons automatically and a player can toggle if they pay taxes on dig/meditate. If you do not pay taxes you are reported to the faction that controls the planet.</li>
<li>- Mechanic: Offline gains called "Well Rested". 4 hours offline : 1 hour of Well Rested. It grants +20% gains to BP/Energy/Stats/Int/Magic and +50% gains to professions, max of 8 hours of gains at 32 hours offline.  This is to let people feel as though they can log off and take breaks without falling massively behind.</li>
<li>- Mechanic: Lethal Combat Timer reduced to 15 minutes, 30 minutes and 60 minutes.  The reduction is to encourage people to try to wait it out rather than just going AFK and we feel it should not last the entirety of someone's play time.</li>
<li>- Mechanic: People below their incline age and people over their decline age with gain passive skills (Unarmed, Weapon, etc) faster.</li>
<li>- Mechanic: Digging now grants Max Energy.</li>
<li>- Mechanic: New RP Rewards system. This system functions as a server-wide RP quota.  Once the quota is fulfilled anyone that met a certain threshold of RPs is rewarded with "RP Rewards" which lasts server wide for 3 days for all of those that met the requirements. It then goes on cooldown for 2 days after this period and then comes back up with a new quota. Roleplay Rewards give +25% BP/Energy/Stats/Int/Magic gains and +50% profession gains. You can check the server progress and your past contributions using the button in the top right.  The numbers will not update in realtime intentionally to avoid people trying to game the system. Attempting to abuse the RP reward system will result in punishment.</li>
<li>- Mechanic: Years are now treated as whole integers and Months as a new variable. This will cause you to earn MP on each year instead of on your IC birthday.  This may cause issues with things that have CDs tracked by the year. Please report anything you find in the discord bug reports channel.</li>
<li>- Mechanic: Sounds removed/disabled.  Most people mute them and they are out of date. May improve client-side performance.</li>
<li>- Mechanic: New "Better Anger" mechanics for more shonen moments. Anger will now build up as you take damage instead of only at less than 50% Health.  This will make Anger more in line with Power Control BP and will be better for balancing "Anger Races." You will still trigger full anger if you hit below 50%.</li>
<li>- Mechanic: Second Wind and Anger are now checked within the Damage procedure instead of within each attack. This will lead to far more consistent anger triggering and should entirely prevent one shot KOs.</li>
<li>- Mechanic: Second Wind and similar mechanics now proc over a period of 1.5 seconds instead of all at once.</li>
<li>- Mechanic: Death Anger is now a flat +25% Max Anger and lasts until you are KOd/Meditate/Become calm without a Lethal tracker.</li>
<li>- Mechanic: You will now slowly lose anger over time if you have not triggered the traditional <50% HP anger.</li>
<li>- Mechanic: New Team system inspired by DBR's Party system. Better handling for party leaders and easier to tell who is on your party.</li>
<li>- Mechanic: Adjust Pixel X/Y now allows  you to alter an object's X/Y and its layer.</li>
<li>- Mechanic: Change Object Icon now allows you to alter an object's layer.</li>
<li>- Mechanic: All buffs now use a universal buff/debuff system and will allow for admins to easily create custom buffs.</li>
<li>- Mechanic: Androids will no longer get Fists of Fury on FBM, but their Overdrive was buffed.</li>
<li>- Mechanic: New system for running drains on your character. Way less overhead.</li>
<li>- Mechanic: Spirit Dolls now have a choice between melee or ki focus in their racial buffs of Swole Doll or Soul Doll.</li>
<li>- Mechanic: Several Racial mods adjusted.</li>
<li>- Mechanic: New build options, custom turf and custom obj which are under the Special tab.</li>
<li>- Mechanic: New way of handling combat effects and new icons for some of them. Very big improvement to overhead. Will lead to some oddities the first time an effect is "loaded" into the server. (After images wont fade out on first use/etc)</li>
<li>- Mechanic: First tier transformations will grant WP to their user on their first use. (Each use per character as opposed to server usage. Will allow even people after the first trans to still feel impactful.)</li>
<li>- Mechanic: Kanassa now choose between the available alien trans, Melee or Ki.</li>
<li>- Mechanic: New learning/teaching code. All skills have a 1-5 tier which determines their teaching time, cooldown and etc.</li>
<li>- Mechanic: Body Sizes removed.  Instead you get 15 total stat points.  This is because body sizes actually limited player choice and build viability even though they appeared to create choices. Giving additional stat points instead directly allows that customization.</li>
<li>- Mechanic: Your direction will now be preserved during knockback. Knockback is now in the direction of the point of impact, instead of away from the person that impacted them. Leads to you being able to knockback someone, then run along them/zanzoken behind them and follow up the combo instead of them changing direction and moving away continuously.</li>
<li>- Mechanic: Changed the way that body part damage is assigned. Now whenever you take damage, it will have a chance to cause body part damage with a higher chance on greater damage.</li>
<li>- Mechanic: At save age 5 and >1500 combined passive skills you will be able to choose one advanced skill to learn. At save age 10 and >5000 combined passive skills you will be able to choose one limited skill to learn.</li>
<li>- Mechanic: Armor no longer has a passive blocking mechanic.</li>
<li>- Mechanic: Food and Drugs now work on a timer basis instead of days.</li>
<li>- Mechanic: Accuracy and Evasion are no longer calculated using the Zanzoken variable.  They are now calculated using Unarmed/Weapon/Ki Manipulation versus Evasion.  These "passive skills" have no cap and can be increased infinitely. They do have a cap to effectiveness at no more than 4x in either direction. These passives will also contribute towards a "minimum" baseline damage for each of their respective areas. This minimum baseline is achieved at 10k skill.</li>
<li>- Mechanic: You now automatically have access to Reincarnate within the AL.</li>
<li>- Mechanic: Default stat gain rate increased by 20%.</li>
<li>- Mechanic: Alignment now shows up on sense.</li>
<li>- Mechanic: Now your 3 most recent saves are archived.</li>
<li>- Mechanic: If you are AFK you will no longer see posts/emotes.</li>
<li>- Mechanic: Radiant Energy is a "wandering" mechanic that will be applied to one planet per 24 hour period.  Radiant Energy will allow mages and techies the chance to get a once per cycle boost of resources or mana.  Techies need to bring a ship to the planet and right click the ship to harness the energy whereas mages can do the same with their personal realm. This is designed to encourage people to continue to move around mid-wipe and create organic interactions as people do so. The mana and resources gained are not taxed.</li>
<li>- Mechanic: New crowd control mechanics.  Standardized the different types into; Slows, which apply variable movement speed reductions for a given period of time, Staggers, which impose a set movement speed reduction for a given number of movement ticks, and Stuns, which prevent action for a given period of time.  Each of these effects then triggers a period of immunity to the same effect being applied, this immunity is further increased by KBResist.</li>
<li>- Mechanic: EXP system added. EXP can be awarded to players by ranks, ECs and admins.  EXP should be awarded for people that actively RP, engage in events, complete rank quests and show effort and motivation in their own IC.  Each person may receive 1 EXP award of 100 EXP per 24 hour period.  There is no limit to the number of times you may award EXP, so ranks/ECs/admins should feel encouraged to give it to everyone that qualifies. You will also earn EXP by emoting and contributing towards the Roleplay Rewards qouta.</li>
<li>- Mechanic: Decisive Blows can trigger on basic melee attacks when you are below 30% health in a lethal fight. Decisive Blows grant +2% HP to the user and deal 10% of the opponent's current HP as additional damage.</li>
<li>- Mechanic: Faction Leaders can now appoint a pay grade for their members. Currently requires a faction to be in control of a planet in order to direct pay.</li>
<li>- Mechanic: Faction Leader Ranks can now grant temporary building permits.</li>

<li>- Skills: New Pantheon added, hidden requirements.</li>
<li>- Skills: New customizable energy wave. This skill can be purchased for 6 MP and various ranks will start with it.  You can right click it from your character sheet, in order to customize it.  Once you have customized it and are happy with the stats, you can finalize it and teach it out to others.</li>
<li>- Skills: Stances for ranks now always start at 5 points. Stances are now taught in 3 "stages," the first stage teaches you a 3 point stance with same core as the teacher. You can freely spend these 3 points but the core is locked. Then, you can be further taught by that person two more times to improve the stance all the way up to the full 5 points. Stance options now display under right click in the character sheet. Stances are now mastered using 250 EXP instead of milestone points.</li>
<li>- Skills: All skills are now broken into 5 tiers which determine their cooldown between teaches, requirements for teaching/auto learning and generally reflect the skills power.  All rank buffs are tier 5 and can only be taught by a rank, unique attacks suchs as Super Ghost Kamikaze Attack and Texas Smash are considered tier 4 and can also only be taught by a rank, but have a lower CD between teaches.</li>
<li>- Skills: Makyojin will get +10% BP from Expand during the Makyo star.</li>
<li>- Skills: Ki Fists will use 50% of your Unarmed Skill and 50% of your Ki Manipulation skill when determining accuracy and baseline damage and Ki Blade will use 50% Ki Manipulation and 50% Weapon Skill. Using either of these skills will cause you to gain the respective passive skill instead of Weapon/Unarmed when sparring and self training.</li>
<li>- Skills: Spirit Bomb and all "named beams" (such as Kamehameha and Masenko) use Offense instead of Force for determining damage.  This is to increase their viability for multiple playstyles and encourage their active usage.</li>
<li>- Skills: Beams may now be set to knockback your opponent.  They will also have a low chance to cause a Stagger on each damage tick.</li>
<li>- Skills: Several new skills, the coolest of which is Texas Smash which is a tier 4 melee move that has a charge up time before dealing 125% strength damage with additional damage that scales based on damage sustained during the charge.</li>
<li>- Skills: New skill called "Resist" which allows you to break out of any existing crowd control effects and stop all bleeds and burns.  Costs 15% energy to use, long CD.</li>
<li>- Skills: Catch the Blade will now work on sword stab and block it. Successful uses of catch the blade will stun the opponent.</li>
<li>- Skills: Successful uses of Riposte will stun the opponent.</li>
<li>- Skills: New weapon skill called Slash : You slash at your opponent with your sword or swing with your hammer in a fast attack. (Regular attack damage, but doesnt trigger attack CD. Short cooldown.)</li>
<li>- Skills: New weapon skill called Bash: Bash your opponent with your hammer or the pommel of your sword. This will stun them for 3 seconds and also stagger their movement.</li>
<li>- Skills: Uppercut Punch renamed to Uppercut Combo. It no longer dashes before launching the combo.</li>
<li>- Skills: Shockwave renamed to Explosive Wave.</li>
<li>- Skills: Kiai renamed to Shockwave.</li>
<li>- Skills: Weapon skills are no longer weapon specific and work for both hammers and swords. Weapon skills no longer work with Ki Blade.</li>
<li>- Skills: Altered the way blasts home in on targets.  All blasts now have 10% innate tracking, Energy Marksmanship now grants +15% and Heat seeking blasts add another +50%.</li>
<li>- Skills: Using Fly will being knockedback will attempt to stabalize you and end the KB.</li>
<li>- Skills: Zanzoken now has 3 charges that refill based on your speed.  You can get an extra charge by purchasing the Zanzoken Mastery MP.</li>
<li>- Skills: Majin and Mystic no longer have racial and rank variants and are now the same for anyone that gets them. (The old rank version is the new default)</li>
<li>- Skills: New support skill added called Sense Energy. This replaces the old sense window and can be taught.</li>
<li>- Skills: Block will now cancel out and completely nullify a Dash Attack. Block will also stop the second part of the Kickback Combo entirely. Block will also cause you to not take damage from Iai slash. Block now has a flat 50% damage reduction in addition to the stat changes.</li>
<li>- Skills: New skill, Jump Backwards which will allow you to try to leap backwards 3-5 tiles to evade an attack/for RP purposes. Useful in combat?</li>

<li>- Tech/Magic: Personal realms are now personal, each mage is assigned a personal realm that is unique to them and if they dismiss it creating a new one will recall the same portal. Mages will be able to summon their personal realm portal to a planet that has Radiant energy and harness it to gain mana. More personal realm interiors.</li>
<li>- Tech/Magic: Techies with 3500 EXP, 6+ Int mod and 500 million +  resources (depending on milestones and etc) can apply to create the Android Ship. They can then use the Android Ship to create an army of self-sufficient Androids.</li>
<li>- Tech/Magic: Techies with 3500 EXP, 6+ Int mod and 500 million +  resources (depending on milestones and etc) can apply to create a Bio Android.</li>
<li>- Tech/Magic: Mages with 3500 EXP, 6+ Magic mod and 500 million +  mana (depending on milestones and etc) can apply to create a Majin.</li>
<li>- Tech/Magic: Mages with 3500 EXP, 6+ Magic mod and 500 million +  mana (depending on milestones and etc) can apply to create a Soul-Infused piece of equipment (Helmet, Armor, Sword, Hammer, Gauntlets) which adds +10% BP enchantment. Requires IC possession of a soul contract or killing someone to use their soul.</li>
<li>- Tech/Magic: Magic Circles now must be in your inventory to benefit.</li>
<li>- Tech/Magic: Telepathy now requires 2+ Magic Mod to learn for races that do not have it as a racial.</li>
<li>- Tech/Magic: Int/Magic Catch Up is now compared to the cap and not the average Int/Magic of other techies/mages.  Reduces overhead and will be more consistent for actually catching up.</li>
<li>- Tech/Magic: Ships no longer have airlocks for easier generation. Lots of new ship and pod interiors as a result.</li>
<li>- Tech/Magic: Added new spell, Accelerate which increases movement speed and can ignore the speed reduction from slows and snares.</li>
<li>- Tech/Magic: Added new spell, Frost Bolt, 43+ magic 3+ mod that fires a slowing blast that deals damage based on magic and homes.</li>
<li>- Tech/Magic: Added new spell, Advanced Seance, which summons a Soul with 80% of their body for 1 year. Level 100+ with 5+ magic mod.</li>
<li>- Tech/Magic: Now accessed using the Create button.</li>
<li>- Tech/Magic: New drug added, Epinephrine Level 51+ 4+ mod, grants the Accelerate effect.</li>
<li>- Tech/Magic: Materialize and Make Weights now each require 2+ mod</li>
<li>- Tech/Magic: New tech item, Advanced Furnace acts as a stove and a forge and reduces the crafting time by twice as much as a regular stove or forge.</li>
<li>- Tech/Magic: Scouters are no longer a continuously updated window and must be manually refreshed. This is largely to help with lag and server overhead.</li>
<li>- Tech/Magic: New tech item, Vending Machines, which will allow a techie to sell items at a given price. They can hold up to 8 items.  They can be upgraded to increase their HP and endurance but they can be destroyed, which will drop the resources and items contained within. (I suggest someone runs a vending machine protection racket)</li>
<li>- Tech/Magic: Gravity Well is no longer an MP but comes to any mage that meets the requirements.</li>
<li>- Tech/Magic: Security Cameras will now store the images of those they detect if they do not have a key with the same password.</li>

<li>- Milestones: New Milestones added. (Double Attack, Challengers Mark, Custom Beam, Moral Compass)</li>
<li>- Milestones: Telekinetic Pull Master now also grants Telekinesis.</li>
<li>- Milestones: Berserking now properly reflects what it actually does. (-25% to Anger, Regen and Defense, not -75%)</li>
<li>- Milestones: Deft Hands and Swift Reflexes now affect all melee accuracy calculations and not just basic attack.</li>

<li>- Misc: Skill Sheet and player assess changed to Character Sheet.</li>
<li>- Misc: Stuff moved into and out of the Other tab.  If you don't see something in Skills, look in the other tab, if you don't see something there, it is either in a menu in the top left or if it is related to a skill its in the Character Sheet.</li>
<li>- Misc: Admin kill should now bypass kill year.</li>
<li>- Misc: 3 new event reward items, Ring of Smithing, Angler's Lure and How To Serve Saiba which give bonuses to the profession skills.</li>
<li>- Misc: All skills should now use their english names.</li>
<li>- Misc: Fixes</li>
</ul>

<p>
<br>

<b>Roleplay Tenkaichi version 1.47 (Ralph) - 2/29/20</b>
<li>- Thorns Aura buffed slightly. 10% more BP and 5% more damage reflected.
<li>- Power Armor will no longer count towards inventory space.
<li>- You will now be set to 50 HP at the end of a time freeze if you trigger Second Wind in it.
<li>- Elixir of Life readded. Increases decline by 5 years for 5k energy.
<li>- Cialis added. Allows mating in Decline.
<li>- Super Anti Viral added. Cures zombie and vampirism.
<li>- Enchanted items can now be upgraded and carry over their enchants.
<li>- Fixes
<p>
<br>


<b>Roleplay Tenkaichi version 1.46 (Stewart) - 2/29/20</b>
<li>- You can now add notes to a contact by clicking it.
<li>- Some other stuff I forgot to write down.
<li>- Preparation for the new rank kit assembly.
<li>- Mystic grants +30% Power Up instead of +25%.
<li>- Milestone/Year issue fix attempts/additional debug info.
<li>- Fixes


<p>
<br>


<b>Roleplay Tenkaichi version 1.45 (Guffaw) - 2/27/20</b>
<li>- Percentage drains adjusted.
<li>- Thorns Aura no longer reduces the user's endurance.
<li>- Medical Assessments used by someone with 6 or higher mod will now show infection status.
<li>- Someone with a 6 or higher magic mod can use sense to detect infection.
<li>- Planets no longer wander around in space.
<li>- Mana Fish and Gold Fish now scale their rewards with the Year.
<li>- FleeAdd variable added to give a flat flee add to characters by admins.
<li>- Having SSj4 will disable access to SSGSS and to God Ki.
<li>- Death now gives 1.7x BP instead of 1.6x.
<li>- Kaioken initial damage reduced slightly, scales slightly faster.
<li>- Telepathy now uses say output.
<li>- Fixes

<p>
<br>


<b>Roleplay Tenkaichi version 1.44 (Maybe Lag?) - 2/24/20</b>
<li>- Fixed issue with fishing, thanks Tigers.
<li>- Self Replicating Code Injector added, basically mutagen for androids. Same requirements.
<li>- New Fully Upgraded Gundam icon courtesy of Sokkxx. Thanks Sokkxx.  This is applied to fully customized gundams. You can re-apply the icon by using Customize again.
<li>- New Gundam icon courtesy of someone who I currently forget. Thanks! This is applied to all baseline gundams that are not maxed out.  You can re-apply the icon using Upgrade again.
<li>- Androids will now leak oil instead of blood.  Cyberized people have a 50% chance to leak oil instead of blood.
<li>- MegaBurst CD and charge time reduced. Charge time from 5x Refire to 2.4x Refire (twice as long as Destructo_Disc) CD from 5x to 4x.
<li>- Base Rock Throw damage increased. Rock Throw now has an option for toggling the blast like setting. Rock Throw Expert refunded.
<li>- You can no longer pick up ships or pods that are in use.
<li>- Thundering Blows no longer causes a lightning bolt (due to lag/etc) and now instead causes 10% of the damage of the initial attack. Chance to occur increased from 30% to 35%.
<li>- Ping now actually makes the taskbar flash.
<li>- Upgrade Kits added to Magic/Int at 2+ mod and 69+ level. Doubles the current BP add of a weapon.
<li>- Crystal Balls no longer work in the AL.
<li>- Android Mainframe cost increased.
<li>- Telepathy now posts in local.
<li>- Lag improvements?
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.43b (Update Notes) - 2/21/20</b>
<li>- Adamantine Skeleton now makes you sterile. (Not retroactive)
<li>- You can now use Kaioken and SSj together.
<li>- Kaioken damage will now increase the longer the buff is on. (About +20% damage per minute)
<li>- Added a "Reset Milestones" button that each character can use once.  It does not refund int or magic levels, it does not refund enchant master or gravity well, it does not refund pilot skill. It does not work with anything auto granted (Build Permit or Wise Mentor), and it does not work with Alien MPs.
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.43 (Make Beams Great Again) - 2/21/20</b>
<li>- All named Beams (everything excepet "Beam") now charge using their charge rate without factoring the user's speed.  This is to make all named beams be good regardless of the user's build. These beams now use Offense instead of Force for determining damage. Regular beam still uses force.
<li>- New slot machine item added. Credit to Kitsueki for the code/icon.
<li>- Burns now follow the same logic as Bleeds. They will stack up to three and then fall off instead of each new burn extending the duration of the original.
<li>- Regular Beam CD reduced.
<li>- Groundwork for Milestone system overhaul started.
<li>- Fixes

<p>
<br>
<b>Roleplay Tenkaichi version 1.42b (???) - 2/19/20***
<li>- Pursuit of Knowledge changed.
<li>- Absorb changed to +50% Base BP.
<li>- Installing capsule tech onto a ship now requires you to set a password. If you don't have one set, please ahelp if you are the owner/builder.
<li>- Way of the Fist costs 5 MP from 6 and gives 10% strength from 15%.
<li>- Weapons rebalanced using spreadsheets. Final revision for this wipe.
<li>--
<li>- Normal_Sword MaxBPAdd=50%
<li>- Copper_Sword MaxBPAdd=65%
<li>- Bronze_Sword MaxBPAdd=60% Off=0.8x
<li>- Iron_Sword MaxBPAdd=85% Off=0.7x
<li>- Mythril_Sword MaxBPAdd=50% Off=0.9x
<li>- Masterwork_Sword MaxBPAdd=80%
<li>--
<li>- Normal_Hammer MaxBPAdd=65%
<li>- Copper_Hammer MaxBPAdd=80%
<li>- Bronze_Hammer MaxBPAdd=70% Off=0.8x
<li>- Iron_Hammer MaxBPAdd=100% Spd=0.8x
<li>- Mythril_Hammer MaxBPAdd=75% Off=0.8x Spd=0.9x
<li>- Masterwork_Hammer MaxBPAdd=100%
<li>--
<li>- Normal_Gauntlets MaxBPAdd=10%
<li>- Copper_Gauntlets MaxBPAdd=15%
<li>- Bronze_Gauntlets MaxBPAdd=20%
<li>- Iron_Gauntlets MaxBPAdd=25%
<li>- Mythril_Gauntlets MaxBPAdd=27%
<li>- Masterwork_Gauntlets MaxBPAdd=30%
<li>--
<li>- New beams, Photon Flash, Tyrant Lancer, Double Sunday and Buster Cannon.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.42 (???) - 2/18/20***
<li>- Majin now grants a flat +40 max anger and triggers anger at 60% HP instead of 55%. 15% Off/End instead of 10%. (Non Kaio/Demigods)
<li>- Mystic now grants 1.5x BP instead of 1.4x, no longer grants Recovery but grants +25% Power Up to non Kaio/Demigods.
<li>- Being successfully cloned will now cause you to lose 7.5% BP per successful cloning after the first. This loss stacks and only resets on a normal death(One where you go to the AL).
<li>- Helmet fixes.
<li>- Description fixes.
<li>- You can now leech 90% of someone's Gain Multiplier instead of 70%, but it is slower.
<li>- Arcane Brokerage merged into Deep Pockets.  Arcane Brokerage refunded and disabled. Deep Pockets will now reduce costs for resources and mana.
<li>- Ship launch cooldowns changed to 2 months on tier 1, 1 months on tier 2, and no CD on tier 3. Spacepods have a 1 month CD, MK3 Spacepods have no CD.
<li>- Baseline Quest system introduced.  Ranks are able to create, assign and 'complete' quests to other players. Quests appear in a new tab and clicking them will give you an overview.  Currently no admin approval but this will change if they are abused.
<li>- SSj 3 no longer reduces recovery but has a slightly higher drain.
<li>- Architect now causes you to deal double damage to buildings.
<li>- At >1mil, >7mil and >15mil BP powering up will now have extra visual effects.
<li>- You may now eat all the time but you only gain the benefits of the most recently eaten meal.
<li>- Issues addressed with building HP in regards to blasts vs beams.
<li>- Fixed bugs with drones/dolls.
<li>- New spell called Seance, allows you to summon a spirit from the AL for 3 months. Magic_Level>=68 and Magic Mod >2.5, base cost of 40million mana.
<li>- Homing Finisher now has 50 blasts max instead of 66 and now has 1.6x damage mult instead of 1.9x.
<li>- You must be age 5 instead of 8 in order to be Set as Student.
<li>- Block updated. Reduces your Speed, Offense and Defense by 30% for 6 seconds in exchange for +40% Endurance. This will also increase chance to deflect projectiles by 30%.
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.41 (???) - 2/17/20</b>
<li>- You can now only be genetically sequenced three times.
<li>- Souls now return to the AL with <30% Willpower
<li>- Custom Hair will now properly turn grey. (Requires you to set it once more)
<li>- Absorb once again reduces your HP/Energy ticks, up to -40% at a full absorb.
<li>- Various descriptions updated.
<li>- Androids are treated normally on death, no auto revive and they proceed to the AL.
<li>- Tech Item: Cloning Tank, 106+ Int, 5+ Mod: This will revive you if you are killed and it is still intact. It will take about five minutes to be revived. Each time you are cloned and the cloner is activated, you lose 30% of your Base BP. 15,000,000,000 base cost. Can not be moved, can not be created inside ships, personal realms or the AL. You will need to age up 4 years after being cloned to be full body again.
<li>- Tech Item: Android Uplink Mainframe, 2,500,000,000 base cost serves as a cloning machine for androids. 3+ Mod, level 76+
<li>- New MP: Elite Gun Training This will cause any guns you fire to be modified by your BP multiplier and increases accuracy by an additional 20% of your offense. Costs 2 MP and requires NRA.
<li>- Guns BP now scales based on the person who upgrades its Int Mod.  This is a nerf below 4.5 Int, the same at 4.5 and a buff above that.
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.40 (???) - 2/15/20***
<li>- Injuries no longer reduce your flee roll.
<li>- You need to be 5+ to use SSj/Transformations.
<li>- Sword Force/Bushido no longer reduces Recovery/Endurance.It now gives 45% BP instead of 50%.
<li>- Beam stagger changed to a probability to occur, based on the damage of the beam.
<li>- Snares and Freezes now have some redundancy for removing themselves, should lead to less infinite stuns/snares.
<li>- Flight Master enabled again. No longer grants immunity to KB. Now increases fly gains by 50% instead of 20%.
<li>- Shockwave and Earthquake no longer make items scatter.
<li>- Knockback no longer automatically stops charging beams, but now has a 25% chance per tick.  Freeze based stuns now cause you to stop charging and firing beams.
<li>- Rock Throw now fires from your tile instead of the tile infront of you.
<li>- Reincarnation now causes you to keep more of your BP, Energy and Stats and all of your passive skills. (Unarmed, Weapon, Ki, Athlete)
<li>- Examine will now display Builder to all mods/admin.
<li>- Shield description updated. (Not retroactive)
<li>- Can no longer name objects to Space Mask/Air Mask.
<li>- Shrapnel icon changed to be small rocks.
<li>- Countdowns now show up in all combat, general and local tabs.
<li>- Charging an attack now sends a message in all combat, general and local tabs.
<li>- Ritual of Power now lasts 2 years and has a cooldown of 3 years.
<li>- New Tech item Rocket Booster which will allow you to launch into space and then is destroyed after. 66 Int, 1+ Mod.
<li>- Augment Power no longer has the 'resist' verb. Augment Master removed for next wipe. No longer reduces Recovery but now reduces the energy per Recovery tick.
<li>- Kanassan Precognition now adds to their chance to hit, not just dodge.
<li>- Everyone, even reincarnations, will now receive full catch up MP. This is limited to half when they make and half after save age 5.
<li>- New buff, Will of the Dead: counts as 2 Buff Slots. It grants 1.8x BP, 1.8x Strength, 1.8x Force and disables Regeneration while active. It has no drain.
<li>- New buff, Thorns Aura: this ability will increase your BP by 1.4x, lower your Endurance to 0.7x. Also causes your damager to take 30% of the damage they cause you.
<li>- Splitforms now have 90% of your BP instead of 100.
<li>- Punching Bags no longer move away after being punched.
<li>- Expand/Bulk no longer affect SSj hair.
<li>- Mana and Gold fish now give more stuff.
<li>- New item, Helmets. Copper Helmet causes you to not be reached by telepathy, Bronze causes no telepathy and your status bars are hidden like an androids, iron causes you to not be observable, mythril causes you to not show up on sense. They all include the benefits of the previous ranks. Use a Sentai Helmet (clothing) and infuse it with copper(requires level 25),then level 40, then 55, then 70
<li>- Helmets are now exclusive with Armor. Helmets can be enchanted. Agile Nature will not work with Helmets. Masterwork Helmet added and it hides your BP.
<li>- Range of Motion now increases Offense and Defense by 10%.
<li>- Fixes

<p>
<br>
<b>Roleplay Tenkaichi version 1.39 (???) - 2/13/20</b>
<li>- Energy Marksmanship cost reduced to 3 from 5. (2 refunded to those that had it)
<li>- You can no longer mate in decline.
<li>- Power Armor changed to 100 Int, Gundam changed to 130.
<li>- Both teleporter pads need the upgrade in order to leave Z planes.  Cost for the upgrade reduced.
<li>- Alignment fixes.
<li>- You now lose 5% accuracy and damage from using a novice stance instead of 10%.
<li>- Fixes


<p>
<br>
<b>Roleplay Tenkaichi version 1.38 (More Alignment Stuff) - 2/09/20</b>
<li>- Masterwork Armor: -10% Speed, + 15% BP towards Endurance
<li>- Mythril Armor: 100% Speed, 100% Endurance
<li>- SNj req lowered slightly. Gives more speed.
<li>- Check Updates button under Help menu
<li>- Majin/Mystic now disabled if you have >0 or <0 Alignment, respectively.
<li>- Soul Sunder no longer removed Keep Body.
<li>- Fixed a math issue with BP Cap calculation.
<li>- Not killing someone for more than 7 years will now cause your alignment to tick towards Pure/good.
<li>- Fixed an issue with teleporter watches requiring more int to use than make.  Watches now require 2+ Int Mod to use.
<li>- Alignment drift towards neutral CD reduced from 3 years to 1.5 years.
<li>- Ranks with access to rank chat now have the ability to mark someone as good/evil, which will alter their alignment slightly.  This is encouraged to be used liberally to aid in a more accurate alignment reading compared to character's IC.  Each character has a small CD of how often their alignment can be shifted in this way.
<li>- Fixes with combat tracker/willpower loss interaction.
<li>- Androids now properly trigger their God Ki tier BP Mod boost.
<li>- Adjustments to FBM and Ascension mods for some races.
<li>- Super Bojack 2 now has 1.1x Endurance.
<li>- Super Maximum Lightspeed Mode now grants 1.5x BP.
<li>- SSj2 now grants 1.35x BP.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.37b (Fixes) - 2/06/20</b>
<li>- Skills: Rock Throw Expert now actually functions like blast.
<li>- Improvements to the show stats window and status tab.
<li>- Int Focus and Magic Focus added as hidden verbs for quick toggling. (Type them into command bar.)
<li>- Ranks no longer need to wait 3 days to teach shield/power control after year 10.
<li>- Frost Nova CD increased.
<li>- Increased ore spawn rate in caves.
<li>- Increased odds of unique fish.
<li>- Sword Stab fix.
<li>- Ancient Namekian fixes.
<li>- Adjusted the extra WP drain while below 70% HP.
<li>- Wall of Flame should lag less.
<li>- Gravity Well should lag less. (No longer provides updates on remaining time)
<li>- Hellzone Grenade should lag less.
<li>- Beam Expert beams now 2.5x as large instead of 2.2x, should be a bit more clear when someone is using a multi tile beam.
<li>- New default skin layout.  Click info to return to classic style.
<li>- Fixes

<p>
<br>
<b>Roleplay Tenkaichi version 1.37 (Iowa Caucus Results) - 2/05/20</b>
<li>- Ranks: New "Skill Master" rank created under the "Space" category
<li>- Races: Kanassa are now a rare.
<li>- Races: Ancient Namekians re-created and now a rare.
<li>- Races: Aliens can now pick Precognition for 3 of their starter MP.
<li>- Races: Saiyans now roll a Class, and based on their class, will roll the class BP boost.  This class BP boost is designed to fall off around Year 10-15.
<li>- Races: King Kold Changelings will now auto learn their second form when they hit the req.
<li>- Skills: Blocking now lasts for 6 seconds instead of 2. Now reduces Offense, Defense and Speed to 70%, instead of Defense and Speed by 50%, and increases Endurance by +30%.
<li>- Skills: Self Destruct is now able to be cast in any round of combat, but requires 70 or less Willpower.
<li>- Skills: Imitate now only has a 20% chance to cancel on KO.
<li>- Skills: Beam now drains quicker the longer they are fired. Beam no longer has a flat cooldown of 3 seconds.
<li>- Skills: Observe no longer requires familiarity as it is major rank only.
<li>- Tech: Repairing items now costs 500k base instead of based on the total cost invested into the item.
<li>- Tech: Chests now have a max inventory limit and can be upgraded with smithing.
<li>- Magic: Crystal Ball now requires 5 or more familiarity with the target but now shows says and emotes.
<li>- Magic: Portals can no longer be used to cross between the AL and LR.
<li>- Admin: Admin Grant Anger now has three options.  Full Death Anger, Partial Death Anger, and regular Anger.
<li>- Admin: X Menu added to rick click, called Player Panel.
<li>- Armor Changes:
<li>= Copper: 120 Max Durability from 150
<li>= Bronze: 150 Max Durability (regular armor stats now)
<li>= Iron: 150 Max Durability 118% Endurance 65% Speed
<li>- Mechanics: You no longer need to be a Master in a stance to improve it, you may now do so as an intermediate.  This will allow people who were taught 3 point stances the chance to develop them without being overly penalized. (Custom Stance creation reduced to 8 MP from 11, this is not retroactive and no refunds will be offered.)
<li>- Mechanics: You may now Flee at any Willpower, but for every 10% below 70% HP you will lose 1 Flee mod. (70, 60, 50, etc)
<li>- Mechanics: Leg Injuries now reduce flee by 2 instead of 1.
<li>- Mechanics: Aliens now death regen at 50 WP instead of 70.
<li>- Mechanics: Admin logs will now be logged on discord as well.
<li>- Mechanics: Appoint Successor will now post this info onto the discord, similar to set student.
<li>- Mechanics: Legacy "Appoint Student" verb that the Hermits had is now disabled as it is made redundant with Set Student.
<li>- Mechanics: Willpower now drains quicker on each tick if you have less than 70% HP. This is to discourage people that intentionally wait for anger before fighting seriously in an attempt to 'anger snipe.'
<li>- Mechanics: Added Decisive Blows, when someone is at 30% HP or lower and in lethal combat they have a chance on each melee attack to deal +5% of their enemies current HP and add knock back. The chance scales with Refire, so the slower you attack the higher the chance.  This works with the new system that increases WP drain at low HP to prevent people intentionally getting you to low HP and 'bleeding you out.'  This chance is lowered if you use zanzoken combo warp.
<li>- Mechanics: All Racial transformation reqs are now normalized to refer to Base BP / BP Mod instead of some including anger or only using the Base BP.
<li>- Mechanics: Team Window no longer serves like sense and no longer contributes to server overhead.
<li>- Mechanics: Looting/Stealing from a living person is now done with the Injure verb.
<li>- Mechanics: Stats will no longer passively refresh and requires clicking on Refresh Stats.
<li>- Mechanics: Using Refresh Stats will now show a 'player' version of assess, instead of displaying the stat objects.
<li>- Server: Several optimizations put in place.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.36b (Aren't you glad I didn't say banana?) - 1/30/20***
<li>- Control of Power: now only grants +20% to recovery ticks instead of +50%.
<li>- Other undocumented fixes.
<li>- Time Freeze now has a 2 second minimum stun, but an 8 second maximum. (Reduced scaling rate)
<li>- Repair kits now restore things to full durability instead of just +25.
<li>- Some other stuff I forgot to mention.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.36 (You Stole Fizzy Lifting Drinks!) - 1/30/20***
<li>- Maximum BP from Absorb is now +50% of your Base BP.
<li>- Milestone Points: Clicking on Wipe Day will display total MP earned and how many more catch up you have.
<li>- Gaunlets Tiers:
<li>- Normal: +10% BP
<li>- Copper: +15% BP
<li>- Bronze: +20% BP
<li>- Iron: +25% BP
<li>- Mythril: +30% BP
<li>- Masterwork: +35% BP
<li>- Successfully grabbing someone with force them to release their grab.
<li>- Balance: Warp Combo will now carry on the combo if the target is within 1 tile and not directly behind you.  Should dramatically improve stickiness.
<li>- Balance: Beam drain increased.
<li>- Soul Contract: Allows you to KO those whose soul you possess if they are within 20 tiles.
<li>- Hellzone Grenade: now the blasts created geneate explosions that are about 35% the strength of regular explosion.
<li>- Genocide: now fires 20 blasts total before running out.  Blasts damage and BP increased slightly.  Firing speed increased.
<li>- Training Equipment: Should no longer be blocked by various roof tiles.
<li>- Adjustments to weapon stats.  In order to recalculate its description, just invest some Mana/Res.
<li>- Tech: Power Armor now accessed at Int 101+ with a 4+ Mod. Power Armor now has the option to create a Force Model which will increase Force by 20% instead of Strenth by 20%.
<li>- Tech: Gundam now accessed at Int 140+ with a 5+ Mod.
<li>- Tech: Power Armor can now be 'customized' up to 10 times, each customization functioning like an enchant and offering +1% to a stat, with up to 5 in a single stat.  Gundams can be customized up to 15 times. Base cost of 60 million per customization.
<li>- Tech: Gravity now costs 5000x Unit to refuel, down from 7000x Unit.
<li>- Tech: Prospecting Toolkits now scale with your Mining Level.
<li>- Reincarnation MPs now count towards your total, meaning that you don't lose MP on the 2nd+ reincarnation anymore.
<li>- Rare: Vampires reintroduced.  Vampirism now causes low HP to only reduce BP to 70% instead of 30%, grants 1 charge of Death Regen and some skills, but reduces Regen ticks by 50%.
<li>- Mining: Ore now has a lower spawn rate.  Earth, Namek, Vegeta, Icer and Arconia all have underground mines that generate Ore every month.  You may not build there. Requires 25+ Mining to access the mines.
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.35 (Wasn't ready but bugs) - 1/28/20***
<li>- Range of Motion now grants 8% Off/Def

<li>- Armor: New tiers of armor following the metal system. (Old armor should be compatible with upgrading)

<li>- Normal Armor: Same stats (113% End for 85% Spd)
<li>- Copper Armor: Same stats, 150 Max Durability
<li>- Bronze Armor: 120 Durability, 80% Speed for 115% End
<li>- Iron Armor: 150 Durability, 70% Speed for 118% End
<li>- Mythril Armor: 170 Durability, 100% Speed for 103% Endurance
<li>- Masterwork Armor: 200 Durability, no change to stats but increases defensive BP by 15%

<li>- Hammers: Normal +70% BP -15% Spd -25% Off
<li>- Copper: +85% BP -15% Spd -25% Off
<li>- Bronze: +70% BP -15% Spd -20% Off
<li>- Iron: +100% BP -20% Spd -30% Off
<li>- Mythril: +75% BP -15% Spd -20% Off
<li>- Masterwork: +100% BP -15% Spd -25% Off

<li>- Swords: Normal +45% BP -25% Off
<li>- Copper: +60% BP -25% Off
<li>- Bronze: +50% BP -20% Off
<li>- Iron: +70% BP -30% Off
<li>- Mythril: +45% BP -5% Off
<li>- Masterwork: +66% BP -25% Off
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.34 (We Dropped Several Logs) - 1/27/20***
<li>- Better Logs: Reduced redundancy with what gets logged to the server. Changed the intervals at which new log files are created, should lead to less server overhead and so less lag. Logs should be more centralized with less division. (IC and Say logs are now combined)  Disabled most 'full' logs, logs will now be divided by days of the week.
<li>- Ritual of Power base cost increased to 700million from 500million.
<li>- Magic: No longer has access to create the Magic PDA or Moon.
<li>- Magic: Gravity Well cost increased to 90,000 per level from 75,000.
<li>- Magic: Portal base cost increased to 70,000,000 from 40,000,000
<li>- Magic/Tech: No longer has access to fishing rods.
<li>- Mining: New item, pickaxes, which reduce mining time.
<li>- Smithing: Smithing now creates fishing poles and pickaxes.  They require Tin Bars + Heart of the mountain/fishing line.  Both are low rate drops from mining/fishing.
<li>- Smithing: Bronze+ Weapons now have increased max durability. Bronze 120, Iron 150, Mythril 170, Masterwork 200.
<li>- Tech: Now has access to Cooking Bag.
<li>- Tech: New item, Basic Forge, which will increase the speed of smelting if you are within 2 tiles. Base cost 4 million, level 35 and 2+ mod.
<li>- Tech: New item, Basic Stovetop, which will increase the speed of cooking if you are within 2 tiles. Base cost 2 million, level 30.
<li>- Tech: New item, Basic Chest, which will allow you to store items inside of it. When it is destroyed, it should empty its contents. (I would not store anything of high value until more testing is done.) 4 million base cost, level 28.
<li>- Tech: New skill, Calculated Strikes, which allows the user to target a certain area of their opponents body with limb damage. (2.5+ Int mod, 58+ level)
<li>- Tech: Mutagen Injection can now be used up to two times.
<li>- Tech: Transporter Watch now adds +3 to Flee rolls.
<li>- Tech: Adamantine Skeleton no longer has a chance to kill the target and is no longer exclusive with Cybernetic Limbs. (You can get both)
<li>- Tech: Morphine: Causes you to ignore limb damage, but while you have broken limbs causes you to drain WP at 1.5x the rate for each regen tick. (Lasts 3 IC days) This may be addictive. Level 40, 3+ Mod
<li>- Tech: Percocet: Causes low HP to only reduce BP to 70% instead of 30%, but reduces recovery ticks by 40%. (Lasts 3 IC days) This may be addictive. Level 30, 3+ Mod
<li>- Cybernetic Limbs: Cybernetic Legs now add +1 Flee roll each. (Total of +2 with both legs Cybernetic)
<li>- Cyberize: Now sets BP reduction from Int MPs back to 0%. (Old changes reverted)
<li>- Cyberize: Now hides your energy/HP like an Androids.
<li>- Damaged Limbs: No longer affect the multiplier for your stats, but the backend value.
<li>- Added some icons from Yumeko.
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.33 (Sometimes I add numbers instead of letters) - 1/26/20***
<li>- Weapon Rework: Weapons now have six stages; Normal, Copper, Bronze, Iron, Mythril and Masterwork. Each stage determines the maximum % of your BP that will be added to an attack. Example: Normal Hammer gives a max of +50% BP where as Masterwork Hammer gives a max of +100% BP. Changing the tier of a weapon requires metal ingots and smithing skill.
<li>- Normal Weapons: Hammer 50% BP, Sword 30% BP, Guantlets 10% BP. Copper: Hammer 60%, Sword 40%, Guantlets 15%. Bronze: Hammer 70%, Sword 50%, Guantlets 20%. Iron: Hammer 80%, Sword 60%, Guantlets 30%. Mythril: Hammer 90%, Sword 66%, Guantlets 33%. Masterwork: Hammer 100%, Sword 75%, Guantlets 40%.
<li>- Existing weapons will be treated like Copper, tier 2, weapons.  You may ahelp to have them refunded.  They will not be compatible with the ingot system.
<li>- Smithing: You may now use metal ingots to Practice Smithing which will grant Smithing XP in exchange for destroying the metal.
<li>- Spawn rates of all ores increased.
<li>- Empowered Attacks and Defenses now affects the user.
<li>- Elixirs of Empowerment are now magic exclusive instead of tech exclusive.
<li>- Magic repairs are now a flat cost, base of 800,000 mana.
<li>- Armor repairs are a flat cost with a base cost of 500,000.
<li>- Book of Power boosted to 1.05x BP Mod and 1.2x Base BP.
<li>- Cyberized People now suffer -5% BP instead of the reduction from Int MPs.  It will no longer cancel the loss entirely.
<li>- Spell/Ritual Of Power: This will allow you to perform a ritual that will consume a large amount of mana but will change the BP% lost from Magic MPs from 5% per level to 1% per level for 2.5 years. (Base cost 500,000,000 mana. Level 65+ Magic with 1+ Magic Mod)
<li>- Create Portal now adds +3 to Flee rolls.
<li>- New in game Suggestions and Bug Report verbs.
<li>- Default inventory is now 15, 25 with Beast of Burden.
<li>- Magic Fishing Lure increased in base price.
<li>- Added Prospecting Toolkit as a way to generate ore.
<li>- Fixes

<p>
<br>



<b>Roleplay Tenkaichi version 1.32A (Sometimes I add letters instead of numbers) - 1/25/20***
<li>- Fixed issues with the new rank teaching alerts.
<li>- Genocide now reduces speed by 50% while active but shoots faster. Bonus Offense reduced from 1.5x to 1.1x. You can now grab someone that is using Genocide.
<li>- You can no longer use Zanzoken while charging or firing ki. (You can still use the Instant Transmission click to move)
<li>- Solar Flare now scales eye damage based on user Force against target End. (25 + (30 x (BP + Force) / (Enemy BP + Enemy End) ) )
<li>- Second generation aliens should now get their starting MP. (Only full blood aliens)
<li>- Ore will now crumble away with fish.
<li>- Extension Of My Arm(2): New MP which causes swords and hammers to no longer take inventory slots and to also increase limb damage on attack verb when using sword or hammers by 50%.
<li>- Offspring now get the same catch up as first generations but still do not earn their own MP until 5+. (When you make you are credited 0.5 x Year as Catch Up MP and redeem 1 every month tick until they are gone)
<li>- Fixes

<p>
<br>

<b>Roleplay Tenkaichi version 1.32 (There's 150 Or More To Catch. To Be A Fish Monger Is My Destiny!) - 1/24/20***
<li>- Refunded Gravity Well. Now requires 50+ Magic Level to unlock
<li>- Quality of life improvements for ranks: Ranks can now use an in game verb to mark their students which will automate posting it to the rank discord channel.  Using the Set Student verb will produce a list of all the skills/moves  you have that will require this marking process. Once marking someone it will generate the year that you will be able to teach them/use the thing on them. The skills that require this approval will not be able to be used without it.
<li>- Genocide now has a cooldown, drains more for each blast and has a longer delay between each blast.
<li>- Several Fishing Poles added that quicken fishing time.  Will eventually add different cookware that will do the same for cooking. Both tech and magic for now.
<li>- Admin: Added Assign_Builder which will allow us to manually fix the issue where the owner of the building is lost.  Please exercise caution.
<li>- Repair Kits now require 19 int instead of 29. Base cost reduced from 1million to 800k.
<li>- Started framework for mining and smithing system. You can currently find ore that occur on Ground type turf.  The ore can be mined and then smelted into ingots.  At this time they have no use but will in the next update.
<li>- Book of Lessons bp gains boosted significantly. (from 3x to 7x) Now lasts 1 year instead of 6 months.
<li>- Three new fish types added. BP, Energy and Stat Fish that increase the training of their namesake.
<li>- Fixes
<p>
<br>

<b>Roleplay Tenkaichi version 1.31 (This Is A Test Of The Emergency Broadcast System) - 1/23/20***
<li>- Body HUD now defaults to be off.
<li>- Beast of Burden now gives 3% strength.
<li>- March of Fury has a slightly better description.
<li>- Attempt to fix issues with Imitate causing people to lose their energy signature.
<li>- Changes to assess.
<li>- Changes to profiles to use 'Description' language instead of 'Backstory'
<li>- Deep Breathing now costs 1 MP per rank from 2. Now has 2 ranks max and each rank gives +12.5% energy to recovery ticks from +8% and 4 ranks.
<li>- Mana Expert and Mining Expert now give 1.8x gains instead of 1.5x.
<li>- Philosopher's Stone reworked into a unique item/event reward.  It grants +0.5 Regen.
<li>- Aspect of Flight, a unique item/event reward, added which grants +5 to Flee rolls.
<li>- You can now minimize the team window.
<li>- Most skill based MPs will now only show if you have the skill. (Like Zanzo mastery and Beam Expert)
<li>- There is now a toggle on the build window to use mana to pay for building instead of resources.
<li>- Technology can now make Hammers.
<li>- Framework for Fishing/Cooking system added. Water tiles have a chance to generate fish each month, which can then be fished up and cooked. Eating cooked food will grant a temporary boost to Regen, Recov, or WP regeneration, or all three. The boost is currently +10% per tick and doesnt not affect the variable directly.
<li>- Magic has a new item called a magic fishing lure that will spawn fish into nearby water tiles for fishing.
<li>- New items for fishing. Cooking bags, which grant unlimited storage of raw and cooked food.
<li>- New items for fishing. Magic Fish, 1% chance to catch over level 7. Eating cooked magic fish will grant capped stats. Requires 25 cooking.
<li>- New Fish: Gold Fish, when cooked create resources.
<li>- New Fish: Mana Fish, when cooked create mana.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.30 (tHe Event on Lame ass Planet vegeta will Mean Everyone has fun!) - 1/21/20
<li>- Auto Driller now costs 3 MP instead of 6.
<li>- Mana Siphon now costs 4 MP instead of 6.
<li>- Bull's Eye now grants 2.5% flat chance to hit with blast based projectiles, up from 1.25%.
<li>- Fixes to Make Weights and Materialize costs and cost display.
<li>- You may no longer immediately teach something upon being taught it.
<li>- Chakra Blocking now lasts for 16 seconds instead of 20 seconds and has a slightly longer cooldown. It drains 1.2% per attack from 1.5% and with warp on 0.2% from 0.3%.
<li>- Changes to alignment tracking and its interaction with the Judge. Alignment will now slowly drift towards Neutral every few years if you are not very good or very evil.
<li>- Force Fields will now be destroyed upon reaching 0 battery.
<li>- Mortar Charge energy requirement lowered to 7500.
<li>- Sokidan is now on the auto learn list for 10,000 energy, 7500 force and >9000 ki manip.
<li>- All skills should now properly check for Key Ring and Boundless Stamina when determining teach eligibility.
<li>- Leg injuries no longer affect offense and defense, only speed.
<li>- Eye injuries now show the Off/Def reduction front end instead of backend.
<li>- Changelings now have a Tail body part. It does not affect stats and is only for flavor.
<li>- Ammo will no longer get stuck reloading.
<li>- Bullets are now much more visible.
<li>- Fixes
<p>
<br>
<b>***Roleplay Tenkaichi version 1.29 (This Update Brought To You By Raid: Shadow Legends) - 1/??/20***
<li>- Digging no longer increases stats.
<li>- Confirmation window on creating tech/magic.
<li>- Control of Power now has a more clear explanation.
<li>- Changes to where LOOC gets filtered. Local tab now will not include LOOC.
<li>- Some bugs that were reported fixed.
<li>- No longer limited to learning one stance at a time.
<li>- Receiving an 'updated' stance will no longer overwrite its mastery level.
<li>- Other fixes and stuff.
<li>- Fixes
<p>
<br>
<b>***Roleplay Tenkaichi version 1.28 (Did You Miss My Bad Update Notes?) - 1/15/20***
<li>- Various things adjusted.
<li>- Some bugged admin commands disabled.
<li>- Various things fixed.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.27 (The Map is Still Broken Edition) - 1/04/20***
<li>- Languages: Removed Common for Saiyans, Namekians
<li>- Languages: Removed English for Namekians
<li>- Languages: Removed Arconian from Heran
<li>- Languages: Removed Saiayn from Changelings, Heran
<li>- Languages: Added Common to Oni
<li>- Saiyans given +0.1 speed mod (1.8 -> 1.9)
<li>- Custom aliens now correctly have 70 stat points to spend, up from 65.
<li>- Burning Shot adjusted to +10% BP rather than +20%
<li>- Flight Master, Custom Language, and Second Type milestones disabled, pending fixes.
<li>- Philosopher's Stone disabled, pending fixes.
<li>- Building Permit increased in cost from 1 milestone points to 3.
<li>- Trippled the effect for Architect in relation to resource investment. (x9 instead of x3)
<li>- Gravity Machines and Wells now start scaling at 51 INT/MAG rather than 1. Gravity will start lower and won't raise as high. (effectively 300x lower)
<li>- Energy requirements  on the following were reduced: Shunkan Ido, Namekian Fusion, Leave Planet
<li>- Time Freeze now takes twice as long to come off cool down.
<li>- Dark Bargain now has a base cost of 6 billion rather than 200,000. Still isn't prompting Demon Lord correctly (Sorry.)
<li>- Cyberize base cost raised from 25,000,000 to 3,500,000,000 (Save up techies)
<li>- Magic mask disabled
<li>- Flight Master no longer prevents you from being knocked out of flight.
<li>- Fixes
<p>
<br>
<b>Roleplay Tenkaichi version 1.26 (Try Not To Break The Map Edition) - 11/18/2019***
<li>- Burning Shot minimum cooldown reduced.
<li>- Philosopher's Stone now grants 0.5 x Magic Mod x Regeneration Mod instead of 0.75x. (1.5x Regen at 3 Magic, 3x at 6)
<li>- Combat Tracker duration tiers adjusted. (Used to be >90, >60, >30, 0 HP tiers, now >80, >40, 0 tiers)
<li>- Attempt to wipe Heaven and Hell maps in order to fix the lag issues. (Both maps were fully player made and caused a lot of sluggishness)
<li>- You may now Flee/Chase at any willpower but your willpower will affect your roll add. (-1 <80HP,-2 <60HP, -3 <40HP, -4 <20HP)
<li>- You can no longer use teleporter watches to change z planes.  Only teleporter pads will do this.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.25 (Poopy Chewyy) - 11/17/2019***
<li>- Beams now use a 0.3x damage multiplier for charge rate instead of 0.5x.
<li>- All beams can no longer be charged past 20x.
<li>- Reduced the duration of Frost Nova. (1.25x from 1.75x)
<li>- Concentrated Fire now grants +15% damage to your target instead of 18%.
<li>- Burning Shot now grants +20% BP instead of 30%. In additon, each attack of the combo deals regular damage instead of 150%.
<li>- Philosopher's Stone now grants 0.75 x Magic Mod x Regeneration Mod instead of 1x. (1.5x Regen with a 2 Magic mod, 2.25x with a 3, 3x with a 4, 3.75x with a 5 and 4.5x with a 6)
<li>- Berserking now reduces Regeneration and Anger by 25% instead of 50% and Defense by 25% instead of 20%.
<li>- Pile Driver will now attempt to grab the person in front of you if you dont have someone grabbed before casting.  Its CD was reduced.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.24 (Chewyy poopy) - 11/16/2019***
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.23 (I Don't Have A Good Name Idea) - 11/12/2019***
<li>- Grand Explosion costs less energy.
<li>- Beams no longer slow. (Bug fix attempt)
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.22 (RT Thanks Our Veterans... Both Sides) - 11/11/2019***
<li>- Time Freeze adjusted.
<li>- Added an option to ignore other player's OOC.
<li>- Chakra Blocking now drains 1.5% per hit without combo and 0.3% with combo. (Refunded)
<li>- Other stuff too.
<li>- Fixes.

<p>
<br>
<b>Roleplay Tenkaichi version 1.21 (Drink Milk To Reduce Limb Damage) - 11/10/2019***
<li>- Some stuff changed.
<li>- Stuff for less lag.
<li>- You may no longer stack Adamantine Skeleton and Cybernetic Limbs. (Everything that already has it is grandfathered in)
<li>- March of Fury now costs nice 6 MP.
<li>- Kill Driver now costs 5 MP.
<li>- Way of the Fist now costs 6 MP.
<li>- Energy Marksmanship now costs 5 MP.
<li>- Mortar Charge is now an auto learn with a highy requirement. (Some ranks still get it/can teach)
<li>- Scatter Shot will now automatically use your Target if you have one. If not, it will give you a pop up.
<li>- New 8 cost MP called Berserking. Berserking reduces your Regeneration and Anger by 50% and decreases Defense by 20% but causes you to take less damage the lower your HP is, down to 50% damage taken at 50% HP.
<li>- New Manual Block skill that sacrifices speed and defense for endurance.
<li>- Fixes.

<p>
<br>
<b>Roleplay Tenkaichi version 1.20 (I hate chewyys system that requires me to double post all these update notes in order to get them to show up) - 11/10/2019***
<li>- Pressure Punch now has increased accuracy.
<li>- FPS restored to 20.
<li>- Kaio Revive no longer reduces decline.
<li>- Decline no longer has any penalties or benefits.
<li>- Some buffs adjusted.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.19 (Exhale) - 11/08/2019***
<li>- Energy Marksmanship boosted to +15% chance to hit for blast. Also adds +5% homing on to any blast-based projectile.
<li>- Regrowing a limb now costs 10 Willpower.
<li>- Gain Multiplier rate slowed slightly. Cap increases will occur more often now.
<li>- Server FPS dropped to 10, down from 20. Experiment to investigate server load and lag.
<li>- Death Regen timer should now be more accurate. You will now respawn with 70 Willpower.
<li>- New Weapon skill called Riposte which will cause you to counter and disarm any attack made against you within the next 6 seconds. (8 seconds disarm)
<li>- New Unarmed skill called Catch The Blade which will cause you to disarm any attack made against you within the next 6 seconds. (16 seconds disarm, negates the attack's damage if you are wearing gauntlets)
<li>- Healing Pylons disabled pending bug fix.
<li>- Philosopher's Stone regen boost now displays in status tab.
<li>- Basic Blast energy cost reduced.
<li>- Adjusted Kaioken drain loop. (No longer uses event scheduler)
<li>- Forcefields now only activate 70% of the time instead of 100%. They now block 30% damage.
<li>- Cybernetic Limb replacement fix attempt.
<li>- Makyo Transformation now gives 1.3x Off instead of 1.25x
<li>- Blast Projectile base hit chance increased to 55% from 53%.
<li>- Disarm is a status effect that will eventually run out.  It does not actually unequip your weapon.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.18 (Inhale) - 11/07/2019***
<li>- Absorb drain slowed to 1/2 the rate, only drains on month ticks now as opposed to on relog/etc
<li>- Reincarnations will no longer earn catch up MP.
<li>- Mysticize mystic is now 1.4x Recov instead of 1.5x
<li>- Added a new MP called Bulls Eye which increases chance to hit with all projectiles by 1.25%, costs 1 MP and has 4 ranks.
<li>- Added a new MP called Deep Breathing which increases your energy recovery ticks by 8% per rank. 4 ranks max, 2 MP a rank, does not affect Recovery stat, just the energy tick.
<li>- Anger now triggers at 50% HP instead of 50 HP. (Affects Resolve of the Mountain users)
<li>- Buffs that grant Anger will now retrigger Anger with the new Anger mult if you are already Angry, granting the affected Anger when you re-Anger.
<li>- Blue Comet Special cooldown increased and damage multiplier decreased to 3x from 3.3x.
<li>- Various support skills have had their mana/resource costs reduced.
<li>- Stuff that was changed but would take longer to explain than the changes took to make.
<li>- Basic Blast damage adjusted slightly. (-10% damage)
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.17 (Tinder Bio Edition) - 11/04/2019***
<li>- Chakra Blocking now has the proper multiplier for combo attacks.  Combo is 5x faster, so chakra drain under combo is 1/5.
<li>- Changed profile format and available options.
<li>- Imitate will now 'steal' someones profile for the duration.
<li>- Yardrat transformation drain reduced. (was 1.3% per tick, now 0.7%)
<li>- Magic Masks will now degrade slower.
<li>- Magic  Mask will now only increase the BP on beams by 20% instead of the normal 33%.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.15 (Hello, Welcome to my Wendy's) - 11/02/2019***
<li>- Some projectile based attacks buffed.
<li>- Decline no longer reduces body % or BP.  It now instead causes you to gain an extra 0.5 MP every time you earn one normally (not catch up), causes you to take increasingly more damage from attacks depending on how into decline you are and reduces your regen/recov based on how far into decline you are. (Only applies while alive)
<li>- Blast drain reduced slightly.
<li>- Gravity machines are now less expensive to refuel.
<li>- Beam stagger reduced slightly.
<li>- Kill Driver stun chance reduced to 50% from 66%. Added 1.5 seconds to CD.
<li>- Reduced Wall of Flame stun by 2 seconds.
<li>- Telepathy no longer works with realm teleport.  Only ranks may telepathy in/out of AL.
<li>- Shockwave and Earthquake should lag less now.
<li>- Rapid Deployment now grants +2 to Flee/Chase rolls.
<li>- Fixes.
<p>
<br>

<b>Roleplay Tenkaichi version 1.14 (Happy Halloweener) - 10/31/2019***
<li>- Wing Clip, Rock Tomb and Telekinetic Pull all now cost 2 MP.
<li>- Ki Blade reduced to 4 MP from 6.
<li>- Chakra Blocking now costs 5 MP.
<li>- Demonic Fury and Majin buffed/reworked slightly.
<li>- Demigods are no longer sterile. (Only produce Demigods)
<li>- Majin now causes you to anger at 55 HP instead of 50.
<li>- Drill Towers and Pylons can now be bolted.
<li>- Reincarnations now keep 100% of their MPs and slightly more gain multiplier.
<li>- Dummy gains increased.
<li>- Oni are no longer asexual. (Ahelp for a gender, Half-Oni will get Giant Mode)
<li>- Wing Clip now applies the solar flare stagger on hit.
<li>- New verb, Check Stat Points, under the help menu shows your build.
<li>- Gravity Well now costs 75k per level as opposed to 150k. It now costs 5 MP instead of 7.
<li>- BP % while dead with Body changed to 70% from 80%.
<li>- PU drain formula altered slightly.
<li>- War buffed slightly.
<li>- Expand/Makyo Expand buffed.
<li>- Fixes.
<p>
<br>


<b>Roleplay Tenkaichi version 1.13a (Hotfixes for SpacePods Pro) - 10/30/2019***
<li>- Rock Throw Expert now costs 1 instead of 2 MP.
<li>- Mortar Charge now costs 2 MP instead of 1.
<li>- Wing Clip now costs 3 MP instead of 4.
<li>- Fixes.
<p>
<br>

<b>Roleplay Tenkaichi version 1.13 (SpacePods Pro: Available 10/30/2019) - 10/29/2019***
<li>- Makyo Form drain reduced.
<li>- Refresh button added to refresh stats.
<li>- Ray is now an immediate fire beam with 0.7x damage and 1x charge rate.
<li>- Kill Driver buffed.
<li>- New music for level 4 + admin
<li>- Fixes.
<p>
<br>

<b>Roleplay Tenkaichi version 1.12 (Balance and Fixes) - 10/27/2019***
<li>- Ray received a slight buff to charge rate and damage.  Up to 0.75x from 0.5x charge rate and 0.25x damage from 0.2x.
<li>- Base Armor chance to block altered to 25% x Evasion for regular armor and 40% x Evasion for power armor and gundams. (from 40, 50) Armor blocking now reduces damage to 0.8x instead of 0.75x.
<li>- Burning Fists now works with ki fists and ki blade.
<li>- You can no longer use Burning Fists and Bleeding Edge together.
<li>- Physics Simulation now grants 1.2x Speed in addition to the other boosts.
<li>- Tuffle BP mod increased.
<li>- Cyberize BP decreased. Cyberize now requires 2+ Int MPs for target or learning.
<li>- Cyberize is now learned by all techies with 2+ Int MPs. Cyberize now cancels the BP loss from taking Int MPs but disables the ability to use power armor and gundams.
<li>- Fixed issue with Pbags interacting with non Flyoverable walls.
<li>- Bleeding Edge and Burning Fists refunded.
<li>- Bleeding Edge now costs 4 MP.
<li>- Base cost for Gravity Well cast reduced to 150k from 400k.
<li>- Death Anger no longer requires the killer to be Bad or Very Bad.
<li>- Spirit Bomb and Death Ball now function in the same manner as Spirit Ball, moving towards the user's mouse clicks.  They have a high chance to track towards the user's target but within a short range.
<li>- Crystal Balls require 3+ Magic Mod to use.
<li>- New Sword Master Skill called Echoing Slash that launches a strength based blast and then causes the user to teleport to anyone it impacts and launch a CDless attack.
<li>- Refire multiplier changed from 35 to 33.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.11 (To Ryu: The old PCE was FAR better than the current!) - 10/25/2019***
<li>- Way of the Fist buffed to 15% strength.
<li>- Rapid Deployment now grants 5% speed.
<li>- Energy Marksman increased to 10% accuracy.
<li>- Power Control Expert reduced to 0.4 Recov(+5% PU) and down to 5 MPs from 7.
<li>- Range of Motion now costs 6 MP up from 5, increases off and def by 7.5% instead of 5%.
<li>- Changed behavior for beam expert.  It now functions as one beam in 3 tiles instead of 3 different beams. This beam will get +10% damage.
<li>- Piloting a ship now requires 2+ Int Mod or a new 1 cost MP called Pilot Skill.
<li>- New MP called New Type which allows a user to pilot a power armor or Gundam without having the required Int Mod but in exchange for not receiving any BP. Costs 2 MP.
<li>- New MP called Kill Driver which costs 8 MP and slows on hit and has a chance to stun with a relatively short CD.
<li>- The Seed is Strong now reduces your Offspring's incline age by 2, this will stack if both parents have it.
<li>- Spirit Dolls buffed. (Not retroactive, requires admin help for old SDs)
<li>- Alien Ascension buffed slightly.
<li>- New MP, March of Fury: You charge towards your target, rushing towards them no matter the obstacle. You will launch 4 basic melee attacks on your path, one every half second. (8 MP, strong gap closer)
<li>- Chakra Blocking reintroduced and reworked slightly.
<li>- New MP, Control of Power: This will cause you to recover energy at 1.5x the normal rate and increases your power up cap ratio by 2.5%. 10 MPs and requires PCE.
<li>- Zanzoken Mastery buffed to reduce the cost down to 5% instead of 25%.
<li>- TK Pull MP cost reduced to 3 MP from 5.  TK Pull Master MP reintroduced at 1 MP cost.
<li>- Fixes.
<p>
<br>


<b>Roleplay Tenkaichi version 1.10 (Will the real RyuShinta please stand up?) - 10/23/2019***
<li>- Ki Blade now gets 30% strength instead of 25%.
<li>- Ki Fists weapon damage is now 18% instead of 20% BP.
<li>- Blaster velocity increased, damage decreased.
<li>- Super Kamehameha is now a different verb from regular Kamehameha.
<li>- Adjustments to homing blasts.  Now reduces damage by 20% instead of 40% and has a higher chance to "track" onto the target but now has a higher drain.
<li>- Ranks are no longer limited to 1 teach per month.
<li>- Sokidan now has a minimum cooldown of 6 seconds.
<li>- Throw will no longer anger snipe.
<li>- Concentrated Fire now deals +18% damage to the target.
<li>- Friend or Foe now deals +9% damage to those not on your team.
<li>- Restore Youth no longer takes the user's decline and now always sets the target's to their incline age.
<li>- Throw bug fixed.
<li>- Custom Language MP disabled until it is fixed.
<li>- New Make Statue verb.  Does what it sounds like.
<li>- Makyo Trans/Star interaction fixed.  When the Makyo Star is active, it grants a Makyo 1 charge of their transformation.  Using this charge will consume it until the next makyo star but allow unlimited use of their transformation within a two month period.
<li>- Several learn and teach reqs lowered.
<li>- Majin now grants 1.1x Endurance, slightly slower Regen boost as a result.
<li>- Key Ring now grants 1.1x max ki.
<li>- Mortar Charge and Rock Tomb added to MP list for 3 points each. Only teachable by ranks.
<li>- Throw damage normalized.
<li>- Milestone Catch Up altered.  Should no longer cause you to go "into debt." You should now always earn one on your birthday (If you are a second gen you must be 6 or older first), and you will earn catch up every month until you have atleast 1/2 of the Year as a first gen or 1/4 of the Year as a second gen.
<li>- Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version1.09 (Ryu's back, tell a friend) - 10/21/2019
<li>- Homing Blasts is now an option under default blasts that reduces their damage in exchange.
<li>- Added Player Profiles! Change information under Customization --> Profile Options!
<li>- Made Throw easier to use in combat (shouldn't break anything...)
<li>- Possibly resolved issue with Offspring being unable to make due to being required to select an age
<li>- Fixed issue where new hammer skills and sword stab were not in learn list
<li>- Early version of a Body Change technique implemented for Admin testing
<li>- Fix for Makyos transforming without Makyo star early on in wipe
<li>- Adjusted BWM resist cooldown
<li>- Tweaked Lightning Bolt damage (lowered)
<p>
<br>
<b>Roleplay Tenkaichi verion 1.081 (Back Again) - 10/18/2019
<li>- Deflected blasts now properly lose their homing nature.
<li>- Wise Mentor now speeds up language teaching as well.
<li>- Various Fix attempts.
<li>- Kaioken damage reduced by about 5-10% per tick
<li>- Beast of Burden now grants 2.5% Strength.
<li>- Forceful Negotiator improved to 13% Force from 10%.  In addition it now costs 6 MP instead of 7.
<li>- Added a Mass Introduce verb in the Other tab.
<li>- IC tab changed to Local.
<li>- LOOC now defaults to the Local channel.
<li>- Hammer Time now costs 5 MP instead of 6.
<li>- Thundering Blows now costs 4 MP instead of 6.
<li>- Changed Faction Update method in an attempt to reduce lag.
<li>- Ki Fists is now an auto learn.  All those that purchased the MP have had the MP refunded but get to keep the skill for IC purposes.  Ki Blade still requires Ki Fists to learn.
<li>- Basic Blast damage reduced slightly and heat seeking reduced slightly.
<li>- Throw may deal damage.
<li>- Alien MPs must now be spent within the first month if they wish to purchase one of the racials.
<p>
<br>
<b>Roleplay Tenkaichi verion 1.08 (Guess Who's Back?) - 10/17/2019
<li>- Meditate/Train/Being KOd will now automatically stop auto attack.
<li>- Ki Manipulation gain from Meditate reduced.
<li>- Added an option to focus on Energy instead of Force.
<li>- Concentrated Fire milestone reduced to 5 cost down from 7.  Damage to target increases to +10% from +5%, damage to those untargeted increased to 95% from 90%.
<li>- Wise Mentor milestone is now free for ranks.
<li>- Kiai cooldown multiplier reduced to 1.3x from 3x.
<li>- Added two new interactions with beams.  Beams that deal 1.5 or more damage in a tick have a chance to stagger an opponent's movement which will slow them and has a chance to cause them to "trip" and not move.  Beams that deal 4 or more damage in a tick have a chance to push their target in the same direction they are moving. Attempting to move reduces the counter and will help you break free.
<li>- Trying a new method for heat seeking blasts.
<li>- Destructo_Disc drain and delay reduced. Adjustments to how handles dodge/deflect.
<li>- Lightning Bolt's travel distance reduced to 3 tiles from 10 tiles, should be much easier to hit now.  May require further adjustemnets.  Damage increased too.
<li>- Ki Fist will now act as though you have a 20% weapon if you do not have better gauntlets equipped.  Ki Fist damage ratio changed from 0.85 Strength and 0.2 Force to 0.75 Strength and 0.3 Force.
<li>- Flight Master flying speed boost increased to +50% from +25%. It now grants +20% gains for flight as well.  It also grants Fly if you do not currently have it.
<li>- Ki Manipulation gains from flying and blasting reduced.
<li>- Weapon Mastery and Unarmed Skill gains from self train and sparring reduced.
<li>- New Atheleticism Skill introduced.  (Currently has no effects)
<li>- Burning Fists changed to 4 milestone points and now works with all weapon types. Drain per attack increased.
<li>- Final Flash is now 3 tiled.  Kamehameha is now 3 tiled when mastered.
<li>- Masenko and Galic Gun received minor buffs.
<li>- Pile Driver damage mult increased to 2x from 1.5x.  Cooldown mult reduced to 1.9x from 2.5x. Animation should work now.
<li>- Genocide damage mult increased to 0.5x from 0.3x.  Genocide blasts now have 1.5x Offense.
<li>- Guns are now balanced around a 2x Force mod instead of 1.5x. Spread guns were not getting their stats applied properly, now fixed.
<li>- NRA Membership now grants a 30% chance to not consume ammo and grants +20% Offense when firing a gun. Additionally gives a 20% chance to bend the bullet's trajectory (Think the movie Wanted) which grants heat seeking.
<li>- Emote and Admin Help windows are automatically set as active when you open them.
<li>- Telekinesis, both magic and regular, now apply a stacking snare on the target for each tile moved.  Attempting to move reduces the counter and will help you break free.
<li>- Basic Beam damage reduced slightly.
<li>- Named Beams now have a cooldown based on their charge rate and the user's refire.
<li>- Charge charge time reduced by 0.1 seconds.
<li>- Makosen's pathfinding changed. (No longer zig zags and should hit itself less often.)
<li>- Hellzone Grenade should now trigger.
<li>- Burning Shot now grants an aura that gives you +30% BP for 20 seconds. Cooldown increased as a result.  Combo also fixed.
<li>- You can no longer customize/refund a stance while using it.
<li>- Fixed various issues with scouters/communicators/telepathy and the AL.
<li>- Fallen Kaio disabled.
<li>- Custom Language cost reduced to 1 milestone point from 2.
<li>- Armor description fixed to reflect the real stats of -15% Speed and +10% Endurance.
<li>- Expand Offense changed to 0.93x from 0.925x per level.  Makyo/Endless Expand now gives 1.15x Endurance per level instead of 1.125x
<li>- Conjure requirement reduced to 78 Magic and >4 Mod.
<li>- Added Philosopher's Stone which can be created and used at 45+ Magic with atleast a 2.5 mod.  It multiplies your regen ticks by your magic mod and if you have a 3.5 or higher mod it makes your HP affect your BP less.
<li>- Added a Magic Mask which mages can create at 30 magic  and 2+ magic mod. Adds a flat amount of BP to your ki attacks up to 33%. Reduces Offense by 25%.
<li>- Mages now learn Adaptive at 38+ and 2+ Mod.  Consider it a Mage Armor until it is reworked.
<li>- Various fixes.


<p>
<br>
<b>Roleplay Tenkaichi verion 1.073 (Quality of Life for Chewyy) - 10/14/2019
<li>- Improved Live Patch system and made it much more efficient / faster (or buggier and game breaking, we'll see)
<li>- Added an Admin troubleshooting tool to jump into a players mob (Owner level only, still in beta, could erase a save)
<li>- Adjusted fusion to keep race if both fusers are the same race (May solve some transformation issues, may not)
<li>- Fixed Fusion Observe and made it default to watching the one in control
<li>- Adjusted Fusion animation to display the full dance
<li>- Made an AI system that sets Chewyy's default settings when making a new character
<li>- Fixed issue with Redo Stats that required an Age be set
<li>- Misc. fixes that I forgot
<li>- Fixed Admin body snatch
<li>- Buffed Oni INT/Magic mods, this is retroactive
<li>- New and improved language system (Thanks for the help, Gin!)
<p>
<br>
<b>Roleplay Tenkaichi verion 1.07 (Boosting the Boosters)
<li>-Fixed an issue with MP during the creation process
<li>-Fixed an issue with spawns during the creation process
<li>-Added the ability for admins to mark players as Nitro Boosters
<li>-Added a Font Selector under "Customization" for Nitro Boosters
<li>-Added ~40 fonts to choose from
<li>-Added a Nitro Booster OOC tag for Nitro Boosters
<li>-Added a Priority Admin Help for those who are Nitro Boosters (Simply use regular Admin Help and the system will do the rest)
<li>-Fixed a description issue with Concentrated Fire
<li>- Changed Booster logo from text to cool images
<li>- Made it so you have to choose an Age during character creation
<li>- Age is displayed in confirmation box before creating
<li>- Starting gravity issue resolved for new creations
<li>- Added messages to SGKA and Wall of Flame to inform user of a lack of energy or target
<p>
<br>
<b>Roleplay Tenkaichi verion 1.06 (Wipe Hype)
<li>-Yardrat Trans gives less Speed and more BP.
<li>-Half Saiyans now get Saiyan FBM mult. (1.5x)
<li>-Bojack for Herans and Half Herans can now be unlocked through sparring a SSj/Bojack, similar to how you can unlock SSj.
<li>-Half-Makyo, Half-Herans, Half-Tuffles and Half-Humans should now all get some kind of transformation.
<li>-Kanassa and Oni are now Asexual and Demigods are now sterile.
<li>-Fixes.
<li>-Frieza Forms updated so that more power is on the front end. Should be net-neutral by form 4.
<li>-Mana Pylons / Drill Towers now locked behind a mod of 3 Magic / Intelligence.
<li>-A few descriptions were updated on consumables from tech / magic. Please review before creating or using them.
<li>-Removed Chakra Blocking from the Milestone list until it can be reworked.
<li>-SSJ4 BPM multi buffed slightly. SSJ4 no longer reduces recovery.
<li>-Base Resource and Mana gains reduced
<li>-Randomization component added to Resource and Mana gains.
<li>-Mysticism now reduces BP by 5% rather than 7.5%.
<li>-Adjusted Kold BPM from 2.7 to 2.6 and endurance from 2.4 to 2.2
<li>-Tuffle cyberize cost reduced to be more inline with their default (pre-milestone) INT.
<li>-Temporarily disabled Racial BP add for Herans.
<p>
<br>
<b>Roleplay Tenkaichi version 1.05 (SsethTzeentach please review this game) - 7/19/2019</b><br>
<li>-Androids now have an auto learn for Overdrive.
<li>-Self train now grants unarmed/weapon skill based on if you are using a weapon.
<li>-Mediation now grants ki manipulation.
<li>-Mating bugs fixed.
<li>-Fixed an issue.
<li>-Fixed another issue.
<li>-Fixed that issue.
<li>-Fixed the other issue.
<li>-Didn't fix that issue yet.
<li>-Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.04 (Back at it again again again again again but maybe for real this time) - 7/08/2019</b><br>
<li>-Revive takes 10% of decline instead of 25%.
<li>-Shield changed to 5% Endurance, 10% with shield master.
<li>-Armor changed to 10% Endurance, -15% Speed, from 15% Endurance, -20% Speed.
<li>-Fixed an issue where custom stances would cause crashes under certain circumstances.
<li>-Fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 1.03 (Back at it again again again) - 7/01/2019</b><br>
<li>-Fixes
<li>-Gravity upgrade cost scaling changed.
<li>-Drills are now limited to 5 x Mod.  Instead of 5 x planet. (This means you can make 20 drills total on a 4 mod)
<li>-Cyberize and Upgrade Android base cost increased.
<li>-Space/Star tiles will now only kill you if you are on z 12, aka space.
<li>-Various repairs.
<p>
<br>
<b>Roleplay Tenkaichi version 1.02 (Back at it again again) - 6/23/2019</b><br>
<li>-Fixes
<li>-Expand gives 2.5% less Endurance per level.
<li>-Blast gains are now a decent active way to train Force.
<li>-Basic Blast accuracy improved slightly.
<li>-Basic Charge accuracy reduced slighty.
<li>-Lethal Combat Tracker is now on a scale up to 2 hours depending on your Willpower instead of always being 2 hours.
<li>-Translators, Stones of Understanding and Bookcases are now much more expensive.
<li>-New tech item called Advanced Door Pass which will store 3 passwords but is very expensive.
<li>-Bookcases now work in your inventory.
<li>-Don't stack punching bags.
<li>-Magic/Regular Scanners tuned down.
<li>-Various Magic Fixes.
<li>-Shield's chance to reflect blasts reduced slightly.
<li>-Cabinet issues fixed.
<li>-Gravity damage increased/fixed.

<p>
<br>
<b>Roleplay Tenkaichi version 1.01 (Back at it again) - 6/16/2019</b><br>
<li>-Bug fixes.
<li>-Alien energy boosted by 1.25x.  Their new base is 1.5 instead of 1.2.  This is retroactive for all existing aliens.
<li>-Reworked Boundless Stamina.  If you purchased it, it was refunded.
<li>-Updated communicators to now use the currently selected IC language.
<li>-Added a new item called translator to tech tree which will translate any outgoing speech into something recognizable by the hearers.
<li>-Added a new item called stone of understanding to magic tree which will translate any incoming speech into something you can understand.
<li>-Added a new 2 cost milestone called NRA Membership that boosts gun damage by 30%.
<li>-Swimming will no longer bypass the energy cap.
<li>-Base chance for ki blasts to hit improved by 3%.
<li>-Energy Marksmanship improved to now grant +7% accuracy with ki.
<li>-Time Freeze should finally be viable.
<li>-Bullets can be deflected again.
<li>-Added a Chakra Blocking milestone which freezes the opponent's recovery.  It is a temp buff that lasts 15 seconds and each time you hit it freezes their recovery for 2 ticks. Long CD.
<li>-Added The Seed Is Strong milestone which costs 2 and allows 2 more offspring and changes the CD on Mate to be 1 year instead of 1.5.
<li>-Added Wing Clip as a 4 cost MP. Wing Clip: Launch a cheap attack against an opponent's joints in order to reduce their speed for 10 seconds if it lands.
<li>-Added Pursuit Of Knowledge, 6 cost MP that will cause you to gain both Int and Magic exp when focused on one or the other.
<li>-Added Rapid Deployment, 3 cost MP that will cause your Lethal Combat Tracker to tick down at 2x the regular rate.

<p>
<br>
<b>Roleplay Tenkaichi version 1.0a (Tools of the Trade) - 6/09/2019</b><br>
<li>-Bug fixes.
<li>-Racial Power Add now calculated by being added to base before BP formulas.
<li>-You can now upgrade gauntlets with resources.
<li>-Various other fixes.
<li>-Custom language learning difficulty increased to 10x.
<li>-Hit overlays should no longer bug.
<li>-Magic Goos now have multiple tiers like Punching Bags. Both are now clearly labelled.
<li>-Drills and Pylons are now limited to 1:1 for your Int/Magic mod for each planet. Meaning if you have a 3 int mod, you can have 3 drills per planet.
<li>-Magic Scouters no longer show base BP but now show max energy.
<li>-Bullets can no longer be deflected.
<li>-Armor cost increased.
<li>-You may no longer meditate on nothing.
<li>-New Milestone.
<li>-Ki Fists now works with gauntlets.
<li>-Melee damage range changed to 1x-3x.
<li>-Base Regeneration tick lowered from 0.15x to 0.1x
<li>-Status Bar text enabled in bottom left because there was no compelling reason to leave it off.
<li>-Fixes.
<li>-Focus, MF/MaF reqs for teaching lowered.
<li>-Drill and Pylons can now be upgraded to 10x your mod instead of 5x due to the new limits.
<li>-Lightning Bolts CD reduced.
<li>-Fixed an issue allowing excessive BP over cap.  BP was reduced to prevent future issues on those affected.
<li>-Kiai now has a 3x chance to hit.
<li>-Dig/Mana rates reduced.
<li>-Roundhouse Kick damage reduced.
<li>-Percentages no longer displayed in stats.
<li>-Fixed an issue causing people to overcap their BP higher than intended.
<p>
<br>

<b>Roleplay Tenkaichi version 1.0 (We Made It) - 6/06/2019</b><br>
<li>-Androids buffed.
<li>-Blasts are no longer slowed based on HP.
<li>-All beams now support immediate firing.
<li>-After dying three times (While being alive) you are now forced to reincarnate or live in the final realms. (This means you get to start alive, then die, then revive, then die, then revive and on the next death you are forced to reincarnate)
<li>-More Fusion bug fixes.
<li>-Basic alignment tracker added.
<li>-Target warp delay increased.
<li>-Admins now have a Refund command to refund objects.
<li>-Fixed bug that caused all teach CDs to display as 0.
<li>-Fixed a bug that would not properly apply Arcane Brokerage.
<li>-Fixed a bug with Halfies going SSG.
<li>-Tech can now replace limbs for a fee.
<li>-Tech can now replace a limb with a cybernetic one for a higher fee. Cybernetic limbs will offer a small stat boost which is still being decided upon. Cybernetic limbs will not be reduced below broken.
<li>-You can now leave planet from the alien planets.
<li>-Auto Attack will now add an overlay similar Lethal.
<li>-Demons, Makyos, Changelings, Bios and Majins now start with Chaotic alignment.
<li>-Kaios start with Pure alignment.
<li>-Dark Blessing/Unlock Potential now decrease/increase a person's alignment.
<li>-Killing or Injuring someone that is not Evil reduces your alignment.
<li>-Hermits now have a verb to appoint someone a student and then to check if someone is already enrolled in a school.  This is to discourage people from "teacher hopping" and is not currently limited via mechanics.
<li>-The Judge can now sentence someone to heaven/hell/checkpoint.  Doing so will cause them to only regain WP within the given realm.  AL ranks are able to sense someone's alignment as well as where they were judged.
<li>-Ki Damage formula reworked to use 1x as the baseline server setting for ki power instead of 0.15x.
<li>-Glass doors now work as objects and overlay what they are built upon.
<li>-Custom Aliens no longer gain milestones at an accelerated rate and instead spawn with 4 MPs. (They must purchase their custom MPs before save age 4)
<li>-Humans now gain milestones at 135% the regular rate instead of 125%.
<li>-Has SSj4 is now a seperate variable.
<li>-New ability called Hellzone Grenade added to the NE skill set.
<li>-New transformation called Super Maximum Light Speed Mode (based off Dyspo's) for Yardrats which replaces their hybrid alien trans.
<li>-Stat point investment now has diminishing returns. (1 = 10%, 2 = 19%, 3 = 27%, 4 = 34%, 5 = 40%, 6 = 45%)
<li>-Minimum Decline Age changed to 45. Milestone added called Borrowed Time which gives +10 Decline for 4 points.
<li>-Map reduced to 17 total Zs, down from 20.
<li>-God Ki gains increased.
<li>-Androids no longer receive a recovery nerf from upgrade android.
<li>-Various tech/magic is now locked behind certain mods as well as the int/magic level itself. (I.E. 3+ Int Mod needed to make a ship, etc)
<li>-Tuffles now get +1 Int Mod at FBM.
<li>-Makyos now get +1 Magic Mod at FBM.
<li>-Races lacking a God Ki tier buff now get a second BPMod increase knowns as Ascension when they reach 1 God Ki.
<li>-Guns reworked.
<li>-Walls/Turf HP reworked.
<li>-Lots of stuff reworked.
<li>-Framework for the team system added.  At the moment serves as just a tracker but may be used to reduce friendly fire damage, for skill targetting and etc,
<li>-I didn't write a lot of stuff down.
<li>-I do that a lot and it makes some people upset.
<li>-But there were a lot of things that weren't listed too.
<li>-New racial mods.
<li>-New body size mods.
<li>-Changes to character creation.
<li>-Being on someone's team will reduce friendly fire damage by 50%.
<li>-Skill Sheet is now in the Options drop down menu.
<li>-Fusions can no longer Fuse.
<li>-Ki damage rebalanced.
<li>-New skills.
<li>-New milestones.
<li>-New tech/magic.
<li>-Lots of balance changes.
<li>-Decline Body loss slowed.
<li>-Lots of Milestones changed.
<li>-Custom God Ki Aura is now under the Customize verb.
<li>-Armor now has a stat admins can edit to create special items. KineticBarrier adds a % boost to BP on defensive calculations = to its value.
<li>-Combat Log less spammy and less redundant.
<li>-Cybernetic Limbs grant some stats. Replacement Limbs simply heal the injuries. (Cyber Limb becomes immune to damage. Cybernetic Eyes grant 2.5% Offense/Defense at the cost of 10% Regen. Cybernetic Legs give 2.5% speed at the cost of 5% Regen. Cybernetic Arms give 2.5% Strength and Force at the cost of 7.5% Regen. These are additive to a total of -35% Regen.)
<li>-New base icons.
<li>-New attacks for melee added.
<li>-Friendship Bracelets are now level 1 tech items.
<li>-I honestly haven't been making notes for a lot of stuff.  Go re-explore the game.
<li>-Drills should now link resources like mana pylons.
<li>-Seriously, didn't list a lot of the changes.


<p>
<br>
<b>Roleplay Tenkaichi version 0.99b (????) - 5/19/2019</b><br>
<li>-Speed buffs.  (Refire now allows more speed mult/mod influence before the cap.)
<li>-Speed now contributes 17% towards Off/Def instead of 15%. (Increased to 20% when you have Precog)
<li>-Anger is back to the old system.
<li>-Fixes and stuff.
<li>-SSB now has reduced drain if you have 2+ God Ki.
<li>-Expand adjusted slightly.
<li>-Kaioken reworked again.  Grants BP and lowers endurance on a sliding scale up to 20x.  No longer grants speed but will zanzoken warp to your opponent even if combo is off.
<li>-Tech/Magic reqs adjusted in preparation for next wipe.  They now have next wipes reqs and costs.
<li>-Magic Force, Focus and Muscle Force are now using next wipe's numbers.
<li>-Minimum mult for Golden Form Changeling increased to 1.25x from 1.1x. The maximum is still 2x at 3 God Ki but now scales quicker.
<li>-You may now start at up to 1.5x your decline age.
<li>-Ki Blade is now 30% Str + 80% Force versus Endurance.  Ki Blade now automatically counts as a weapon with +33% BP. You can equip weapons with Ki Blade for their stat bonuses but they will not add their BP.
<li>-Energy Infusion is now a skill usable on others instead of an item.
<li>-Demonic Fury and Angelic Grace changed.
<li>-Soul Contracts no longer have any additional mechanics and are used for IC/RP purposes.
<li>-Several rank buffs optimized to use the modern buff logic.
<li>-Repair Kits added.
<li>-Beams now have an immediate firing mode.
<li>-Buildings are now considered to have the current True BP Cap for purposes of calculating damage. (Massive buff to building strength)
<p>
<br>



<b>Roleplay Tenkaichi version 0.99a (Pahk The Cah) - 5/18/2019</b><br>
<li>-Antihacking Circuitry added which will increase the effective level of Doors by +5 for hacking purposes.
<li>-Stud Finder added which will tell you the Health remaining on a door or wall.
<li>-Mutation Injection added which will add a mutation to someone that doesn't have any.
<li>-Energy Infusion added. Works like a weaker version of Give Power that gives you +25% of your max ki in one quick burst.
<li>-Weapons now have Durability. The cost to repair scales with the weapon's power.
<li>-Custom Language fixes.
<li>-Speed stat will no longer affect Refire, which affects CDs.  Speed Mod and Speed mult will still affect it.
<li>-All melee based attacks now have a 50% chance to hit on a 1:1 ratio of stats except roundhouse and sword stab which both have a 40%.
<li>-Overhead Smash added for hammers.
<li>-Colossal Impact added for hammers.
<li>-Capsule Tech added as an upgrade for Regenerators, Ships and Pods.  This will allow you to put them into your inventory.
<li>-Blast is now restricted to a maximum of 2 spread. It now has slightly higher damage if the spread is set to 1.
<li>-Barrage changed to no longer spin you but fire a volley of 5 blasts at a slightly higher damage that regular blast and a slightly longer cooldown.
<li>-Hammers now count for using Bushido.
<li>-Hammers now only grant 1.1x Str instead of 1.2x.
<li>-Leave Planet bug fixed.
<li>-Mayko Star now allows Makyos to use their transformation once no matter their requirements.  It will increase a Makyos BP by 5% once per pass up to 10% max. If a Makyo has hit the requirements for their transformation the uses are no longer limited.  The Mayko star no longer grants bonuses to other races.
<li>-Scanners/Magic Scanners now scale off someones Int/Magic mod instead of a fixed value.
<li>-Book of Ages added which gives +1 Milestone point but instantly ages you 5 years but only grants the benefits once.
<li>-Book of Fortitude added which gives 1.2x Endurance for 1 year but only grants the benefits once.
<li>-Book of Lessons added which gives 3x BP/Stat gains for 6 months but only granst the benefits once.
<li>-Book of Power added which gives 2.5% BPMod and 1.1x Base BP but takes the slot of Dark Blessing or Unlock Potential and only grants benefits once.
<li>-Blue Comet Special now summons copies at click location and then runs towards your target.  They deal speed based damage.
<li>-All races now share the same max God Ki of 3.  SSGSS is now SSj Mult x SSj2 Mult BP boost. SSG is no longer a BP boost but just a visual transformation when a Saiyan uses God Ki.
<li>-New Milestone added. Key Ring: makes door passes not take up inventory slots.
<li>-Half Saiyans no longer get SSG but are now allowed to use SSj1-2 in God Ki.  You can call it whatever you want.
<li>-Changed the way Anger Mult works. (math change)
<li>-Beams are much faster now.
<li>-Rock Throw Expert reworked.
<li>-Stuff I forgot to write down.
<p>
<br>


<b>Roleplay Tenkaichi version 0.99 (Resistance is Futile) - 5/16/2019</b><br>
<li>-Removed resistance
<li>-Save Age now outputs when you click the year in Status tab.
<li>-Changes to Ahelp resolution.
<li>-Fusion fixes.
<li>-Mating now disabled until year 7.
<li>-Armor Mastery now costs 5 MP and increases endurance by an extra 10% while wearing armor.
<li>-Shield now increases endurance instead of resistance.
<li>-Shield Master now increases endurance by 10% extra.
<li>-Unlisted stuff, that is now listed so; listed stuff.
<li>-Fusion Dance added.
<li>-You can now upgrade safes/vaults to defend against hacking.
<li>-Training Dummies are now the fastest way to gain Unarmed/Weapon skill.
<li>-Drone Scaling changed. Drones now follow mouse clicks like splitforms.
<li>-There is now a magic version of drones that are Spirit Dolls without a soul.
<li>-Added auto attack.
<li>-Knockback no longer destroys objects.
<li>-Custom Language milestone added.
<li>-Stat focus for force/resistance removed.
<li>-You may now teach something once every 6 months and store a maximum of 2 teaches.  There is now a MP available to increase the cap and rate. This does not apply to rank buffs.
<li>-Drill Towers/Pylons are now limited to your Int/Magic level.  If you have level 10, you can make 10 drills, level 100 100 drills, etc.
<li>-Bind now restricts regeneration/recovery outside of Hell.
<li>-Made some stuff prettier.
<li>-Gundam nerfed to 1.3x BP until next wipe.
<li>-Alien skills are now only purchasble for 1 MP during the first 5 years of an aliens Save.
<li>-Logs/Bags now take reduced damage.

<p>
<br>
<b>Roleplay Tenkaichi version 0.98c (Fixes and Stuff) - 5/08/2019</b><br>
<li>-Rank Attack Skills no longer teachable to other Ranks.
<li>-TK Pull CD increased.
<li>-Baseline attack damage reduced from 2-5 to 2-4.
<li>-Fixed an issue with lethal time displaying incorrectly.
<li>-Blaster Meteor and Mortar buffed slightly.
<li>-Homing Finisher buffed slightly.
<li>-Bulge renamed to Bulk.
<li>-Pretty Attack now has a 6 second cooldown and a 20% chance to occur if both parties have the zanzoken skill.
<li>-Min/Max Gain multiplier now set according to Wipe Day. Disabled until next wipe.
<li>-Body Sizes now affect fleeing.  Small + 1, Medium 0, Large -1
<li>-TK Pull Master disabled.  Those that purchased it previously will retain it.
<li>-Resized the body HUD.
<li>-Splitforms now stack vertically on the screen above the body HUD.
<li>-Splitforms can now be controlled with mouse clicks. (Toggle under SF options)
<li>-Hit overlays downsized and then upsized again. (Looks better imo)
<p>
<br>


<b>Roleplay Tenkaichi version 0.98b (Thunderstruck) - 5/08/2019</b><br>
<li>-Global Ascension no longer automatically grants SSj to those that have met the req.
<li>-Kaios now learn Angelic Grace at Global Ascension.
<li>-Demons now learn Demonic Fury at Global Ascension.
<li>-Better handling for graphics settings.
<li>-Projectiles fixed. Homing disabled.
<li>-Expand/Bulge revert issue fixed.
<li>-KB icon_state no longer used for Digging.  Digging now uses Meditate.
<li>-Fixed issues with Ships and Portals.
<li>-Throw icon issues resolved.
<li>-Basic Blast, Sping Blast/Barrage, and Makosen are now heat seeking. (They will move towards your target by 8 pixels per tile.)
<li>-Added an on screen COMBAT tracker for further indication of when you are still recovering from combat. (Lasts about 2 hours now. Down from 2.5)
<li>-Status tab now shows the duration remaining on Lethal Combat.
<li>-Fixed an issue with WP drain resulting from max health.
<li>-Way of the Open Palm now works with Ki Fists.
<li>-Kaioken now uses BPMult instead of KaiokenBP.  It now grants 2x BP at 20x as intended.
<li>-Rejuvenate (Heal Spell) now removes Lethal Combat Tracker but no longer grants WP. (Gives +1 WP for helplessness purposes)
<li>-Elixir Of Replenishment added to magic at level 60.  Speeds up the Lethal Combat Tracker and WP regen, but you build a resistance over time.
<li>-LSD readded to the tech tree at tech level 12.
<li>-Show Time Stamps removed from menu.  Still available as Toggle-Timestamps.
<li>-Lots of Graphics Options moved to the top left menu > Graphics > Graphics Options
<li>-Rename is now accessible by right clicking on the target instead of via Options. Also now called Change Name.
<li>-Wind element buffed. Now has a 50% chance to grant 2 charges.
<li>-Burning Shot "sped up." Likely broken, blame Chewyy.
<li>-Thundering Blows no longer staggers.  If the slow misses it now has a 40% chance to summon a lightning bolt.
<li>-BP cap softened.
<li>-You may not use UP/DB on another rank anymore.  DB/UP cooldown increased to 5 years from 3 years. Both now grant the same bonus (1.05x BPM and 1.25x Base).
<li>-Enablement Slots now reset 20 years after being taught.
<li>-Ring Out Sensor added to build menu.
<li>-New Icons.
<li>-Attacks may be pretty now when you have mastered zanzoken.  They may also bug horrendously.
<p>
<br>


<b>Roleplay Tenkaichi version 0.98 (It's over SSj4, I have the high ground) - 5/07/2019</b><br>
<li>-SSj4 adjustments
<li>-Fixed issue with edge/item map save.
<li>-Max Health and Max Willpower stats added.
<li>-Increased rate of gaining Unarmed/Sword
<li>-Fixed issue with DB/UP on Offspring.
<li>-Fixed SSj2 aura.
<li>-Fixed FBM display.
<li>-Fixed Friendship bracelets.
<li>-Expand rework. (No longer takes a buff slot)
<li>-Body HUD and Status overlays now default to on.
<li>-Milestone catch up indicates how many you have remaining.
<li>-Issues with legendary enchantments fixed.
<li>-Fixed issues with horseman and spirit dolls buffs not resetting properly on reset stat mults.
<li>-Space now tells you as it kills you.
<li>-Super Ghost Kamikaze Attack now hits your target instead of using a pop up window.
<li>-Hacking Consoles will now drain Safes and Mana Vaults if successfully used on one.
<li>-Sturdy Build now only grants +10 Body Part HP, but those that bought it before this will keep the +15.
<li>-Will of Fire now costs 8 MPs.
<li>-Ice element slow increased to 75%.
<li>-Thundering Blows slow increased to 50%. Thundering Blows now has a chance to stagger movement on hit.
<li>-Changes to Thundering Blows proc rates.  40% chance for slow, if slow misses, 20% chance for stagger.
<li>-Kiai now staggers movement on hit. (2 "charges" of Stagger)
<li>-Blast Meteor and Mortar now produce shrapnel.
<li>-Force Field now has a 5% chance to deflect projectiles. It will always reduce the damage of projectiles to 0.3x when it has battery and is active.
<li>-Shield now has a 25% chance to reflect projectiles. If it is not deflected it will reduce the damage to 0.7x.
<li>-Default "max steps" (distance a blast will travel before poofing) reduced to 30 tiles from 60 tiles.
<li>-Visual improvements to the body HUD.
<li>-Default starter boost increased to 75% of the cap, up from 60%. If the starter boost for BP would send you into FBM, FBM is instead applied first.
<li>-Spirit Dolls now start with Common mastered instead of English.
<li>-Teaching Archdemon skills fixed.
<li>-Cardinals no longer granted Observe as part of thier kit.  Grandfather rule applies.
<li>-Says/Emotes will now show (Observe) if they are showing up due to Observe to reduce confusion.
<li>-Gravity Machine descriptions fixed.
<li>-Training a Martial Art now costs 2 MP instead of 3.
<li>-All Martial Art related MPs now have a confirmation window instead of auto purchasing.
<li>-Added Arcane Brokerage MP which functions like Deep Pockets except for mana.
<li>-Screen effect overlays adjusted.
<li>-Issue with LOOC disbale spam fixed.
<li>-Explosions and Lightning Strikes removed from Planet Destruction.
<li>-Emote window improved. No longer lose RPs to DCs as long as you dont close the RT window.  Will automatically remember your last RP with the option to clear.
<li>-Fix trans/learn lists moved to Give verb.
<li>-Invis label now shows up for Cloak Controls.
<li>-New Redo Stats/Character Creation menu.
<p>
<br>


<b>Roleplay Tenkaichi version 0.97 (I am contractually obligated to fix this) - 5/06/2019</b><br>
<li>-More fixes for second gens.
<li>-Contract tab for Conjure called "Demon Contracts" tab and not Soul Contracts.
<li>-Issues with ITing to the AL resolved.
<li>-Fixed issues with various stat focus displays not updating.
<li>-Fixed Milestone points not updating.
<li>-Basic skills now have a teach verb.
<li>-Gravity field limit is now based on the level it is upgraded to.  The maximum is your Int level x 6. The cost to upgrade is now reduced.
<li>-You may now set the number you wish to upgrade a Gravity's battery or field limit to.

<p>
<br>

<b>Roleplay Tenkaichi version 0.96c (We Removed The Lead Paint) - 5/05/2019</b><br>
<li>-PBags and Training Dummies are now allergic to EZing and will randomly walk away from you if you beat them up too much.
<li>-Severe mutation bug fixed.  All mutations reset and reassigned.  We apologzie for any losses in strength but the nature of the bug make it impossible to verify which mutations you had originally.
<li>-Flee/Chase calculations improved to include more skills and milestones.
<li>-Solar Flare now has a CD.
<li>-Cameras now require secutiy monitors to view.
<li>-You may only use Stun Chips on people with 0 Willpower.
<li>-Meditating or entering a Regenerator will stop Sending Energy.
<li>-Removing someone's head is now automatically lethal.
<li>-You can now make friendship bracelets for someone to increase contact points gains.  Has a 1 month CD.
<p>
<br>

<b>Roleplay Tenkaichi version 0.96b (Fixies) - 5/05/2019</b><br>

<li>-You can now see the icons of your contacts in Sense/Scan.  This will likely change.
<li>-Armor HP per tech level reduced by 50%.
<li>-Blaster Meteor now targets your target instead of asking in a pop up.
<li>-Catch Up Milestones will now apply to Offspring but they will only earn up to 25% of the total.
<li>-Majin and Mystic no longer "evolve" at FBM.
<li>-Warp Attack CD increased.
<li>-Megaburst CD fixed.
<li>-Each character is now only capable of being taught one "Super" buff.  This list includes the rank taught buffs.
<li>-Examine fixed.
<li>-Shadow Spar removed.
<li>-Beam zanzoken is no longer tied to Warp Master but now tied to IT.
<li>-Transformation reqs are now calculated using "true" Base BP.  (Base BP / BP Mod)
<li>-Super Ghost Kamikaze Attack CD increased by 50%.
<li>-Beam drain for charging and firing now increases slightly faster.
<li>-Added hidden Oni buff (Hidden Requirements)
<p>
<br>
<b>Roleplay Tenkaichi version 0.96 (New Character Who Dis) - 5/04/2019</b><br>
<li>-Bug fixes.
<li>-SNj fixed.
<li>-Megaburst CD fixed.
<li>-Magic Force, Muscle Force and Focus now start at 100% Exp.  All existing versions will no longer gain Exp due to them no longer draining.
<li>-You will now automatically warp to your Target when pressing the attack verb if they are within 12 tiles and you have zanzoken and 1000 unarmed/weapon mastery.  This is on a 15 second CD.
<li>-Warp Attack Master now does 100% damage of regular attacks.
<li>-Limit Breaker limb damage increased.
<li>-Sense/Scouters now only show a persons energy signature unless they are in your contacts.
<li>-Starter Boost automatically assigned based on energy/BP caps.  It is currently 60% of each. No longer grants Milestones.
<li>-New Catch Up Milestone mechanic that takes the place of starter boost milestones and causes you to gain 1 MP every month until you catch up to 50% of the wipe total.  This does not apply to Offspring.
<p>
<br>
<b>Roleplay Tenkaichi version 0.95b (Cuz the last one was too short: Lag and other short stories) - 5/01/2019</b><br>
<li>-Buffed Rock Tomb/Blast's damage mult from 20x to 35x to reflect its CD and MP cost.
<li>-Combat Math CD increased.
<li>-Mystic now grants 1.3x Force.
<li>-Majin back to 1.5x Anger at full power.
<li>-Server side FPS increased from 20 to 30.
<li>-CD tick method improved to significantly reduce server impact.
<li>-Now there are 3 macro options.  WASD, Arrows keys or both.
<li>-Physics Simulation drain reduced from Tier 3 to Tier 2. (1% to 0.75%)
<li>-Redo Stats fixed.
<li>-Ki Manipulation description fixed.
<li>-SSj4 Bug fixes.
<li>-Changes to stat name assignment to reduce CPU usage.
<li>-Architect MP cost reduced to 2 points from 4.
<li>-Building is now locked behind a Milestone instead of Save Age.  It costs 0 for this wipe.
<li>-Lethal Combat Tracker extended further.  Now lasts about 2.5 hours.
<li>-Admin Heal Injuries and Admin Revive are now under the Give Menu.
<li>-Legendary enchants added. There can only be 5 of these per wipe.  Each one costs 50x the amount to enchat an item 1%. Currently there are only Fire, Ice and Wind for weapons.  They currently apply burn, slow and have a 25% chance to grant 1 "homing attack" respectively and stack with the appropriate milestones. Fire and Ice have a 100% proc rate and Wind has a 25% chance to make you auto face your Target on the next attack. You can store up to 2 charges of this homing attack.
<li>-Sense window no longer displays icons.
<li>-You can now toggle off res/mana gains showing in combat tab under the options menu now.
<li>-You can now toggle off ki drains showing in combat tab under the options menu now.
<li>-Being sent to the Final Realms will now offer an immediate option to reincarnate and if you do not it will automatically alert the admins.
<li>-Sense now updates every 1.5s instead of 2.5s
<p>
<br>

<b>Roleplay Tenkaichi version 0.95 (Swollen Hordes No Longer Explode) - 5/01/2019</b><br>

<li>-Allow Rares is now a one time use.
<li>-Detonate Augmentation removed from Augment Master. Aka, no more forcibly self-destructing people.
<li>-Fixed Bump issues with movement. Space movement fixed.
<li>-Ki Manipulation added to Skill Sheet.
<li>-New option under Options menu for change macro set.  This will swap between WASD and arrow keys.  If you want support for both, just edit the skin file and combine the macro lists like the rest of us.
<li>-Horseman Buffs nerfed slightly.
<li>-Added an output to novice stances so people understand there is a downside if you are using a stance you are not atleast intermediate in.
<li>-Swell improved. 1.5x BP 1.4x Str/End 1.2x Spd
<li>-Majin/Mystic changed.
<p>
<br>
<b>Roleplay Tenkaichi version 0.94 (The Cha Cha Slide) - 4/30/2019</b><br>
<li>-Admins now have a Fix Trans and Learn verb to fix incorrectly assigned learn reqs.
<li>-Potions of Respec: This will allow you to reduce a stat by 50%. (Reduces a stat to a minimum of 25% of the stat cap.)
<li>-Humans and Kaios no longer have increased maximum Focus exp.
<li>-Mutations on second + gens will now affect their genetic mod, so future generations continue to "develop" based on their genetics.
<li>-Buffs and Transformations with drains now use a normalized method of draining.  All tick rates for drains slowed from 2s to 3s.
<li>-Demons now always create Demigods, just like Kaios.  Mating debug process updated. Please continue to send Ryu your screenshots.
<li>-Focus, Magic Force and Muscle Force no longer drain.
<li>-Drain calculations changed.
<li>-Fix attempt for Milestone bug.
<li>-You can now upgrade power armor into being a Gundam suit at 150 int.  Increases HP to 5x regular power armor and increases BP to 1.4x from 1.2x.
<li>-Fixes for various skill based Milestones where if you got the skill after the Milestone it would not apply.
<li>-Custom Stance Milestone cost increased to 12 from 10.
<li>-Agile Nature now costs 7 instead of 8 Milestones.
<li>-PC Expert now increases Recovery by 0.75 instead of 0.5.
<li>-Additional Mating fixes.
<li>-Better movement. Now auto uses diagonals with multiple cardinal directions pressed. Now slides off walls.  Known issues with edges. (if you have WASD already macrod, delete it)
<li>-Air Masks now have a unique equip message.
<li>-Rares adjusted. (Except Changeling rares)
<li>-Oozaru pixel_x adjusted for side states.
<p>
<br>
<b>Roleplay Tenkaichi version 0.93 (1.21 Gigawatts of Energy) - 4/29/2019</b><br>
<li>-Limit Breaker damage reduced.
<li>-Flee is changing soon.  New prototype version added for testing and practice.
<li>-Skills are no longer leechable.  Learn rates increased by 2x as a result. (This does not affect the CD on major skills)
<li>-Elixirs of Respec are now on a 3 year CD.
<li>-Fixed Enter Ship bug with pods.
<li>-Humans and Custom Aliens now gain milestone points at 1.25 the regular rate.
<li>-Show Milestones verb added.
<li>-2 new Shield icons added.  Random icon assigned on learn.
<li>-Flat KB resist increased.  (Does not affect Sturdy Build)
<li>-The end of the stat/BP cap is now x0 instead of x0.001.
<li>-Removed one tier of gain reduction from BP gains. You will now cap BP a bit faster.
<li>-Sparring BP gain rate increased to 5x from 3x.
<li>-Admins can now edit a character to have IgnoreRealmTeleport which will allow them to bypass the "veil"
<li>-Various debugging checks for mating in place now.  If you attempt to mate and it doesn't work, please send Ryu a screenshot of the debug checks for both parties.  This will help us fix it sooner.
<li>-Limit Breaker drain changed to use the event timer for less overhead.
<li>-Setttings verb for skills renamed to Ki Settings.
<li>-Several verbs moved to drop downs in the top left.
<li>-Old style Report verb disabled.
<li>-Discord link verb added.
<li>-The 'Force' buffs are no longer mutually exclusive and may be stacked. (This includes Bushido aka Sword Force)
<p>
<br>
<b>Roleplay Tenkaichi version 0.92 (More Fixes) - 4/23/2019</b><br>
<li>-Bleeding Edge revert bug fixed.
<li>-SSj Mods fixed.
<li>-Swords now get full 66% with Ki Blade if you have swordsman.
<li>-Lethal combat tracker duration increased to one hour.
<li>-Kaio Revive now warns you if you will enter decline from the potential reduction.
<li>-Body Parts damage formula normalized.
<li>-SSj4 now grants 20% Strength and reduces Recovery to 80% instead of 70%.
<li>-Moderators can now set someones willpower using alter stats.
<li>-Fixed bind.
<li>-Adamantine Skeleton now always has a 50% chance to kill the target, 25% chance if they are in a regen tank.
<li>-Zanzoken mastery is now at 20% additional damage to combo attacks.
<li>-Horseman passives rearranged.  Famine now only ignores energy levels for BP.  War now ignores limb damage.  Death no longer ignores limb damage but now ignores health levels towards BP.
<li>-Medicine Cabinets now increase natural healing ticks by 2x if you are within 2 tiles of one.
<li>-New Ki Manipulation skill, similar to Unarmed and Weapon skill.  Will be used to unlock new ki based techniques.  Increased by using Ki Moves.  All basic moves grant it at a low % chance.
<li>-Adaptive buffed to 1.25x End, Res, Def and Regen.  CD increased to 6 minutes.  Added to the master learn list.
<li>-Warp Attack CD increased from 15% of refire to 50% of refire.
<li>-TK Pull now costs 4 milestones instead of 5. TK Pull Master now costs 2 instead of 3.
<li>-Additional attack drain from combo toggle lessened to 50% of what it was.
<li>-Rock Blast and Guide Bomb now cost 4 instead of 5.
<li>-Post Human no longer requires FBM.
<li>-Power Armor and Expand/Giant Form are no longer mutually exclusive.  Power Armor also no longer checks to see if you are at max  buffs.
<li>-Fixes. (If it would take me longer to write the update note explaining what I fixed, I usually just write fixes.)
<li>-Changed the way power up affects recovery. (Attempt to fix Magic Force/KO issue)
<li>-Adjusted max enchants for Enchant Master milestone down to 25 (All current enchants will remain).
<li>-HBTC Boost substantially nerfed.
<li>-Homing Finsiher damage mult reduced to 6x from 8x. Lower chance to be explosive. (Was 20%, now 5%)
<li>-Contact Point gain rate doubled.

<p>
<br>
<b>Roleplay Tenkaichi version 0.91B (Fixes, Nerfs and Buffs) - 4/19/2019</b><br>
<li>-Some issues with reverts resolved.
<li>-Saiyan SSj mods retroactively fixed.
<li>-Check Dragon Balls now shows when they come off being inert.
<li>-Mana Siphon and Auto Driller gains boosted by about 3x.
<li>-Changed the way that Willpower is drained on knock out.
<li>-Super Explosive Wave req reduced to 12k from 15k Base energy.
<li>-Refire cap increased. (Max attack speed increased.)
<li>-War, Pestilence and Famine nerfed slightly.
<li>-Stat cap softened.
<li>-BP cap ratio adjusted.
<li>-Hammers now allow you to gain weapon skill while using them.
<li>-Base Dig amount reduced to 25x from 40x.  Dig rate increased to 1 every 6 seconds from 1 every 12 seconds.
<li>-Digging and Mana meditation now both tick at 1 every 6 seconds and follow a normalized formula. (You need a circle for full mana gains)
<li>-Lowered Auto Drillers cost.
<li>-Kaio mystic slightly buffed.
<li>-Swords work with Ki Blade again but are now capped at 33% max BP, like gauntlets, while using it.
<li>-Some cardinal skills buffed.
<li>-You can no longer enchant items for energy mod.  All existing items  remain.



<p>
<br>
<b>Roleplay Tenkaichi version 0.91 (Chewyy Tries To Inflate The Update Log Numbers) - 4/17/2019</b><br>
<li> Gave further control to Changelings being toggled by Lead Admin
<li> Fixed issue where Elites could not be toggled on by Lead Admin
<li> Made it so Automatic World Saves no longer occur during Live Patch
<li> Created a reference for global RPs for Admins to reference
<li> Mystic updated to reflect balanced mods.
<li> Admins can now grant Bio Android forms.
<li>-Admins now have the option to grant a drainless transformation.
<li>-Added an automated system for pruning the old style of enchanted items that used BP as an option and did not have the cap.  They will be replaced with the equivalent value of mana.
<li>-Default inventory now 13, Beast of Burden increases it by 7.
<li>-Inventory Loop and Mana Siphon/Auto Driller loop moved to occur every 6s instead of 1.5s.
<li>-Firing a beam will now very slowly increase in cost based on the time spent firing.
<li>-Base enchantment cost reduced down to 50 million for 1%, down from 75million.
<li>-Gravity Well spell fixed. (85 Magic now)
<li>-Gravity Machine Int req lowered to 92.
<li>-Admins now have the option to grant milestone points as part of the starter boost.
<li>-Half of your total Milestone Points will now carry over on reincarnation.
<li>-Admins can now reward Milestone Points without using edit. (Use Alter Stats)
<li>-Multikeying (Having an alt or multiple people on one IP) now requires admin approval. Admins have the appropriate option under the Give Menu. (The process of approving has been added but the check that will disable it is now yet enabled.)
<li>-Precog now has a Skill Sheet page.
<li>-You can no longer attacking while using or being the target of Megaton Throw.
<li>-Fixed Pantheon revert.
<li>-Shield Master now costs 4 points instead of 5 and removes the Recovery nerf from Shield in addition to the Endurance boost.
<li>-Mortar Charge damage increased to 40x from 33x. Cost reduced to 4 points from 5.
<li>-Architect reduced to cost 4 points from 5.
<li>-Warp Attack Master now costs 4 instead of 5 points.
<li>-Burning Fists now costs 5 points instead of 6.
<li>-Energy Marksmanship now costs 6 points instead of 8.
<li>-Mana Siphon and Auto Driller now cost 6 points instead of 5.
<li>-Way of the Fist now costs 8 points instead of 10.
<li>-Rock "Blast" changed to Rock "Tomb"
<li>-Guide Bomb and Throw Blast/Tomb changed to 5 points instead of 6 points.
<li>-Endless Expanse changed to 8 points from 15.
<li>-Armor Mastery now costs 6 points instead of 8.
<li>-Beam Expert now costs 3 points instead of 5.  The additional drain was reduced from 3x to about 1.5x.
<li>-Rock Throw Expert now costs 3 points instead of 4. Damage mult increased to 4x from 3.5x.
<li>-Hyper Tornado now has a 10% accuracy boost.  Build-up time reduced from 5x refire to 3x refire and will now walk towards your target instead of randomly.
<li>-Hacking Console no longer displays the password of the hacked door.  It is now 50% less expensive as a result.
<li>-Wolf Fang Fist no longer gets an inate damage bonus but now scales with Speed. First two attacks get +15% Speed as damage then final gets +30%.
<li>-New Milestone:
<li> Way of the Open Palm: Increases attack damage by 10% Speed while not using a weapon. (Disables ability to pick Fist)
<li> Deft Hands/Swift Reflexes: Provides a flat 2.5% chance to hit/dodge basic melee attacks. 4 ranks max each.
<li> Will of Fire: This will increase your Regeneration Mod by 0.5(backend), double the rate at which limbs heal and reduce the cost you pay in Willpower to regenerate HP to 50% its normal rate. Reduces WP loss from KO by 5.
<li>-Oozaru buffed.
<li>-Guide Bomb verb changed to Sokidan.
<li>-Zanzoken Master buffed to +20% damage to combo attacks instead of +5%.
<li>-Beams now entirely ignore players in RP mode.
<li>-Sword Damage no longer stacks with ki blade.
<li>-Mana gain rate reduced.

<p>
<br>


<b>Roleplay Tenkaichi version 0.90a (The One Where Chewyy Didn't Do Much) - 4/16/2019</b><br>
<li> Adjusted Enchant cost down slightly
<li> Resolved issue where max enchants were 20 instead of 15, any enchants made before this are grandfathered in at 20
<li> Removed Power from Enchants, grandfather rule applies
<li> Live Patching failsafes and remedies put in place

<p>
<br>


<b>Roleplay Tenkaichi version 0.90 (The One Where Ryu Fucked With The Melee Meta) - 4/15/2019</b><br>
<li>-There is now a default inventory limit of 10 items. (Not including clothing)
<li>-Gauntlets can now be upgraded with magic and add up to +33% of your BP in the same manner as swords and hammers. They no longer increase strength.
<li>-Hammers, Swords and Gauntlets now follow the tier system of a maximum of +99% to attack bp for hammers, +66% for swords and +33% for gauntlets.
<li>-Cleave Attack may now be used with Hammers.
<li>-New Milestones:
<li> Mana Siphon: This will cause you to constantly gain passive mana at 5% the normal rate, no matter what you are doing. This stacks with meditating for mana. This will also cause your melee attacks to have a 25%  chance to leech 2.5% of your opponents mana.
<li> Gravity Well: This milestone allows you to create pockets of gravity using a spell and mana. Also requires 80 Magic.
<li> Beast of Burden: This increases inventory limit by 5.
<li> Auto Driller: This will grant you the ability to create and operate the Auto Driller, a piece of technology that will passively generate resources for you.
<li> Enchant Master: This will make you able to enchant items up to 30 times and reduces the cost of it by 50%.
<li>-Sword and Gauntlets base cost increased to 500,000 to reflect their value.
<li>-Power Control Expert now grants 0.5 Recovery in additon to 25% faster Power Up and costs 7 milestone points.
<li>-Sturdy Build now grants 2.5% Endurance and Resistance per rank for a max of 5%.
<li>-Burning debuff now stacks the duration, 3 seconds per stack up to a max of 12s.
<li>-Disease debuff now stacks damage, but now duration. 5x max stack. 5s duration per stack.
<li>-Bleeding debuffs stack independently of each other to represent individual wounds. 3 stacks max. 3s duration per stack. (This means it will be 3 individual procs of bleeding damage instead of one proc with 3x the damage on it)
<li>-Sword Skill rebranded to Weapon Skill.
<li>-You now gain unarmed and weapon skill from all forms of training, not just sparring players, but the rate is reduced.
<li>-Default mana gains reduced slightly.
<li>-Default dig rate shortened to 10s from 12s.
<li>-Androids can now install 30 stat modules instead of 25.
<li>-Horseman buffs buffed.
<li>-Demonic Fury and Angelic Grace buffed.
<li>-Cost for upgrading pylons and drill towers reduced from 400k to 100k.
<li>-Expand no longer reduces Recovery and now reduces Speed and Defense by 5% per level instead of 7.5%. Also now increases Resistance by 10% per level instead of 5%.
<li>-Agile Nature is now 20% to speed instead of 15%.
<li>-Beam Expert is now a toggle under settings on beam.
<li>-You may now only enchant items up to 15 times, +15%, until you purchase a milestone, Enchant Master, which reduces cost of enchanting by 50%, and allows you to enchant it up to 30 times.
<li>-Muscle Force and Magic Force reqs reduced and standardized.
<li>-Earthquake and Shockwave damage buffed.
<li>Added a second version of "Swell" for Spirit Dolls. Giving the option to use Muscular Swell or Energy Swell.
<li>Addressed issue where new Horsemen buffs could be used with Focus

<p>
<br>
<b>Roleplay Tenkaichi version 0.89 (Tim The Toolman Taylor) - 4/15/2019</b><br>

<li>Can now deflect beams by punching them (Probability will be adjusted as we go)
<li>Can now deflect beams by firing blasts at them (also will be adjusted as we go)
<li>Beam damage has been reduced (Might have overdid this, we will see)
<li>Added Four Horsemen buffs for Hell Ranks (Current Archdemons AHelp for the new kits)
<li>Decreased resource rate for Dragon glass at Dragon stone due to oversaturation
<li>Increased limb damage probability during melee fighting (may need further adjustments)
<li>Swole Doll added
<li>Spirit Dolls now learn Super Explosive Wave with hidden requirements
<li>Beams no longer penetrate RP mode.
<li>Blast HP delay lessened to about 50% of its previous effect.
<li>New Milestones.
<li>Thundering Blows: Gives your melee attacks with a hammer a 25% chance to slow your opponent by 50% for 5 seconds, but reduces Defense by 20% due to the concentration required. (Only works with hammers.)
<li>Ultra Intellect: This will increase your Int Mod by 0.5.
<li>Deep Pockets: This will reduce the cost of everything that costs resources by 15% per rank with a maximum of 3 ranks.
<li>Building now costs 100 per tile, up from 25 per tile.
<li>Hammers buffed to now only reduce Speed by 15%. Hammer Time now buffs Offense by 5% in addition to the 5% to Speed.
<li>Bleeding Edge and Burning Fists proc chance buffed.

<p>
<br>

<b>Roleplay Tenkaichi version 0.88 (Arya kidding me?!) - 4/12/2019</b><br>
<li>BP increases on Super Buffs
<li>BP decrease on Kaioken
<li>Focus can no longer be used with specific Super Buffs
<li>Normal/Lowie/Elite mod increases, to include SSjMult (FBM decrease)
<li>Magic Scanners no longer show base, they show what the targets 100% current BP is now
<li>Removed Wall owner information from Upgrade Walls
<li>Earth Prison walls can no longer be grabbed
<li>Revive now has a % chance to reduce the users decline by 25% current decline

<p>
<br>

<b>Roleplay Tenkaichi version 0.87.3 (!) - 4/08/2019</b><br>
<li>Adjusted damaged rate of fire for charged based attacks when health is below <50% (Made it a bit more reasonable)
<li>Hyper Tornado delay increased
<li>Fixed issue with 2nd Gens not getting all of their abilities (No, Nameks do not get Giant Form)

<p>
<br>

<b>Roleplay Tenkaichi version 0.87.2 (Wait, I can do WHAT?!) - 4/07/2019</b><br>
<li>Added in Elixer of Empowerment, this Elixer is a tech item at level 55 and using it will Cap the users stats.  It currently has a three year cooldown, which is subject to change.
<li>Changed Cyberize requirements (also effects Upgrade Android)
<li>Races other than Tuffles can Upgrade Androids
<li>Only Tuffle's can be Cyberized
<li>Fixed an issue where Give Power wasn't properly storing the Last Use date
<li>Digging now has a probability to increase Strength / Endurance as well as a much smaller chance to increase Base
<li>Certain techniques rate of fire will decrease with Health (Blast, Charge, Rock Throw, etc.)

<p>
<br>

<b>Roleplay Tenkaichi version 0.87.1 (REAL) (Placeholder MORE) - 4/05/2019</b><br>
<li>Decreased Decline rate while meditating
<li>Give Power power scaling adjustments (Still a WIP)
<li>Can now only receive Power from one person
<li>Give Power has a Year Cooldown now
<li>Give Power no longer KO's the user, instead it will bring the users energy down to 10% of their Max Ki along with Willpower loss (MaxHP)
<li>Created a LOOC toggle for Admins based on Planet
<li>Added Safeguard for Live Patch (User of Verb will be last client to be transferred)

<p>
<br>


<b>Roleplay Tenkaichi version 0.87 (REAL) (Placeholder) - 4/05/2019</b><br>
<li>Adjusted Mortar Charge fix, should be resolved
<li>Early stage EZ Flag system for Admins
<li>Made meditating on "Nothing" Mana rate lower
<li>Lowered overall Mana gain rate
<li>Adjusted Stat gains in respect to location of overcap
<li>Resolved issue with BP being displayed after Death
<li>Bandaid fix on Rock Blast until I can discover a better method
<li>Imposed Lethality requirement for Give Power
<li>Added a 30 WP cost to use Give Power
<li>Decreased Decline rate while meditating
<li>Give Power power scaling adjustments (Still a WIP)
<li>Can now only receive Power from one person
<li>Give Power has a Year Cooldown now
<li>Give Power no longer KO's the user, instead it will bring the users energy down to 10% of their Max Ki along with Willpower loss (MaxHP)

<p>
<br>

<b>Roleplay Tenkaichi version 0.87 (The Biggest Updates of Updates, Absolutely the best Update, and we made CC pay for it!) - 4/01/2019</b><br>
<li>New Pantheon
<li>Saying ‘Spah’ now results in a 15 minute auto-mute.
<li>New ‘random’ option for gender at character creation.
<li>Using this option on your first character per wipe increases Milestone points gained by 25%.
<li>Third buff added to Spirit Dolls called Swole Doll
<li>LSSJ is now granted on creation based on a formula consisting of user CID, Byond Key, character name, an algorithm that changes infinitely forever, and other alphanumeric constants. Approximate odds are 1 in 14,000,605.
<li>New item to easily identify admins added
<li>Red arm band with white circle, design inside.
<li>Magic Fixes / Additions
<li>Conjure Demon now requires a hat to pull them out of.
<li>New item at 150 magic that lets you turn people into furries or furries into people. OwO.
<li>New minigame added at 125 magic called ‘The Gathering.’
<li>Tech Fixes/ Additions
<li>LSD prohibition ended. Item readded to the tech list.
<li>Other narcotic related items added. Unlocked at random when taking LSD. Each carries combat or training bonus effects.
<li>New item at 75 tech called ‘Trash can.’ Right click it to submit a complaint.
<li>Bitcoin mining added at 150
<li>At tech level 200 the SPK now auto requests assistance setting up an email.
<li>This is a test system for our new Quest System. Subject to change.
<li>Swole Doll removed
<li>The source has been sold to Toei Animation / Funcom.
<li>Paid packs added.
<li>All forms of training replaced with Sudoku puzzles to prevent EZing.
<li>Makyo race renamed to Goblins
<li>Twitter integration
<li>Added emote requirement to certain skills like Materialize. Character limits in place as well as post duplication check.
<li>Female Characters now dig at 77% the speed of male characters.
<li>Space ships now have auto pilot. Nap while you travel.
<li>New EC item for testing tournament participants for performance enhancing narcotics.
<li>New (hidden) method for creating bio androids introduced.
<li>Goblin Slayer rank skills added, human only.
<li>Toggling Super Fly now equips you with some super fly sunglasses.
<li>New partnership with Pewdiepie. Subscribe to see future RT related content.

<p>
<br>
<b>Roleplay Tenkaichi version 0.86b (Yuuuuuuuppp) - 3/28/2019</b><br>
<li>Made Gauntlets for Tech Tree
<li>Made Magic Gauntlets available sooner, and cheaper
<li>Added Strength bonus to using Gauntlets / Magic Gauntlets
<li>Made Stat Caps only change every 5 wipe days (the Stat Cap will still hit the same point it would hit, but now is delayed)
<li>Fixed Mortar, it won't break you anymore
<li>BabyFat can now Live Patch
<li>Adjusted BP gains based on vicinity of cap and overcap
<li>Added a way for players to see Wipe Day (Status tab at the top)
<p>
<br>
<b>Roleplay Tenkaichi version 0.86a (Oops) - 3/18/2019</b><br>
<li>Fixed TE Requirement (Not retroactive, AHelp for it to be adjusted)
<li>Fixed Oozaru hit box issue, you'll now revert and not be off your marbles
<li>Slightly increased Sword Stab cooldown
<p>
<br>
<b>Roleplay Tenkaichi version 0.86 (Chewyy Fixes Pi) - 3/14/2019</b><br>
<li>SSj now takes a buff slot
<li>Second gens should now have the correct Recovery and Regeneration mods
<li>Shunken Ido energy requirement reduced
<li>Made it so Half races do not receive certain racial buffs
<li>Fixed issue with Demons not being born Demons
<li>Redefined how Saiyan Hellspawns are born
<li>Added more Cap control to Owner Level verbs
<li>Second gens should be able to Mate now
<li>Reviewed Anger, it is not bugged
<li>Absorb should no longer exceed the TrueBPCap multiplied by the users BP Mod
<li>Demonic Fury anger issue should be resolved
<li>Increased Sword Stab Cooldown and Decreased Damage a bit (Maybe?)
<li>Various undocumented fixes
<li>Made PU Cap able to be easily editted by Owner level verbs and changed default value
<li>Lowered Cyberize BP % to .5% from .6% and lowered Android Upgrade BP from .75% to 0.6%
<li>Increased Dragon Namek FBM to 2.1
<li>Increased Kaio Anger to 1.4x
<li>Slightly lowered Human TE requirement
<li>New Hidden Pantheon
<li>Boosted TE anger boost
<li>Boosted Majin anger boost
<li>Boosted Giant Form anger buff
<li>Lowered Makyo Form drain (I think?)
<li>New Body Size defaults
<li>Increased CD on Megaburst & Scattershot
<li>Fixed King Kold buff slot
<li>Increased Alien/Kanassan/Yardrat FBM
<li>Alien Hybrid buff now increases Offense rather than Speed
<li>Tuffle Energy Mod increased to adjust drain from Cyberize
<li>Post Humanism BP buff
<li>Humanism Recovery buff
<li>Reduced redundancies with logging
<li>BP gains adjusted based on range to cap
<li>Decreased cost of using False Moon
<li>Fixed Kanassa Limit Breaker bug
<li>Updated Oozaru icon, hit box is the center of the icon (Torso)


<p>
<br>
<b>Roleplay Tenkaichi version 0.85a (Fixes) - 1/09/2019</b><br>
<li>Muscle Force and Magic Force now have the same drain.
<li>Base Energy cap reduced from 1000x mod to 500x mod.
<li>Bombs removed from tech tree pending balance.
<li>Androids now start with 50x gravity instead of 100x. (Retroactive)
<li>Various other unlisted fixes.

<p>
<br>
<b>Roleplay Tenkaichi version 0.85 (Merry Christler) - 12/25/2018</b><br>
<li>Expand reqs reduced.
<li>Attempt to fix Customize Stance Refund
<li>Ki Blade buffed.Force Fields now have a cap for max resources.
<li>Force Fields no longer cause you to ignore ki damage, but now reduce the damage by 70%.
<li>Force Fields now have a cap for max resources.
<li>Buffed Demon Offense.
<li>Magic/Int catch up gains enabled again.
<li>Redo stats now readjusted for substantial overcaps.
<li>Training Dummy gains boosted.
<li>New Milestones
<li>Ships now have a cooldown of 2 years between launches. Pods have a cooldown of 6 months.
<li>All auto cap increases are now using the Wipe Day system and not years.
<li>Changed how custom Oozaru icon works. You may need to use Custom_Oozaru_Icon.
<li>Offspring will now gain milestone points only after their 5th birthday.
<li>Changes to regen ticks and cost of WP in lethal combat per regen tick.
<li>Expand is now only teachable by ranks and is no longer leechable. Expand is auto learned by Demons, Oni, Demigods, Namekians.
<li>Buffed rock throw mastery slightly.
<li>Expand reworked.
<li>Fixes.
<li>Shield now reduces beam damage by 10% instead of 30%.
<li>Self Train gives slightly more BP.
<p>
<br>
<b>Roleplay Tenkaichi version 0.84a (FFFFFFFFFFFixes!) - 12/22/2018</b><br>
<li>Fixes.
<li>Pantheon requirements adjusted again.
<li>Stronger grip.
<p>
<br>
<b>Roleplay Tenkaichi version 0.84 (Nerfs) - 12/20/2018</b><br>
<li>Fixes.
<li>Steroids nerfed and now reduce speed. Cap at 30% base instead of 100% base.
<li>Demon buff nerfed.
<li>Lightning Bolt disabled again.

<p>
<br>
<b>Roleplay Tenkaichi version 0.83 (Demon Pants) - 12/18/2018</b><br>
<li>Fixes.
<li>New buff/trans for DL/Archdemons to compete with Kaio buffs.
<li>Ki Fists is now auto learned.
<li>Ki Blade is now a milestone/rank skill and is not leechable.
<li>Changes to how BP is capped.
<p>
<br>


<b>Roleplay Tenkaichi version 0.82b (Honey Bunches of Bug Fixes: With Walnuts!) - 12/15/2018</b><br>
<li>Fixes.
<li>Vitamin C.
<p>
<br>

<b>Roleplay Tenkaichi version 0.82a (Honey Bunches of Bug Fixes: With Almonds!) - 12/15/2018</b><br>
<li>Fixes.
<li>You now gain more by having lethal turned off while sparring.
<li>Hidden Patheon's req reduced.
<li>Lightning strike disabled temporarily.
<p>
<br>
<b>Roleplay Tenkaichi version 0.82 (Honey Bunches of Bug Fixes!) - 12/14/2018</b><br>
<li>LethalCombatTracker now lasts 20 minutes.
<li>Rock Blast renamed to Rock Tomb. (Sad face)
<li>Bleeding Edge and Burning Fists nerfed slightly.
<li>Soul absorb now grants 20% of the victim's base bp to the absorber as base bp.
<li>Lots and lots of changes.
<li>All final changeling forms now take one buff slot.
<li>Added a new hidden Pantheon
<li>Bunch of bug fixes.
<p>
<br>
<b>Roleplay Tenkaichi version 0.81 (Groundhog Day!) - 12/08/2018</b><br>
<li>Building is now 25 per tile
<li>Method for tracking Milestones changed, you may notice some extra entries, do not repurchase them.
<li>Possessing a Soul Contract now grants you 1.5% BP boost per soul.
<li>You can now only earn up to 2 Milestone points at a time.  This means logging out for 10 years and then back in will only yield 2 points.
<li>New variable for ECs/Admins, DoesNotAffectStatRank.
<li>New Body Part HUD (See drop down options menu)
<li>You can no longer stack cyberize and augment.
<li>Kaioken no longer increases PU speed.
<li>Resources per digging tick reduced by 20%.
<li>Second wave of Milestones.
<p>
<br>
<b>Roleplay Tenkaichi version 0.80 (Happy New Year) - 12/05/2018</b><br>
<li>First wave of Milestones introduced.
<li>Increased BP gains via sparring.
<li>Charge has a minimum 1.5 second CD now but scales less from speed.
<li>Beams do less damage to force fields, blasts do more.
<li>Space deals WP damage instead of instant death.
<li>Majin's passive Regen increase doubled.  It no longer grants Regen mult as a result.
<li>You can now Death Regen less times total but come back to life at a higher WP. (65 instead of 50)
<li>Cyberize/Upgrade Android debuff is no longer tiered and starts at the full value.  (-70% recovery for non Tuffles, -50% recovery for Tuffles)
<li>Area Load/Save for resources/mana fixed.
<li>SSB Auto unlocks at 1.5 God Ki for a Saiyan.
<li>Rock Throw Expert nerfed slightly. Rock Slide now gets 3 more projectiles.
<li>Rock Blast added to Milestone list.
<p>
<br>
<b>Roleplay Tenkaichi version 0.79f (Merry Christmas) - 12/03/2018</b><br>
<li>Emitters are now admin created.
<li>Assess sheet updated.
<li>Fixed a bug involving Android Power % display.
<li>Stat catch up increased by about 10%.
<li>You can now customize the icon of Third Eye.
<li>Fixed an issue causing you to be unable to absorb someone while they are in RPmode, essentially requiring them to have 0 WP.
<li>Androids can now power up while upgraded, but suffer the full debuff to Recovery (-50% at level 100).
<li>Changeling base BP Mod buffed, King Kold Recovery buffed.
<li>Fixed an issue with God Ki aura not following pixel x/y.
<li>There is no more Toggle God Ki verb, for now you must click the object in your stats menu.
<p>
<br>
<b>Roleplay Tenkaichi version 0.79e (Fixes) - 12/02/2018</b><br>
<li>Unlisted
<li>Bug
<li>Fixes
<li>.
<p>
<br>
<b>Roleplay Tenkaichi version 0.79d (No More Metal Men) - 12/01/2018</b><br>
<li>You can now learn Conjure from magic at level 110.
<li>You can only use a stun chip on someone below 40 Willpower.
<li>Increased Recovery from powering down is now capped at 5x.
<li>Custom Alien absorb no longer reduces Recovery or Regen.
<li>Homing Finisher CD corrected, maximum blasts reduced to 66, from 100.
<li>Customer Alien Energy, Recovery and Regen increased to 1.2x.
<li>Pantheon will now provide anywhere from 0.5 to 1 additional God Ki (called SSjGodKi) while used after global god ki has been unlocked. (Similar to Super Majin/Mystic)
<li>Alien Transformation will no longer work with Cyberization.
<li>Changeling Golden Form will no longer work with Cyberization.
<li>Power Armor no longer takes a buff slot but is now nerfed.
<p>
<br>
<b>Roleplay Tenkaichi version 0.79c (Chewyy Breakin' Stuff) - 11/30/2018</b><br>
<li>Super Saiyan drain returned to previous.
<li>Additional fixes for gauntlets.
<li>Changelings are now using the most updated stats.
<li>Imitate now changes your text color to your target's.
<li>Using Expand while in Expand will now automatically revert the user.
<li>Oozaru icon no longer runs in place
<li>Two new Admin commands, one of which is Owner level
<li>Unlisted changes.
<p>
<br>
<b>Roleplay Tenkaichi version 0.79b (Fixin' Things) - 11/28/2018</b><br>
<li>Namekians get Fusion on FBM and >5 Save Age.
<li>Lots of unlisted tweaks and fixes. :D
<li>Senzus are now made via a verb by the Korin.
<li>Earth Prison walls buffed.
<li>SSj2 drain increased. SSJ3 drain increased.
<li>Some cooldowns changed.

<p>
<br>
<b>Roleplay Tenkaichi version 0.79 (Fixin' Stuff) - 11/26/2018</b><br>
<li>You now lose 10% Recovery for every 20 Cyberize levels capped at -50% (Additive and not multiplicative).  Tuffles do not lose Recovery at 80 and 100 Cybrize and so cap at -30%.
<li>You now lose 10% Regeneration for every 30 Cyberize levels capped at -30% (Additive and not multiplicative). Tuffles cap at -20%.
<li>An Android will not lose WP while regenerating in Lethal Combat due to them not depleting their body's store of energies in order to do so and are automatically repaired by their subroutines.
<li>Androids can no longer use Potions of Health or Life, they can still use respec potions.
<li>Alien transformation stats updated. Melee now gives 1.25x str instead of 1.2x, Hybrid now gives Off/Def instead of Str/Force.
<li>You may now target by clicking again.
<li>Changeling stats altered. All changies get a redo stats.
<li>Cyberize now grants 0.8% BP from 0.75%.
<li>Now a 3% chance per knockback distance to knock an opponent to the ground.
<li>New Magic item called Magic Guantlets. Takes the place of a sword to allow enchantments without using a sword.
<li>Flee now has a corresponding verb that will automate a 3 minute countdown. It should be used once the verb starts and will help track if you have safely fled. If you are knocked out it will stop the flee counter.
<li>Magic Scouters can now read base BP.
<li>Gravity Mastery Mod standardized to 2x.
<p>
<br>
<b>Roleplay Tenkaichi version 0.78 (I Drop Massive Logs) - 11/25/2018</b><br>
<li>Willpower "wake up" is now automatic after turning off RP mode.
<li>Heal now has a short cooldown.
<li>Fixed an issue with redo stats.
<li>Lethality simplified such that Lethal and Pulling punches now toggle together.
<li>Earthquake and Shockwave bugfixes.
<li>Off/Def gain from self train increased.
<li>Admin: Stealth verb reworked into Admin Mode.  Now Admin Mode will hide your name and icon.
<li>Fruits no longer function as senzu beans.
<li>Makyo Star boost no longer affected by power control.
<li>Health Potions now only affect Regeneration rate and not Recovery.  They will also increase the rate at which WP drains from regeneration in Lethal Combat by 25% as a slight drawback. The logic is that you are just forcing the same reserves of Life energy out a quicker pace.
<li>You may now spend milestone points to improve and train martial arts.
<li>Custom Aliens may now invest up to 20 points in one stat instead of 15.  Fixed a bug where they were getting 60/70 points instead of the intended 60. Set to 65 as a middle ground.
<li>Custom Aliens now have 1.1x in all stats instead of 1x in everything except energy, recovery and regneration, which were 1.2x.
<li>Attempted bugfix for snares causing knockbacks to infinite loop.
<li>Changed skills and effects that "affected natural regeneration/recovery ticks" to now just affect Regeneration/Recovery mult for an easier to understand and more transparent process.
<li>Steroids now reduce Regen/Recov by 10% when used, another 10% when they are 50% or more of your base and another 10% if they are equal to or more than your base BP.
<li>SNj aura from power control removed.  SNj now uses the icon of the skill itself.
<li>Fixed a bug causing you to move while piloting ships.
<li>Fixed a bug where logging out while piloting would place you outside the ship.
<li>5 minute CD between upgrading roofs for fly over.
<li>Target window now shows a target's lethal intent.  Clicking a mob will do the same thing.
<li>Buffed the flat regen passive increase from Majin. This is the sole exception to skills affecting Regen/Recov without dispalying on the stat itself, but will show in the HP per tick.
<li>Historic rewards system disabled to reduce overhead until a new system is introduced.
<li>All spells are now verbs that show up in Skills tab. Heal spell renamed to Rejuvenate. All spells no longer require a spellbook.
<li>Set Target is now a right click option and Clear Target is now in Other tab. Clicking on a mob will no longer set target.
<li>SSj2 and Super Bojack drain reduced.
<li>Improved logs.
<li>Options menu reorganized.
<li>All transformation experience gain standardized.
<li>SSj2 BP Mult increased to 1.6x from 1.5x. (1.7x now from 1.6x for Elite and Half Saiyan)
<li>Willpower will now reduce movementspeed if below 50% HP and less than 70% WP.
<li>LethalCombatTracker duration increased to 15 minutes, up from 10 minutes.
<li>WP regeneration rate reduced.
<li>Previously, you had a 50% chance to recover energy each tick.  It is now a 100% chance but the overall amount restored per tick has been decreased.
<li>Using a new method to determine diminishing returns on PC affecting recovery.  The system previously was not very intuitive and overly complicated, currently your recovery ticks will be multiplied by x(100/BPpcnt).  So if you are at 50% power, you recover 2x as fast, but at 200% power you recover 0.5x as fast.
<li>Kaioken is can no longer be used with Super Saiyan other than Super Saiyan Blue.  Kaioken now doubles the rate you power up at.
<li>Demigod base BPMod Spd and Off boosted.
<li>Low Class Saiyan Recovery increased.
<li>Kaio FBM increased to 2.5x from 2.3x.
<li>Demigods, Low Class and Kaios received a redo stats. In order to get the new mods, you must redo stats.
<li>Damage to Forcefield reduced.
<li>Soul Contract summon now has a 4 month cooldown.
<li>Sloppy fix for blast KB loop with snares and stuns.
<p>
<br>
<b>Roleplay Tenkaichi version 0.77 (Combat Rework) - 11/20/2018</b><br>
<li>Willpower is no longer tied to KO time. You now lose a flat 30 Willpower on KO during lethal combat. If you are reduced to less than -500% Health by the attack it takes an extra 10 Willpower.
<li>Willpower will now passively drain at a slow rate each regeneration tick.  This will only occur during lethal combat.
<li>Someone must now be below 70 Willpower in order to be manually injured. Passive combat damage to limbs has been increased as a result.
<li>Dragon Ball wishes are now admin only once again.
<li>SSj drain reduced.
<li>Fixed Megaburst auto learn from Magic.
<li>Physics Simulation drain increased.
<li>Reincarnation will no longer carry over skills.
<li>Attacking will no longer disable recovering energy.
<li>Majin now increases Max Anger by 10%.
<li>Reduced the rate beams drain force fields.
<li>Send Energy HP and Energy rate reduces by about 15%.
<li>Recyclers can no longer kill.
<li>All health loss, for any atom, is now passed through the same procedure. This will help for standardization and balancing as well as bugtesting. This is also used to support the new Willpower drain from passive Regen during lethal combat.
<li>To support the new passive drain for Willpower, and using the new standardized procedure, a new flag for participating in lethal combat exists that lasts for 5 minutes.  This flag will eventually be used to streamline the fleeing system as well. It currently lasts for 10 minutes.
<li>Android FBM retroactively changed to 7x.
<li>Removed Sacred Water.
<li>Demigod Pantheons buffed slightly.  Added another hidden Pantheon.
<li>HBTC Boost is now manually controlled by the admin team.
<li>The Injure verb now includes an option to Kill a player below 30 Willpower. You can still be killed by having your Life reduced to 0 while below 30 Willpower.
<li>Door duplication fix attempt.
<li>All characters start with a Redo Stats now but they will no longer be given out by admins after this wipe.
<li>Admins now have force RP mode.
<li>RP Mode button on HUD.
<li>Building any tile now costs 10 resources per tile.
<li>Renegerators, Heal verb and Heal spell will all now restore someone to atleast 1 Willpower. Regenerators now passively restore Willpower, Heal spell will restore some based on user's Magic level and Heal verb based on experience and drain half that from the user.
<li>Most transformations now have messages similar to Changeling transformations.
<li>SSj Tails should now turn yellow.
<li>Super Bojack bug resolved.
<li>Soul Contract no longer has a grant power mechanic.  All Demon ranks will now get it.
<li>Physics Simulation requirement increased to 80 Int and 1.5x FBM req.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.76 (Joke's Over) - 11/17/2018</b><br>
<li>New Admin tier system for determining verb access.
<li>Fixed an error in Physics simulation's math.
<li>Milestone Points backend added.
<li>Android BP % per upgrade level reduced to 1.5% from 1.75%
<li>Upgrade Android will now reduce an Androids Recovery by 10%.
<li>Fixed description for "Resistance" on Enchantments
<li>Fixed description error on buffs that have different stats for multiple races (Majin, Mystic, Giant Mode, etc.)
<p>
<br>
<b>Roleplay Tenkaichi version 0.755 (Won't End Today!) - 11/13/2018</b><br>
<li>Swords now decrease Offense Mult by 25% instead of reducing overall accuracy by 35%. This is for several reasons but ease to understand being primary.
<li>Energy Soft/Hard Cap decreased by about 15%
<li>Lots of unlisted fixes.
<li>Saiyan stats tweaked again.
<li>Android Max Energy boost from Upgrade Android disabled.
<li>New formatting on update notes. May be bugged.
<li>Scouter formula updated again.
<p>
<br>
<b>Roleplay Tenkaichi version 0.754 (When Will This Version End?) - 11/12/2018</b><br>
<li>Cyberize is now +0.75% BP per level.</li>
<li>Descriptions corrected for all Buffs and Support Skills.</li>
<li>Increased efficiency for Buffs for ease of editing and making description updates automatic.</li>
<li>Added a limit on splitting Senzu Beans.</li>
<li>Power Control now has a Set Target Power verb that allows you to set the level you wish to power up to and automatically start doing so by using Power Stabilize when at 100% power.</li>
<li>Send Energy debuff changed to use the RecentSendEnergy var and instead set recovery to 50% within the backend. This will last for 300 ticks or 7.5 minutes.</li>
<li>Solar Flare reworked to be a movement impairing crowd control effect that scales based off max energy.</li>
<li>Zanzoken is now blocked by anyone that is flying.<li>
<li>Mystic now stops alien trans drain.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.753 (Something Normal Thing Way Comes) - 11/11/2018</b><br>
<li>Magic Scanners now count for viewing your own BP in stats tab.</li>
<li>Fixed Bio Android FBM requirements.</li>
<li>Warp Attack can now be used over water.</li>
<li>Fixed a bug with teaching causing your skill to say you taught yourself.</li>
<li>Fixed multiple dig instances bug. Sorry wallet.</li>
<li>Android Upgrade cost increased.</li>
<li>Cyberize cost dramatically increased.</li>
<li>Cyberization now reduces Regeneration and Recovery by 10% and another 10% if cyberized past level 50 and not a Tuffle.</li>
<li>Cyberization now disables SSj and Bojack. (SSG is still attainable but not SSB)</li>
<li>Physics Simulation drain reduced.</li>
<li>Crystal Ball usage requirement increased to 50 magic and creation level increased to 70.</li>
<li>Upgrade Android is now a 1 Int Level : 1.75% Passive BP and 0.5% Energy increase.  Any upgraded Android loses the ability to power up. Energy is a passive instead of increasing the mult so that stat mult reset does not interfere.</li>
<li>Super Majin/Mystic buffed to increase BP by an additional 25%.</li>
<li>Limit Breaker limb damage increased.</li>
<li>Additional validity checks for stat point assignment.</li>
<li>Augmentation actually works now.</li>
<li>Normal-Class Saiyans reintroduced.</li>
<li>Saiyan mods tweaked.  All Saiyans granted a Redo Stats on login.</li>
<li>Tuffle BP mod reduced from 2 to 1.9. This is not retroactive and existing Tuffles keep their BP mod.</li>
<li>Redo Stats will now refund an Androids Upgrades.</li>
<li>Swords now longer give an automatic +10% Strength.</li>
<li>Scouter max scan reduced. Not retroactive.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.752 (The Version That Never Sleeps) - 11/09/2018</b><br>
<li>Kaioken drain reduced slightly.</li>
<li>Shockwave and Earthquake damage reduced.</li>
<li>Demigod FBM fixed.</li>
<li>Bojack Trans fixed.</li>
<li>Oozaru BP fixed.</li>
<li>Physics Simulation drain reduced.</li>
<li>Cyberize Fixed.</li>
<li>Power Control (sustaining a +%) drain reduced by about 30%.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.751 (Version 75: A New Version) - 11/05/2018</b><br>
<li>Frost Nova does 20% less damage and less stun time. (8 max ticks instead of 20 and 0.5x the base duration)</li>
<li>Max power up is now +25 x Recovery instead of +50 x Recovery by default. Admins can adjust this number on the fly.</li>
<li>Cyberize reworked to be similar to Android Upgrades.</li>
<li>Shadow King reduced to +200% BP instead of +300%.</li>
<li>Energy Hard Cap will now be automatically set to atleast 1.5x the soft cap.</li>
<li>Stat Cap and Energy Cap now saved on world save. This will not be retroactive and will only affect the next update and onward.</li>
<li>Demigods no longer require a mated Kaio to be created.</li>
<li>New Master Learn List created that standardizes the basic skills.</li>
<li>Potions and Senzu Beans now calm the user.</li>
<li>Oozaru now sets Defense to 25% instead of 5%.</li>
<li>Players may now view Year Speed by clicking on the date in Status tab.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.75d (Version 75 Part 5: Revenge of the 5) - 11/01/2018</b><br>
<li>Gravity will now only kill you if you are in more than 10 levels higher than mastered.</li>
<li>RPP temporarily disabled</li>
<li>Each AndroidLevel is 0.5% BP instead of 1%</li>
<li>Each Android Module is 1.5% BP instead of 2%</li>
<li>Overdrive now gives about 25% less BP.</li>
<li>Androids will now lose up to 20% BP based upon current energy instead of constantly being 100%.</li>
<li>Fists of Fury no longer grants speed.</li>
<li>Activities will no longer yield BP as rewards.  May be reworked to generate Activity Points that function similar to old RPP.</li>
<li>Fixed issues with Death.</li>
<li>Mating temporarily disabled.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.75c (Bugs) - 10/17/2018</b><br>
<li>Various fixes.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.75b (Do you like fish sticks?) - 10/14/2018</b><br>
<li>Hell Roofs and Tiles removed/replaced with other tiles as they are being phased out.</li>
<li>Multikey Check verb for admins.</li>
<li>Replace verb re-added for HA and above.</li>
<li>New variable that allows people to build in space with admin approval.</li>
<li>Fixed a bug with Factions.</li>
<li>Freiza Changelings now balanced to 2x base speed, but have power control added to their learn list. They are the only changeling to naturally learn PC.</li>
<li>Anger and KO overlays disabled until I redo them using BYOND's animate proc.</li>
<li>Wearing a scouter will now display current BP in stats tab.</li>
<li>Tech/Magic soft cap softened slightly.</li>
<li>People think Kanssa are fish so they start with swim mastered.</li>
<li>Mutations hidden for all below head admin.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.75a (Fixed It) - 10/12/2018</b><br>
<li>Precognition now also causes your speed to contribute 20% towards Off/Def instead of 15%.</li>
<li>King Kold anger reduced to 1.2x as was intended.</li>
<li>Spellbook and Drill upgrade issues resolved.</li>
<li>Fixed Elite Saiyans Magic Mod.</li>
<li>Anger overlay defaults off. Same with KO overlay. (Use Stat Overlay Toggle in options menu)</li>
<li>AFK is no longer included in your name while AFK.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.75 (Is That A Short Joke?) - 10/11/2018</b><br>
<li>Unlock Potential and Dark Blessing changed to follow a standardized boost instead of being calculated off of Potential. Each was buffed to make up for the change.</li>
<li>Majin and Mystic standardized and less scalar.  Now +1 God Ki in Super Majin/Mystic instead of +100%.</li>
<li>Removed Sense Outsiders verb from KS/DL.</li>
<li>Vampires removed completely until further notice.</li>
<li>Unlocking God Ki via leeching now only grants 0.5 God Ki, down from 1.</li>
<li>Removed the SenseMod variable.  Sense and sense related skills now scale off of your Ki Mod.</li>
<li>Lots of redundant and obsolete variables removed.</li>
<li>All Namekians now share a spawn.</li>
<li>Players now have access to Random Number Generation.</li>
<li>Energy Hard Cap is now an actual hard cap and not just a harder soft cap.</li>
<li>Drones now scale based off of the average BP.</li>
<li>Profiles removed.</li>
<li>Help Say verb removed. (Use OOC or Ahelp)</li>
<li>Significant changes to admin verbs and backend.</li>
<li>Maximum effective gravity increased to 937.5x up from 625x.  The maximum boost you can receive was increased from 2x to 2.5x.  This means each point of mastery will still be worth the same but gives a longer field to progress over.</li>
<li>Var: Int_Mod renamed to Int_Mod in order to follow same scheme as other int vars and magic vars.
<li>RP_Add removed from all races that start with it. All RPPower and RP_Add will be rank/EC given instead of on creation.  Races that are intended to start more powerful will receive a higher base.</li>
<li>Cyberize BP is now based on a scale of ~15.8 million BP at level 100 Int on a 1x Int Mod.  It will scale directly with your mod, so someone at Tuffle Int at level 100 would be around ~80 million. This is a significant increase, from 900k x Int Mod at 100 int.</li>
<li>Cyberize Upgrade cost reduced by about 30%.</li>
<li>Activity reward Drills now get their reward mult as an additive on top of whatever level they are.  This will make them feel special again and not just crap drills.</li>
<li>Drills now have an extra stat called, ExtraDigMult, that is used to track the above new variable.</li>
<li>Activities will no longer grant weights as a reward.  Spellbooks with the same system as the changed Drills will replace them.</li>
<li>Var: BPMult changed to BPMult.</li>
<li>Updated, more dynamic catch up gains for Magic and Int.</li>
<li>Aliens now use standardized variables for trans. AlienBuild, which would be "Ki","Melee" or "Hybrid, HasAlienTrans for tracking unlock and AlienTrans for tracking trans state.</li>
<li>Namekian Fusion redone.  Now you gain 25% of the fusee's Base/Energy and a 10% BP Mod boost.</li>
<li>BreathInSpace variable changed to BreathInSpace</li>
<li>Demon Clan Namekians are being phased out. Still in as a rare.</li>
<li>Racial stats re-re-rebalanced.</li>
<li>Physics Simulation changed to a draining transformation instead of a timed one.</li>
<li>Lots of changes to Rank kits.</li>
<li>Overdrive is now autolearned after consuming 20 Upgrade Modules, this is not the same as using an upgrade and instead increases your resting BP by a passive %.</li>
<li>Fists of Fury is now autolearned on FBM.</li>
<li>I, for one, welcome our new machine overlords.</li>
<li>Added Earthquake, a physical version of Shockwave.</li>
<li>Shockwave and Earthquake damage ratio boosted to 3.5x.</li>
<li>Updated body size mathematics.</li>
<li>Active/AFK player counts moved to the Server Info pop up.</li>
<li>Melee skills no longer universally learned.  They are now leechable.</li>
<li>KS/DL now start with Super Mystic/Majin</li>
<li>Admins can now manually assign planetary gravity.</li>
<li>Cyber BP no longer nerfs anger.</li>
<li>New Red Ribbon Leader rank and supporting skills.</li>
<li>New variables, IgnoresGodKi. Does what it sounds like.</li>
<li>Combat Mathematics is now universal to all techies.  Tuffles learn it at 30 Int and everyone else at 60</li>
<li>Lots of undocumented changes!</li>
<li>Updated Cardinal skill kits.</li>
<li>Potential variable removed. May later be reintroduced.</li>
<li>Blue Comet Special skill added.</li>
<li>Rock Slide skill added.</li>
<li>Genocide reworked into a single target ability.</li>
<li>Pressure Punch is now a snare.  Wall of Flame is now a stun.</li>
<li>Wall of Flame can now only be taught by the DL.</li>
<li>Android ship now has a collective resource pool, AndroidRes, that is used to rebuild androids, manufacture new ones and make upgrades.  Eventually the ship itself will get mining capabilities to be self-sustaining.</li>
<li>Each wipe, now only eight initial android bodies will be created by the mainframe, all androids after that must be produced by the ship. (Expecting memery and trolling, this will be a ramping enforcement.) </li>
<li>Senzu growth rate slowed.</li>
<li>Golden Form for Changelings no longer reduces their Recovery.</li>
<li>Each Changeling form is now standardized to reduce Recovery by 10%.</li>
<li>Changeling races are now chooseable.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.74 (Who's Been In My Room?) - 9/25/2018</b><br>
<li>Redo stats will no longer cause you to lose your FBM.</li>
<li>BP, Anger and Recovery mutations are now considered unique and you will never roll more than one of them in total.</li>
<li>You will no longer be able to roll an Anger mutation on a race that doesn't start with anger.</li>
<li>Physics Simulation duration doubled.</li>
<li>SSG and God Ki are once again tied together for Saiyans, Half-Saiyans and Part-Saiyans.  This is due to their inability to use SSj while using God Ki and scales as they master their God Ki.  For it to be seperate leaves Saiyans very underpowered and defeats the system of progression granted by having it scale with God Ki.</li>
<li>Fixed a bug with absorb BP loss.  Was losing 90% instead of the intended 10% per month.</li>
<li>Absorb BP will now fade away when it is less than 5% of your current Base BP.</li>
<li>Bio-Absorb will now granted 25% of someones Base, up from 20%. Bio-Absorb will now also grant 10% of the victims Max Ki and 10% of their decline age. (Victim does not lose these amounts) As a result, Bios will now gain significantly less decline when transforming.</li>
<li>Custom stances may now be altered by anyone that is a master of the stance and is no longer restricted to the creator. (Still inherits the original stances stats and only has 2 point refunds)</li>
<li>Fix attempt for Leave Planet.</li>
<li>Admins now have the ability to set a global cap for training God Ki.</li>
<li>SSj3 drain slightly reduced. SSj3 Mult increased to 1.7x from 1.5x</li>
<li>Ultra Instinct now grants 2.5x Off/Def, up from 2x. It now drains slightly less ki but will drain Willpower over time.</li>
<li>SSB drain slightly reduced. BP mult increased from 1.5x to 2x.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.73b (Less Drain) - 9/20/2018</b><br>
<li>Fixed an issue with SSj3 and Mystic. You may now use them together mechanically but will need to refer to rules.</li>
<li>Lowered drain of Focus, Fists of Fury and Magic Force.</li>
<li>Sword Force now reduces Endurance by 15% instead of only 10%.</li>
<li>Non-mated Demigods are disabled until bugs involving their creation are resolved.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.73 (FROST SHOCK) - 9/19/2018</b><br>
<li>Further optimization and bug fixing on Scan Area window.</li>
<li>Activities are now viewed via "Show Activities" in order to reduce impact on Stat tabs.</li>
<li>Factions are now viewed via "Show Factions" in order to reduce impact on Stat tabs.</li>
<li>Injuries are now viewed via "Toggle Body Parts" in order to reduce impact on Stat tabs.</li>
<li>Languages are now viewed via "Toggle Languages" in order to reduce impact on Stat tabs.</li>
<li>Shifted the workload of sense tab updates out of the Stat tab proc and into its own standalone. Overall refresh time reduced to once every three seconds instead of every second and a half.</li>
<li>All forms of Sense (Scan, Radar, Security, etc) are all now loaded into the same grid.</li>
<li>Several customization options have been removed from the Other tab and moved into the Options drop down menu in the top left of the screen.</li>
<li>Significant rework of how the Stat tab organizes your stat display. Should be more responsive and less resource intensive.</li>
<li>Focus, Magic Force and Fists of Fury no longer reduce your natural recovery ticks while using but now drain more instead.</li>
<li>You may now use the Enter verb to enter a ship while within 2 tiles of the entrace.</li>
<li>Expand no longer reduces your regeneration.</li>
<li>Upgrading scouters will now increase the max futher than before. (Not retroactive)</li>
<li>A new snaring spell called Frost Nova was added for level 55+ magic.</li>
<li>Time freeze formula significantly altered. (Uses base force versus resistance, increased futher by base recovery and artificial BreathInSpace.)</li>
<li>SSj 2,3 and SSB drains reduced. </li>
<li>Super Bojack drain reduced.</li>
<li>Golden Changeling drain increased.</li>
<li>Expand formula altered. Its description now matches the effects.</li>
<li>Sword and Unarmed skills added to skill sheet.</li>
<li>Removed functionality for group RP mode. (May revisit feature in the future)</li>
<li>Collision detection added for zanzoken. You may now only zanzoken in a straight line and not through solid objects.</li>
<li>KaiokenMod variable removed. All races get the same benefit from Kaioken now.</li>
<li>Observe bugfix attempts and code cleanup.</li>
<li>You may zanzoken while snared but the drain is much higher.</li>
<li>You may now naturally leave Leave Planet with very high base and energy.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.72 (Now Featuring 100% More RyuShinta) - 9/18/2018</b><br>
<li>Wall of Flame reworked into a snare, damage reduced slightly.</li>
<li>Post Hmanism will no longer subtract decline after you become a full post-human.</li>
<li>Third Eye description fixed.</li>
<li>Attempt to fix WFF bypassing second wind and anger.</li>
<li>Attempt to fix an exploit that used knockback blasts to force people out of afk.</li>
<li>Architecture for new genetics system introduced.</li>
<li>Scan Area cleaned up and changed back to "Toggle Sense"</li>
<li>Fixed issues with SSj 2+ not removing the buff slot.</li>
<li>New Learn List system added, eventually will be flushed out to allow you to learn skills based upon your play style.</li>
<li>Fixed several issues with Oozaru.</li>
<li>Fixed issues with Kaioken Mod getting reduced further than intended.</li>
<li>Stat UI cleanup and bug fixes.</li>
<li>Learning system overhauled and streamlined. Some requirements changed. (Only affects new characters, not retroactive.)</li>
<li>New Unarmed and Sword Skill skills added. (Will eventually be flushed out into a passive system depending on player reception.)</li>
<li>Resolved a bug with Time Freeze not freezing as long as intended.</li>
<li>Some redundant variables removed.</li>
<li>Pressure Punch stun time was buffed slightly.</li>
<li>Several aspects of FBM application and tracking cleaned up, not retroactive.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.71b (*yawn*) - 8/22/2018</b><br>
<li>Buffed Herans a bit (This will be automatic for existing Herans)</li>
<li>Adjustments to Oozaru, buffs in certain aspects, nerfs in others(Lemme know how it feels)</li>
<li>Fixed an issue with Lowie creation Anger</li>
<li>Fixed an issue with incorrect output on Setting Stat Cap</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.71a (You might like me when I'm angry) - 8/21/2018</b><br>
<li>Decreased Mutations increase from BPM and Anger mutations (this is retroactive)</li>
<li>Anger will now no longer show as an increase in your Power %</li>
<li>Energy mod hidden under Status tab</li>
<li>Adjustments to Changie mods</li>
<li>Fixed an issue with Energy Absorb</li>
<li>Increased Oni anger, this is automatic</li>
<li>Changed front page of website, and adjusted Guide location for in game links</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.71 (Insert Clever Thing Here) - 8/20/2018</b><br>
<li>Increased FPS and addressed lag issues</li>
<li>Made it so Copy Icon can only be used on people within view</li>
<li>Fixed a bug with Oozaru revert</li>
<li>Made the Guide open computer browser due to compatibility issues with Dream Seeker browser</li>
<li>Brought back Language tab!</li>
<li>Made it so Toggling Status Overlay will also toggle the badges on your screen for Lethal/Gloves/Injure/Invis/Leech</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.70 (Save 4 Wipe) - 8/17/2018</b><br>
<li> Made racial mod adjustments for better balance</li>
<li> Added BP increase to Expand, better BP buff for Makyos</li>
<li> Adjusted body size benefits and detriments</li>
<li> Made Transporter Watches only work on the same Z plane</li>
<li> Increased cost to Upgrade Teleporter Pads</li>
<li> Added a Tech Level requirement to set the frequency for Transporter Watch</li>
<li> Changed various tech/magic level requirements</li>
<li> Halved the code that makes Forcefields stronger as the Years go by</li>
<li> Lowered the amount of Magic/Int EXP gained from RPPoints by about a quarter</li>
<li> Added Demigod as a creatable race again</li>
<li> Created an Android Build Module for usage by the Android Mainframe.  This will allow the Android Mainframe rank to build Android Chassis without tech level</li>
<li> Added a Requirement to Super-Perfect Form to need Perfect Form to unlock</li>
<li> SSj2 and up now will use a buff slot.  Also, fixed an issue where reverting from SSGSS was not removing Buff Slot</li>
<li> Increased Low-Class and Elite Saiyan anger</li>
<li> Status tab Regen/Recov will only display the multiplier now</li>
<li> Third Eye will take a Buff Slot now, Pre FBM and FBM </li>
<li> Icon changes and effects added for SSB</li>
<li> Created a Gains Tab for Leads and Owners</li>
<li> Gave more Soft Cap and Hard Cap limit controls to Leads and Owners</li>
<li> Added a verb to force change in game Month for Owners </li>
<li> Wish Power adjustments and additions for the Dragonballs</li>
<li> Adjusted and Fixed Android Ship and Ardent spawning during server initialization</li>
<li> Buffs to Oozaru </li>
<li> Very minimal adjustments to Ki Damage ... Also added a Debug tool to adjust world ki damage in game</li>
<li> Gave Vegeta Teacher "Megaton Throw" as an additional skill</li>
<li> Fixed drop down menus in top left for Contacts and Sense</li>
<li> Fixed an issue where Makyo Expand was giving infinites amount of powah</li>
<li> Created similar tracking of the Android Ship for the Ardent, as well as world spawning for the Ardent</li>
<li> Added additional Dragonball wishes that can be made without calling an Admin.  There is also an "Admin Wish" option if you want to try for something else.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.69b (A-a-a-a-a-a-another one) - 8/03/2018</b><br>
<li>Fixed an issue with ship creation</li>
<li>May have actually fixed SSj drain this time?<li>
<li>FBM TE will now take a buff slot</li>
<li>Lowered drain on Blast a tad</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.69a (The Cool(er) Update) - 8/03/2018</b><br>
<li>Lowered SSj drain a bit more</li>
<li>Added a recovery nerf while using Send Energy followed by a ongoing temporary nerf after disabling Send Energy </li>
<li>Made SSj not take up a Buff Slot, this is a trial to see how it can/will be taken advantage of.  But as of yet, Saiyans have nothing really going for them until SSGSS, and this might give them that little bit of an edge.</li>
<li>Made adjustments to Third Eye, increasing the buff slightly in FBM, and giving them an increased recovery if in FBM.  If you are pre-FBM, then Third Eye will not use a Buff Slot</li>
<li>Made it so Admin Reset Stat Mults is as useful as the client side Reset Stat Mults</li>
<li>Ships and Pods can no longer be made in the Afterlife.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.69 (The Cool Update) - 7/30/2018</b><br>
<li>Changes to ssj and bojack drain. (About 30% less drain)</li>
<li>Fixes on a few skills, such as sword stab.</li>
<li>Pressure Punch cooldown increased.</li>
<li>Optimizations to some other stat tabs and saving procs.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.68abc123 (It puts the lotion on the skin...(Get it, because Scan/Sense is smoother now! GET IT?!) - 7/29/2018</b><br>
<li>Scan/Sense window officially works 99%, a very SPECIAL THANK YOU goes out to Carlos, that man is a boss.</li>
<li>Added a Scan Area toggle button (on/off) at the top of the screen near Magic</li>
<li>Optimizations to Log files</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.68a (HELLO?! HOUSE KEEPING!) - 7/28/2018</b><br>
<li>Fixed the Skill Sheet that I broke</li>
<li>Made it so the default tab when using Sense Area is based on whether or not you are wearing a Scanner / Magic Scanner or not.</li>
<li>Made a verb for Owners called "Lock Server" that will set the server to a rebooting state in order to prevent any grabs and new items from being created.  This is prevent loss of items.</li>
<li>Can no longer build on space tiles.  This was done because people were launching into peoples bases in space. There are also moons to build bases on!</li>
<li>Removed ability to change obj icon for Doors and Roofs</li>
<li>Updated default Guide, Rules, Story, and Login Notes links</li>
<li>Removed the ability to cloak all ships due to sheer size and logic.  This ability was also being heavily abused.  If you cloak your ship, please cease doing it, and remove your cloaking module.</li>
<li>Made adjustments to SSj Drain and Bojack Drain ... (Remember, that this drain is designed to heavily increase if combined with other buffs such as Focus ... Especially if unmastered).</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.68 (It was the lag, bro! --Chewyy fixed this) - 7/27/2018</b><br>
<li>Relocated Sense/Scan/Radar/Security into a Window.  This is accessible from the "Scan Area" verb under Skills Tab (Grab the small black line at the top to move it around your screen)
<li>Added a tab toggle system for debugging</li>
<li>Added a % difference to the Target tab when wearing a scouter</li>
<li>Removed Activities verb and replaced it with the old Activities tab </li>
<li>Fixed Contacts window, it -should- display all contacts and the Refresh button will work (Still working on having Familiarity appear)</li>
<li>Additional information added to Server Information for Admins</li>
<li>Adjustments to Stat Lag</li>
<li>Chewyy effectively learned to "code" to troubleshoot and resolve, thanks to Fenoopy and Jetnissan for the assistance !</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.67 (Fall of the Republic) - 7/24/2018</b><br>
<li>Majin flat addition to regen lowered to 0.15, from 0.5.</li>
<li>Several actions of both the ownership and admin team have lead to a state of the game that is unacceptable and entirely different from what RT stands for.  The game is currently a toxic pit full of witch hunts and grimery, that will no longer be the case.  A lax attitude and absence from the owners created a power vaccuum that bred an undesirable mentality amongst both the playerbase and the admin team.  We will no longer play absent or sit idle while bad decisions are being made that will affect our game and our players.  We allowed too much of a democracy to rule in the admin "circle" and this lead to a team that strayed from the vision we have in mind.  While we understand democracy is a good thing, we are enforcing a 'martial law' of sorts for the forseeable future.  Chewyy and Ryu hold ultimate judgement over any and all rulings, and their decisions carry the same weight as a written rule.  One thing I want to make entirely clear to everyone, is that we hold responsiblity to the playerbase, and the admin team is an extension of ourselves that is meant to support the playerbase and serve them, not fear monger and selectively austracize players.  We ask all of you, as fellow players and die-hard fans of DB RP, to turn the cheek one last time as we move forward stronger, more experienced and as invigorated as ever. ~Ryu & Chewyy (P.S. We increased gains.)</li>
<li>Removed Self Check Log.
<li>Part 1 of IP hiding/scrambling code.</li>
<li>Ban list corrected and cleansed.</li>
<li>Admin list corrected and cleansed.</li>
<li>Ryu corrected and fully restored.</li>
<li>Faith in RT, restored.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.66 (Mega Throw!) - 7/09/2018</b><br>
<li>Willpower reduction is now reduced when both Lethal and Injury on.</li>
<li>Willpower regeneration increased.</li>
<li>Megaton Throw damage increased from 1.8x to 2.5x.</li>
<li>Oozaru BP mult reduced to 3x from 3.5x. Oozaru will now take 3 buff slots and force revert when entering.</li>
<li>Players now have the ability to check their own logs.</li>
<li>High Tension may now be used with Power Armor. High Tension reduced to 40% Strength, from 50% and Endurance reduced to 30% from 40%.</li>
<li>Augmented Master/Augmented Power: You will no longer generate any after images while using these skills.</li>
<li>Familiarity req for Mating increased back to 10.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.65 (Kung Fu: Enter the Kung Fu) - 7/04/2018</b><br>
<li>Shunkan Ido: 5 minute cooldown added, now requires atleast 20% Energy.</li>
<li>Slowed speed gains.</li>
<li>Chance to block reduced. (50% default chance to block with 1:1 stats, used to be 70%)</li>
<li>Armor's chance to block changed to 40% default, but it now scales based on Off/Def/Spd. (Used to be static depending on move used from 30-50%)</li>
<li>Minor optimizations to combat sounds.</li>
<li>Admin: Memory/Mind system reworked into an admin journal system to keep track of players/characters more intimately. (This will be used to both enforce rules and reccomend better rewards for active players that are contributing heavily to the community.)</li>
<li>Second Wind is now tiered to be 35%, 40%, 45%, and 50% instead of 20, 35, 50.</li>
<li>Augmented Master and Augmented Power now both take up a buff slot.</li>
<li>You may now master a stance using RPP and then further customize it yourself, by refunding up to 2 points, and then teach others in the ways of Kung Fu.</li>
<li>Injured eyes now reduce accuracy/evasion by 20%.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.64A (I Got Three Eyes) - 7/02/2018</b><br>
<li>Third Eye Buffed.</li>
<li>Fixed an issue with bypassing Death Regen.</li>
<li>Changes to client side FPS and movement animation type.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.64 (These Rules Were Made For Rulin') - 7/02/2018</b><br>
<li>Power Control drain reduced.</li>
<li>Half-Demons (Demon dominant halfies) now get the full demon boost from Majin.</li>
<li>Brought back the character into box.</li>
<li>Recyclers are no longer grabbable.</li>
<li>Kaioken now drains 10% more HP per tick and reduces natural regeneration by 20% instead of 10% per tick.</li>
<li>Health to BP ratio now displays properly.</li>
<li>Energy to BP ratio now displays properly.</li>
<li>Admin: Cleaned up asay, ahelps and etc to display in General and Help windows.</li>
<li>Rules: Combat Rules altered! (See announcements for further details.)</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.63 (Roleplay Tenkaichi: Ki Strikes Back) - 7/01/2018</b><br>
<li>Telepathy responses work both ways now.</li>
<li>Limit Breaker damage reduced by 10% per tick.</li>
<li>BP loss from Health levels was reduced.</li>
<li>Absorb fades slower now, by 10% per month instead of 30%.</li>
<li>Expand BP bonus reduced to ~20% at level 4. (~+77% for Makyo)</li>
<li>Ki Blade: (30% Base Attack damage with 80% Force damage versus 50% Endurance and 50% Resistance.)</li>
<li>All 'blast' typed projectiles had their base chance to hit increased from 17.5% to 30%</li>
<li>Charge's charge time reduced by 10%.</li>
<li>Bug Fix: Regen tanks will now heal limbs even if you are not damaged.</li>
<li>Bug Fix: You can now change the range of Gravity that is on the ground.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.62a (Numbers Are For Real Updates) - 6/27/2018</b><br>
<li>Admin: Right clicking on reward objects will give the Pull Logs option.</li>
<li>Ocean Planet fixed.</li>
<li>Zanzoken Combo damage increased slightly.</li>
<li>Sword Changes: BP Bonus now capped to 100% of current BP. Accuracy reduced by 35% instead of 32%.</li>
<li>Speed now gives 15% towards Defense instead of 14%.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.62 (Look At That Guy!) - 6/23/2018</b><br>
<li>Spirit Doll incline now 6</li>
<li>Expand req for Saiyans reduced to 3k strength.</li>
<li>Oni Giant Mode req reduced to 5k Base and 1k End/Res.</li>
<li>Builder variable will not only save your ckey. This will result in less bugs with upgrading.</li>
<li>Grabs are now always logged to everyone in view. (Previously only logged to the grabber and grabbee)</li>
<li>Base KO time reduced to 80-160 seconds for first KO on 1x regen. Then it would be 100-200 seconds and eventually cap at 160-320 seconds after 3+ KOs. (Minimum KO time of 30 seconds.)</li>
<li>You should no longer reroll into the same activity.</li>
<li>Int soft cap should have a smoother decrease as you exceed the cap.</li>
<li>Fly energy requirement reduced to 2k.</li>
<li>Added a "point to" verb.</li>
<li>Reduced charge time back to previous levels, left projetile speed increased.</li>
<li>Force Field drain corrected and rebalanced.</li>
<li>Changed regeneration multipler from 0.2 to 0.25.</li>
<li>Gun damage multiplier reduced from 8% to 5%.</li>
<li>Speed gains increased through sparring and self train. Zanzoken now grants a small amount of speed.</li>
<li>Blast damage mult increased from 1.9x to 2x</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.61 (The Fifth Element) - 6/21/2018</b><br>
<li>Now everyone may customize their expand icon.</li>
<li>Activities now display how much of a given reward you have received.</li>
<li>All forms of gaining mana while meditating now properly display in combat log.</li>
<li>Makyos now have an unlockable 5th level of expand that they unlock at half their FBM req. (1'000'000 base BP) (LSSj also has this.)</li>
<li>Charge's charge time has been increased, the projectile speed has also been increased.</li>
<li>Soft capping on Int gains dramatically increased. This will stall those well above the cap while still allowing new players/those behind to catch up. This will make RP points the main way of getting "high" int/magic.</li>
<li>Live Update: You will now auto resume meditation, training and digging after an update.</li>
<li>Tech/Magic catch up gains adjusted and cleaned up. (Some issues resolved)</li>
<li>Upgrade gravity display issues resolved.</li>
<li>Willpower system added. Willpower affects your maximum HP and is lowered on KO, but only if they have lethal on. This will regen over time and increases with Regeneration. (May be removed.)</li>
<li>Guns buffed.</li>
<li>Activity hotfix.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.60b (One Letter Is Never Enough) - 6/20/2018</b><br>
<li>Restored status display in bottom right but disabled it on the HUD square temporarily.</li>
<li>Special aliens, like Herans, are now idetified by race instead of being different classes of alien.</li>
<li>Admin: Check Logs now creates a pop up browser instead of using the default.</li>
<li>Oozaru buffed. (350% BP, 200% Str, 200% End, 70% Spd, 70% Off, 50% Def)</li>
<li>Base chance to hit increased. (Attack verb now has an additional 5% chance to hit, scaled. Speed now contributes 18% towards Offense, from 17, and 14% to Defense, from 15.)</li>
<li>Stat Cap should no longer change on reboot/update.</li>
<li>Added X/Y to custom Makyo expand icon.</li>
<li>Changes to the frequency stats are checked for cap and displayed. (This will help to reduce lag, but will result in a 0.5 second delay upon gaining stats and actually seeing them. This is a downside, but the alternative is more lag.)</li>
<li>Saiyan gravity mastery retroactively brought up to 15x.</li>


<p>
<br>
<b>Roleplay Tenkaichi version 0.60a (Not Big Enough For a Full Number) - 6/18/2018</b><br>
<li>Boosted speed gains by about 30%.</li>
<li>Say, Yell and Emote distance increased.</li>
<li>Added 'Make Weights' a version of materialization for techies until I make a system for creating weights.</li>
<li>Several lag sources addressed.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.60 (But I Want To Cap All My Stats) - 6/17/2018</b><br>
<li>Upgrade stuff in your inventory (Some things may have been missed, please report those.)</li>
<li>Warning message about upgrading hand drills below level 25.</li>
<li>Spirit Ball buffs.</li>
<li>P_BagG altered for training methods. (It is basically a gain mult. Bags/Goo are 1x, Logs are 1.8x, Sims are 2x, Splits 2.5x and real players 3x)</li>
<li>Additional checks to prevent sword/armor stacking.</li>
<li>Some log check methods fixed.</li>
<li>Alien Transformation requirements normalized.</li>
<li>Auto AFK timer reduced.</li>
<li>Sword Skill coodown fixed.</li>
<li>Third Eye requirements normalized.</li>
<li>Stat system altered to allow all 7 stats to cap.</li>
<li>Int soft cap gain reduction increased. (Means the soft cap is increasingly harder the futher you go)</li>
<li>Can now respond to telepathies directly.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.59 (I Don't Want To Buy the World a Pizza) - 6/15/2018</b><br>
<li>WFF and Burning Shot combo damage reduced.</li>
<li>Namekian Fusion is now a rank move and is only teachable by NE/Namekian Teacher.</li>
<li>Half Saiyans now spawn with tails instead of randomly growing one before being 16 years old.</li>
<li>Admin: Standardized all passwords to use the same "Password" variable regardless of item type.</li>
<li>Admin: Intelligence Mod variable changed from Add to "Int_Mod"</li>
<li>Admin: XYZTeleport will now save a mob's XYZ for unsummon.</li>
<li>Admin: Admins may now select RPPoints tiers for rewards.</li>
<li>Admin: Variable clean up.</li>
<li>Super Mystic and Super Majin icons are now customizable.</li>
<li>Custom Oozaru icons.</li>
<li>Cleaned up Changeling transformation. Fixed King Kold golden form.</li>
<li>Swimming Mastery is now displayed to the player.</li>
<li>You now only lose 30% Absorb BP each month.</li>
<li>Added a Birthday system.</li>
<li>Added a live-patch system. Still in infancy.</li>
<li>Knockback Resistance stat added. Larges get 1 default, other buffs and etc can grant more. (This is a flat reduction to total KB from everything other than blasts, where it is calculated into a % chance to resist entirely. This also gives you a chance to reduce the total time spent stunned.)</li>
<li>Dragon Ball wishing is now admin only due to the difficulty of effectively balancing it on static math.
<li>2 new planets! Dark Planet and Ocean!</li>
<li>New planet saving system.</li>
<li>Extensive bug fixing and code optimization.</li>
<li>Injuries now use stat mults instead of affecting mods.</li>
<li>FBM affects on stats now use mults instead of mods.</li>
<li>Reworked Androids to require less total upgrades to be good, but are now capped at 25 upgrades.</li>
<li>Shield is back to a 20% reduction from blasts.</li>
<li>Target tab now displays BP if you are wearing a scouter.</li>
<li>Major: All Races base stats rebalanced and overhauled.</li>
<li>Force fields now only have an 80% chance to ignore damage instead of 100%.</li>
<li>Androids no longer mutate.</li>
<li>Enchanting an item will now increase its value for the recycler. (Activity  rewards not affected.)</li>
<li>Offspring now automatically have a baby icon. (Except for Changelings)</li>
<li>Zanzoken drain now increases based on how frequently you use it. (Works similarly to Kassadin's ultimate from League of Legends)</li>
<li>Spirit Dolls now function like magical androids. They are created at 40 magic skill and are loyal to their creator just like an android would be.</li>
<li>All Tuffles now get Super Tuffle at 50 Int and 50'000 Base.</li>
<li>Hellspawn Saiyans (Half Saiyans with Demon parents) can not use SSj4.</li>
<li>Lots of transformation changes and overhauls.</li>
<li>Namekian Fusion is now reworked to grant a permanent +10% BP and stacks up to twice for +20% BP. (Gives 20% of the person's energy)
<li>Added a stance system. (Certain Ranks are granted custom stance/martial arts they can teach and develop throughout the wipe. CUSTOMIZING THESE ARE PERMANENT! So be careful when you spend those points. Once taught the skill, you can spend further RP Points to improve it further if you are the creator or spent RP Points to train it if you are a student. The three levels are Novice, Intermediate and Master. Masters are the creator of the stance, intermediate is someone that has been taught and then mastered the martial art, and novice loses 10% damage/accuracy and attacks cost 2x energy)</li>
<li>King Kold and Cooler are now rares.</li>
<li>Hand Drills can now be upgraded.</li>
<li>Blast knockback chance increased to 20% but now increases drain.</li>
<li>A portion of your death regen is now consumed on death. (Goes down by 0.2 per death. Admins can restore the Regenerate variable incase of accidental death.)</li>
<li>Stat Cap system altered such that you will now only be able to cap 6 out of your 8 stats fully. This will allow a good medium that should allow some of the freedom of "building" your character again while still keeping balance in line.</li>
<li>Androids no longer have body sizes.</li>
<li>Aliens now get 70 points.</li>
<li>Int/Magic levels no longer affect stat cap/li>
<li>Fixes for edges and etc when building over them.</li>
<li>Fixes for the new stat system and various admin commands.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.58 (Deus Ex Machina: Whats a God to a Robot?) - 6/04/2018</b><br>
<li>Log/Dummy gains increased from 1.5x to 1.8x</li>
<li>Lowered MF drain.</li>
<li>Androids resist God Ki.</li>
<li>SSB/SSj3 drains reduced.</li>
<li>Halfie SSG multiplier increased to 5x max.</li>
<li>Self Destruct and Super Explosive Wave will no longer trigger if the attacker is KOd.</li>
<li>Wall of Flame has a faster cast.</li>
<li>Shield damage reduction reduced to 10% for blasts. (Resistance increase remains the same.)</li>
<li>Mystic now reduces Anger by 30% for non Kaios.</li>
<li>Increased Pressure Punch cooldown. Drain increased.</li>
<li>Assess sheet changes.</li>
<li>Post Humanism now reduced recovery by 30% instead of 20%.</li>
<li>Split Forms will not have their creator's God Ki.</li>
<li>Make Amulet now has a 5 year cooldown.</li>
<li>Various Rank specific skills are now only teachable by the respective ranks.</li>
<li>Demigod rework: Kaios can now mate again! Whenever a Kaio mates with anything other than a Kaio, it creates a Demigod. Demigods are now only creatable in this manner, like Half-Saiyans.</li>
<li>You may now power up twice to enter SSGSS while using God Ki.</li>
<li>Gravity gain rate tweaked a bit higher.</li>
<li>SSGSS and SSj4 hair now customizable.</li>
<li>Max ships increased.</li>
<li>Kaioken drain reduced by about 10% and BP increased by about 10%.</li>
<li>Added a new skill called Kiai that is designed to knockback an opponent with low damage.</li>
<li>New rock throw skill. Basically a melee blast with a CD.</li>
<li>Excess verb clean up.</li>
<li>Lots of character customization and options are now under the Options drop down menu.</li>
<li>Mystic now reduces the drain of Alien transformations.  Alien transformation no longer drains after FBM.</li>
<li>Bugfixes.</li>


<p>
<br>
<b>Roleplay Tenkaichi version 0.57 (Tournament Edition) - 6/03/2018</b><br>
<li>Made it so only your 'good' contacts can grab you while AFK.</li>
<li>Being in Oozaru will bypass the body % requirement for attacking.</li>
<li>Increased UI drain.</li>
<li>Admins will not receive a special alert when a rank makes/logs in with an alt.</li>
<li>Megaton Throw cooldown increased.</li>
<li>FBM now requires atleast 90% body.</li>
<li>Some new base icons added for Aliens, Kaios and Androids.</li>
<li>Added a new Help Say and Help tab for chat. You can be granted trusted member status if you are a pillar of the community but you can also have help say revoked.</li>
<li>Admins default with Rank Chat.</li>
<li>An ascended Kaio will now power up slightly faster than normal.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.56 (Save 4 Wipe) - 6/02/2018</b><br>
<li>Activities will no longer reward energy if you are at the cap.</li>
<li>Bugfixes for some skills.</li>
<li>Beams will drain less force field battery.</li>
<li>You will now auto gain God Ki if your spar counter is 3500 or higher.</li>
<li>SSB total BP mult reduced to 6x.</li>
<li>Additional admin verbs.</li>
<li>Grvity Mastery gains for sparring increased by 33%.</li>
<li>Offspring may no longer fuse into their parents.</li>
<li>Trying to attack someone that is attacking or blasting will grant the same benefit as attacking from behind.</li>
<li>Issue with certain races "persisting" through death fixed.</li>


<p>
<br>
<b>Roleplay Tenkaichi version 0.55 (XCOM: Enemy Bugs) - 5/30/2018</b><br>
<li>New RP Power Add variable introduced.</li>
<li>Observe fix.</li>
<li>Space Pirates now use SSG hair instead of SSj.</li>
<li>Added options to customize SSG and SSGSS hairs.</li>
<li>Force requirements for Blast/Charge/Beam increased to 500, 1000, 2000.</li>
<li>Save Age requirement added for absorb.</li>
<li>Majin reworked to now give +40% BP, +20% Off, +50% Regen and increase regen ticks by a flat 0.5. (This is roughly equal to 2.2 extra Regen)</li>
<li>Halfie SSG multiplier corrected. (This is not a nerf, it was an unintended consequence of adding SSjmult to the equation.)</li>
<li>Changed formatting on new Cardinal buffs.</li>
<li>Chernobog Pantheon issue fixed.</li>
<li>SGKA damage mult changed to 11x from 15x.</li>
<li>Golden Form Changie fix.</li>
<li>Shield now reduces blast based damage by 25%. Shield reflection chance reduced.</li>
<li>Elixir of Life now grants 1.5 years of Decline for 1500 energy.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.54a (Fuck Chewyy) - 5/27/2018</b><br>
<li>Slowed God Ki training. (Everyone with God Ki had their mastery reduced to 1/3 as that is the current speed compared to the old system.)</li>
<li>Vampire fix.</li>
<li>Unlisted fixes.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.54 (Roleplay Tenkaichi has updated its privacy policy) - 5/26/2018</b><br>
<li>SSj4 no longer grants off/def.</li>
<li>Vampires and characters with No Loss now scale through 100%-75% BP based on health instead of 100-90%.</li>
<li>Regenerators overhealing fixed.</li>
<li>New Kaio Buffs maybe fixed, actually?</li>
<li>You may now leech God Ki from anyone that has 1.5 or more natural God Ki.</li>
<li>Altered stats on Mystic and Super Majin.</li>
<li>SSG buffed again to now feature an add.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.53 (I nerfed everyone, equally.) - 5/25/2018</b><br>
<li>SSG buffed to use SSj Multiplier and current God Ki. (Starts at a minimum of 3x)</li>
<li>Anger mult issue fixed.</li>
<li>Decline no longer prevents transformations.</li>
<li>Sokidan damage mult reduced to 50x from 55x and CD increased slightly due to its now near-instant fire at full mastery.</li>
<li>HBTC fixes.</li>
<li>Super Bojack fixed.</li>
<li>Updated SSG aura.</li>
<li>Post Humanism now grants 10% Strength and Force instead of 20%. It now grants 80% BP instead of 60%, and it reduces recovery by 20% instead of 30%. Int requirement removed. Base requirement increased. Other requirements added. (This is not retroactive.)</li>
<li>Third Eye no longer gives 10% Speed.</li>
<li>Seperate variables for Leeching and Training God Ki.</li>
<li>Slowed decline process by half or double... or whichever.... the number 0.5 was involved.</li>
<li>Capped Max Ki at 300000 x KiMod for testing/balancing purposes. If we later remove this and you previously had above that, it will be restored. (This only affects current stat, not base.)</li>
<li>Majin Absorb cleaned up some more.</li>
<li>Limit Breaker is now more damaging to your limbs.</li>
<li>SGKA damage mult boosted to 15x from 10x.</li>
<li>Magic Force is now teachable and leechable. Energy mod no longer reduces drain.</li>
<li>SSj4 Mult reduced back to 4x from 4.5x.</li>
<li>CD added to teaching languages.</li>
<li>Focus reworked. (No longer gives Force. Gives 30% BP, Speed and Regen. Speed and Regen buffed from 20%.)</li>
<li>Focus drain was lower than intended. (Will be more draining now)</li>
<li>Nerfed shield damage reduction and reflection rate.</li>
<li>You can attack flying people again.</li>
<li>Fixed Asexual custom aliens.</li>
<li>Added a new icon for the Post Human buff after it has consumed your humanity. (Thanks Sokkxx)</li>
<li>SSj4 req reduced from 21mil to around 17mil.</li>
<li>Elite SSj1 mult buffed to 1.9x, SSj2 mult reduced to 2.1x.</li>
<li>Halfie SSj2 mult reduced to 2.2x, add increased to 5mil.</li>
<li>Larges buffed to only reduced speed by 20% instead of 30%. (Not retro)</li>
<li>New Cardinal buffs fixed.</li>
<li>Buffed Super Majin/Mystic to scale with God Ki.</li>
<li>Majin boosted for demons to 1.7x bp from 1.6x.</li>


<p>
<br>
<b>Roleplay Tenkaichi version 0.52b (Who Let The Changelings Out?) - 5/24/2018</b><br>
<li>Mating now will only give the child 90-105% of the parents mods instead of 90-110%. This will make Offspring slightly less OP and not a "guaranteed" better than 1st gen. (Though most will still be a bit better)</li>
<li>Changeling is no longer Rare locked.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.52 (I THINK NAUT GOT TOO STRONG AND BROKE SERVER) - 5/23/2018</b><br>
<li>Increased benefit from adding res/mana to walls/doors.</li>
<li>SSG/SSB Hair fixes.</li>
<li>PC drain modifier increased to 0.6 from 0.5. (This is likely the final change to PC for the time being.)</li>
<li>Admins may now view/edit a player's contacts.</li>
<li>Gravity mastery rate formula altered to lead to faster grav training.</li>
<li>Fixed issues with Sokidan and Homing Finisher causing your attacking var to get stuck on 3, aka blasting.</li>
<li>Half-Saiyans can no longer get Third Eye from their parents. All other half-humans still can.</li>
<li>Spirit Dolls are now always sterile. (They will eventually be the androids of magic.)</li>
<li>Fists of Fury recovery drain reduced slightly.</li>
<li>Cyberize BP formula slightly increased.</li>
<li>Elite SSj1 mult boosted to 1.9x. (Lowbies get 1.8x)</li>
<li>Powering Up will now create less rising rock animations.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.51 (NOW WATCH AS I SURPASS MY LIMITS, BUT NOT AS FAR AS LAST TIME) - 5/20/2018</b><br>
<li>Alien trans and Golden Changie drain reduced.</li>
<li>Cost for refueling and upgrading field limit on gravity machines reduced.</li>
<li>Power Control drains Androids again.</li>
<li>Super Majin buffed to 2x Regen from 1.5x</li>
<li>Super Bojack boosted again to 3.4</li>
<li>Wall of Flame and Pressure Punch CD increased. (Pressure Punch stun time reduced)</li>
<li>Offspring now start with 50-70% of their parents Base/Energy instead of 90-110%.</li>
<li>Limit Breaker BP bonus reduced to 60% from 80%, limb damage increased.</li>
<li>You can now view ticks of digging/mana gain in the Combat tab.</li>
<li>Bushido now only reduces Ki and Endurance by 10%.</li>
<li>SSj2 drain reduced.</li>
<li>Recovery ticks while using power up reduced.</li>
<li>Magic Force is now only +60% for Spirit Dolls, down from +80%.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.50 (WOAH~! We're Half Way There) - 5/17/2018</b><br>
<li>Namekian FBM adjusted for SNj being non perm.</li>
<li>Cyberize BP formula boosted. (Close to final)</li>
<li>SSj3 Drain reduced slightly.</li>
<li>Crystal Ball no longer shows speech when observing.</li>
<li>SSj2 drain reduced for LSSj/Elites.</li>
<li>Human Int reduced to 3.5 from 4, Spirit Doll Int reduced to 3 from 3.5.</li>
<li>Various errors cleaned up.</li>
<li>Added a handful of ways to trigger SSj4 naturally. (This is to reduce metagaming of emitters and to give viable IC reasons to pursue the trans. False Moon when the usr is ascended and has ssj2 or higher can trigger Golden Oozaru in those strong enough.)</li>
<li>SSj4 Now increases Off/Def by 20%. (Also boosted BPMult to 4.5 from 4)</li>
<li>Fixed a typo causing issues with SSj Hair Customization.</li>
<li>Simulator cost reduced and BP normalized.</li>
<li>Spellbook upgrade fixes. (Now 5x as effective!)</li>
<li>BWM/Makyo BP are now affected by BP Mult. (They have been nerfed slightly to make up for the change.)</li>
<li>HBTC Buffs! (New variable called HBTCPower that works similar to BWM/Makyo.)</li>
<li>Motion Detectors now scan slower.</li>
<li>Security Camera/Communicator now will not work through the AL/LR.</li>
<li>Antivirus removed, Poison disabled.</li>
<li>Fixed an issue with Bushido and Ki Blade.</li>
<li>Bushido no longer reduces recovery, but now only gives 20% Offense, from 30%.</li>
<li>Mate cooldown increased to 1.5 years. (Now have a cap of 4 maximum children)</li>
<li>Half-Makyojin now get the Makyo Star boost. (60% compared to a full makyo's 100%)</li>
<li>Super Bojack mult increased to 3 from 2.8.</li>
<li>SSj3 now uses SSj2Add x 1.5 instead of SSjAdd.</li>
<li>Self Train on Off/Def will now follow your focus for Skills.</li>
<li>Character creation cleaned up further to prepare for race overhaul.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.49 (How Come Your Mom Lets You Have Three Buffs?) - 5/14/2018</b><br>

<li>Lowered Tuffle FBM (Anyone above 6x will be set to 6x BPMod)</li>
<li>Fixed an issue with Zenkai Power incorrectly capping.</li>
<li>Human Buff, Post Humanism, nerfed. (50% BP instead of 60%, 20% Speed instead of 40%, now reduces Recovery by 20%.)</li>
<li>Physics Simulation nerfed. (2x BP instead of 2.5x, 45 second duration instead of 60, 8 minute CD instead of 5.)</li>
<li>SSj3 can be attained without admin influence. If you meet the Base/BP Req you will trans.</li>
<li>SSj3 requirement reduced to 10-15 million. (Only Base BP, Anger and the Gravity Boost affect this.)</li>
<li>Cyberize BP formula reduced in preparations to remove the server limit. (It may be too low, we will keep adjusting it.)</li>
<li>Focus BP buff reduced to 30% from 40%.</li>
<li>Pressure Punch and Wall of Flame stun time reduced.</li>
<li>3 New Cardinal Buffs added. (God Speed, High Tension and Channel)</li>
<li>Super Perfect Form nerfed to 60% BP from 80% and 10% Off/Def from 20%.</li>
<li>Fixed a bug with Adamantite Skeleton knocking out the user instead of the target.</li>
<li>Mystic now only buffs Speed by 40% from 50%.</li>
<li>SSj3 drain increased.</li>
<li>Range for HP/Energy overlay to show up reduced to 8 from 15.</li>
<li>Changed the way the game handles PC drain to alleviate lag. (It will also now drain more frequently, but reduced the drain.)</li>
<li>25% Chance for blast to knock back instead of 20%.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.48 (The One Were Ryu Didn't Have Time To Make A Funny Name) - 5/14/2018</b><br>
<li>Offspring variance range reduced to 95%-105%</li>
<li>Much needed verb to auto master all skills for ECs/etc.</li>
<li>Reincarnate no longer requires the target to be dead.</li>
<li>SSJ2-3 drains reduced again.</li>
<li>Fixed an issue with Shunkan Ido piercing the veil to the AL unintentionally.</li>
<li>BP Multiplier is now display to players. (This is not your BPMod.)</li>
<li>All Low Classes will now get SSj3 at some point. (This is retroactive.)</li>
<li>Mega Burst damage mult increase to 15x from a range of 8-16x.</li>
<li>Fixed a bug with Pantheon.</li>
<li>Dash Attack accuracy Multiplier reduced to 32x from 35x.</li>
<li>Improvements to Character Creation integrity.</li>
<li>Super Namekian is now properly in the Skills tab.</li>
<li>SSj2 Mult buffed to 2x for Low Class and 2.3x for Elite/Halfies.</li>
<li>No longer able to grab mobs in TFR.</li>
<li>SNj will now properly revert on reset stat multipliers.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.47 (Eating Pineapple Makes Your Ki Taste Good) - 5/13/2018</b><br>
<li>Physics Simulation BP bonus nerfed to 2.5x from 6x.</li>
<li>Buffed Majins.</li>
<li>Shield now only reduces beam damage by 40% instead of 60%.</li>
<li>All beams now deal 20% more damage. (Calculated on hit and will not display in beam info)</li>
<li>Various decline ages reduced (Not retroactive), Humans buffed to 35 from 30(Retroactive). </li>
<li>Androids now no longer drain to sustain power control. (They still drain to actively power up and will still suffer the reduced recovery ticks from PC, though.)</li>
<li>Fixed a bug that allowed you to Expand with Power Armor.</li>
<li>Elixir of Respec no longer uses decline age.</li>
<li>Make Fruit will now use a month cool down timer instead of a tick based counter. (9 Month Cooldown)</li>
<li>Fruit now work off of the creators EXP/Gain Mult instead of Max Ki. Fruit Ki Gain reduced to 5x mult from 15x, Fruit BP Gain mult changed to 2x from 3x.)</li>
<li>Majinize/Mystify now have a 2 year CD. (Up from 1 year. May increase this to 3.)</li>
<li>Stat Overlay now defaults off to reduce lag. (Toggle Status Overlays to turn KO/Anger overlays back on.) </li>
<li>Steroids will now wear off when you have <10% of your Base BP as Roid Power.</li>
<li>Couple changes to the Stat loop to try to cut down on lag.</li>
<li>SSj1 Mult buffed to 1.8x from 1.7x.</li>
<li>SSj2-3 Drain reduced. SSGSS drain increased.</li>
<li>Zeus and Horus Pantheons buffed.</li>
<li>Demigod average FBM boosted to 7x from 6.75x (This is retroactive)</li>
<li>You may now use the manual Stat Focus verb to choose Skills for train, which will give you a small amount of Off/Def instead of Str/End.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.46 (Perfectly Balanced, As All Things Should Be) - 5/12/2018</b><br>
<li>Actually found/fixed charge/KB bug.</li>
<li>Various races that should not have reproductive parts no longer get them. (Not retroactive.)</li>
<li>Bojack SSj Add increased. A little after FBM, Space Pirate's Bojack SSj Mult will increase from 2.2 to 2.8, called Super Bojack.</li>
<li>Magic/Int stat weight reduced. (Was 80xLevel/IntMod, is now 70xLevel/IntMod.)</li>
<li>Wolf Fang Fist and Dash Attack now share a CD.</li>
<li>Fixed several melee techniques that would bypass second wind.</li>
<li>Body requirement for attacking reduced to 50% from 60%. (This only affects offspring.)</li>
<li>SSj4 now has a BP Req of 2x FBM. For the average Saiyan this is 4 million base. (This change IS retroactive)</li>
<li>SSj1 leech and God Ki leech will now take longer, about 30% more time on average.</li>
<li>Fixed a bug causing one of the hidden Pantheons to not properly unlock. (For now you must use Pantheon to "check" if you have unlocked anything.)</li>
<li>Horus Pantheon buffed. (Now +30% regen instead of 20% and now +40% speed instead of +30%)</li>
<li>Fixed Halfies not getting SSj2 reqs. (This is Retroactive)</li>
<li>Fixed the oversight with rewards that caused this session to become bugged.</li>
<li>Fixed an issue with the new Human trans not properly reverting. (Everyone with it has had any lost Decline refunded.)</li>
<li>Timed buffs, i.e. Combat math, adaptive, new tuffle buff, will no longer tick down in RP mode.</li>
<li>Some additional clean up for logs.</li>
<li>Magic Force and other moves that affect your Ki Multiplier will no longer give credit for energy activities.</li>
<li>Bio-Android Regeneration lowered to 3.6 from 5. Max Anger lowered to 120 from 125. (Not retroactive)</li>
<li>Majin Absorb now copies one of the victim's mutations, up to a maximum of 7 on the Majin.</li>
<li>Telepathy is now teachable.</li>
<li>AFK players no longer show up on sense/scan. (May change this back.)</li>
<li>Blast damage mult reduced to 2x from 2.5x and knock back rate reduced to 20% down from 25%. Blast drain increased for spread (2.2 on 1x, 4.8 on 2x, 10.6 on 3x, 23.4 on 4x)</li>
<li>Homing Finisher damage mult reduced to 7x from 9x.</li>
<li>Admins will now see all narrates, even if they are not on that planet.</li>
<li>Bushido BP boost reduced to +20% from +40%.</li>
<li>Buffed UI to +70% Off/Def/Speed, from +50%.</li>
<li>Familiarity gain rate now scales with Year Speed.</li>
<li>Broken Training Equipment will not be included in the obj cleanup.</li>
<li>Offspring now save their parent's names/keys as a perm variable. (Not retroactive)</li>
<li>Custom Class Aliens now have a second, hidden ascension.</li>
<li>Kanassa now have an improved Limit Breaker when they are using God Ki.</li>
<li>Yardrat zanzoken racial improved in God Ki.</li>
<li>Dash Attack CD increased. WFF CD decreased.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.45 (I ain't no filthy stinkin' Human) - 5/11/2018</b><br>
<li>Fixed an issue with BPMod calculation for offspring of ascended people. (Children will no longer be more powerful if their parents were ascended. This is not retroactive.)</li>
<li>Fixed error in magic force drain.</li>
<li>Tuffle FBM normalized. Now 5.5x without any mutations. (This is AFTER Super Tuffle)</li>
<li>Fixed a bug with King Kold Changelings using golden form.</li>
<li>Buffed Overdrive maximum power to 70%, from 60%.</li>
<li>Buffed Module BP (The BP bonus you get from consuming an upgrade module when you have 10 or more installed) to 2.5% per module, from 2%. (Max of 20 consumed modules for +50% BP)</li>
<li>Power Up should now be slightly more effective for people with <2 Recovery. (For those with less than 2 recovery, you will power up by a minimum of 2% per tick. In order to compensate, those with 2 or more recovery will now gain anywhere from 1-1.6x their recovery as a % per tick.)</li>
<li>Power Control drain (the drain to sustain >100% power) scale changed. (Now 0-10x Recovery is 1.2x, 10-20 1.3x, 20-30 1.4x, 30-40 1.5x, and 40-50 1.6x. This is changed from a flat 1.5x)</li>
<li>Fixed some Androids being stuck under the intended upgrade cap due to BYOND's handling of decimal numbers.</li>
<li>SSj1-3 now reduces Recovery by 10% instead of 20%.</li>
<li>New Human transformation added. It should occur a little after they get FBM.</li>
<li>Aliens can once again customize their transformation icons.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.44 (Ryuman: Return of the Dank Knight) - 5/10/2018</b><br>
<li>Magic Force drain reduced. (Down to a base of 2%, from 3%, and experience can now reduced the drain by an additional 50%, up from 17%.)</li>
<li>Power Up now has a hard cap of 50 x Recovery Mod.</li>
<li>Power Up now drain scales up every 5 x Recovery Mod % instead of every 10.</li>
<li>Namekian Fusion now gives 15% of the Fusion recipients BPMod, instead of 20% of the Fusers BPMod.</li>
<li>Fusions now cap at 2 instead of 3.</li>
<li>Offspring no longer get the benefits of their parents fusions.</li>
<li>Offspring will no longer get the normal +/- 5% variance on BPMod. (They can still get BPMod mutations.)</li>
<li>SNj is now a toggle. This is not retroactive and all existing Namekians will keep the perm form without access to the new one. (It still has no drain.)</li>
<li>Kaios nerfed. (BPMod now 2.8, down from 3, and strength 1.5, down from 1.6)</li>
<li>Removing something's head will now kill it. (Sorry, Nosferatu!)</li>
<li>Kaioken now once again reduces natural regeneration ticks by 10%.</li>
<li>Fists of Fury can now be taught to other Androids.</li>
<li>Sword Force (AKA Bushido) now requires a sword to be worn and will be disabled if you remove the sword.</li>
<li>Charge/Beam freeze bug fix attempt 1.</li>
<li>Power Ranking display removed due to confusion.</li>
<li>Fixed an issue with Kaio/Demon FBM display text.</li>
<li>Fixed an issue with bolting/unbolting items.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.43 (The Smol Update Where Ryu Is Almost Back From Vacation) - 5/6/2018</b><br>
<li>Melee damage mult increased from 1-3 to 2-5.</li>
<li>SSj2 Drain reduced</li>
<li>Vampires can not mate</li>
<li>LOOC now logged in regular say log</li>
<li>Megaburst buffed (2-9 mult boosted to 8-16)</li>
<li>Potentially fixed Megaburst for diagonal use. Icon will still look wonky.</li>
<li>Requirements for Bio-Android forms reduced.</li>
<li>Wall HP nerfed. Not retroactive</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.42 (The One Where Ryu Is Still On Vacation) - 4/27/2018</b><br>
<li>Over cap reduced to cap +20%</li>
<li>Speed gains changed. (You no longer gain speed from medding. You gain less from train verb but more from sparring.)</li>
<li>Spirit Dolls BPMod boosted to 1.3 from 1.1.</li>
<li>Humans BPMod boosted to 1.4 from 1.3.</li>
<li>Fixed limb regen for offspring.</li>
<li>PC nerfs. (More drain, each drain "stage" is 20 instead of 25 x your recovery.)</li>
<li>Kaioken HP drain lowered.</li>
<li>Armor and Swords properly removed on death.</li>
<li>Armor now more consistently removed when it is broken and the desc now updates properly. (Will eventually add degredation for swords.)</li>
<li>Reworked Steroid nerfs to Recov/Regen to be more similar to the way Cyber/Absorb BP affects them.</li>
<li>Changed Steroid BP formula to not be affected by power control.</li>
<li>Androids can no longer use Steroids. (Sad I had to figure that one out on my own. Shame on you, you juicing robots you.)</li>
<li>New sixth category for rewards, Medium Low, added. (<3 Xander)</li>
<li>Lowered Skybreak's damage mult from 90x to 80x.</li>
<li>Various charge based techniques now double check for KO/etc before firing.</li>
<li>More PC Changes: You gain BP Pcnt slower now, random from 80-150% of your Recov Mod, from 150%. Drain per tick to increase BP Pcnt, powering up, reduced to a 2x mult from 2.5x mult. Drain to sustain BP Pcnt base mult decreased to 0.75x, down from .8x. The same drain for sustaining BP Pcnt now increasing culmulatively over several stages that are calculated by Z x Recov mod where Z is the threshold for each tier. (i.e. 5,10,15,20,etc)</li>
<li>Fruits buffed.</li>
<li>Removed Androids ability to do stuff Androids shouldn't be able to do, like inject stuff and eat stuff and use the woman's bathroom.</li>
<li>Replaced gravity batteries with Energizer brand so they should last longer.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.41 (The Episode Where Ryu Nerfed Babies) - 4/19/2018</b><br>
<li>Cyberization Buffs</li>
<li>Now 75% natural anger instead of 50%.</li>
<li>Now 95% natural regen/recov ticks instead of 90%.</li>
<li>Cyber BP now caps loss to BP from HP at 50% BP from 40% HP.</li>
<li>Mystic Fix. (Def was not being removed.)</li>
<li>Hacking Console fix.</li>
<li>SNj requirement lowered to 600k base on average.</li>
<li>Alien trans now counts as a buff slot.</li>
<li>Reset Stat Mults now resets buff slots too.</li>
<li>Spirit Dolls now have 3.5 int and 4.5 magic.</li>
<li>Lowered reroll CD and time between activities until I give them an overhaul.</li>
<li>Now require 30% body to attack verb. For most races this is 2-3 years old.</li>
<li>Beams' damages buffed across the board.</li>
<li>Fixed Energy enchantments.</li>
<li>Spellbooks can now be upgraded to further enhance mana gains.</li>
<li>SSj Mults rebalanced. SSj3 drain increased.</li>
<li>Spending RP Points on Magic/Int will scale with current level.</li>
<li>You may now build in space.</li>
<li>Megaburst fix involving attacking while charging. Thanks Rones.</li>
<li>PC/PU drain increased. Now more draining to sustain and to power up.</li>
<li>LB leech difficulty reduced.</li>
<li>Kaioken HP drain increased by about 20%.</li>
<li>Makyo Expand now only reduces recovery by 5% instead of 10%.</li>
<li>Spirit Dolls now get an enhanced version of Magic Force at 100% mastery.</li>
<li>Bolt/Builder bug fixed. Some code was using ckey some was using key and address. (TL;DR you should be able to unbolt things you make from here going forward.)</li>
<li>Babies can now attack with atleast 60% body instead of 77%.</li>
<li>Using a sword with Ki Blade now only grants half of the sword's normal add to BP.</li>
<li>You may now use TK/Magic TK while using ki techniques.</li>
<li>Anyone with the NoLoss variable now scales from 90%-100% BP from 1%-100% HP respectively.</li>
<li>Force regenning body parts no longer gives you heal zenkai.</li>


<p>
<br>
<b>Roleplay Tenkaichi version 0.40 (HAIL SATAN 666) - 4/17/2018</b><br>
<li>Speed hit/dodge ratio changed. Speed now contributes 18% to offense, up from 15%, and 15% to defense, down from 17%.</li>
<li>Fixed redo stats with changing body sizes.</li>
<li>Attack verb hit multiplier raised to 35 from 33.</li>
<li>Blast techniques should not flick the Blast icon state properly. Report Verb for anything that doesn't still.</li>
<li>Reduced Zenkai gain rates by about 25%. Zenkai cap reduced to 30% of your base from zenkai, down from 40%.</li>
<li>Added confirmation messages before spending RPP on Mana/Res or Magic/Int exp.</li>
<li>Regen base tick mult increased to .20 from .15.</li>
<li>Namekian Fusion now requires a 3 year old save.</li>
<li>Makyo Expand has the option to return to default icon.</li>
<li>Conjure should now work properly.</li>
<li>You can no longer chain activities. Completing one will no longer yield additional CD.</li>
<li>Kaioken BP add multiplier reduced to Base/12 instead of Base/10. Equates to +166% BP at 20x instead of +200%.</li>
<li>Slightly increased base accuracy on blast based moves. (About + 10/15%)</li>
<li>Homing Finisher damage mult buffed from 5 to 9.</li>
<li>Reduced Int/Magic penalty to stat ranks from 120 x Level / Mod to 80 x Level / Mod.</li>
<li>Warp Attack CD is now .15 x refire instead of .1 x refire </li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.39 (Nerfing the Gods) - 4/15/2018</b><br>
<li>Buffed Makyo star by about 10% across the board. Makyos now get +150% BP.</li>
<li>Blasts will delete themselves after fifteen seconds.</li>
<li>Black Water Mist people will get Makyo star boost.</li>
<li>Fixed an issue with blasts always getting incorrectly deflected.... (Yes, that means Ki is 2x as strong as it just was... Balancing needed.)</li>
<li>Buffed Ki Blade.</li>
<li>Kaioken BP reduced to some races by bringing the KaiokenMod for all races above 1x to 1x. (Affects Kaios, SDs, Humans and Aliens)</li>
<li>Kaioken no longer reduces Regen ticks by 10%.</li>
<li>Fixed bug with Cleave cooldown being much longer than intended. (Thanks Keenan1)</li>
<li>You can now use communicators and scouters to speak through Security Cameras.</li>
<li>Various other fixes for communicators.</li>
<li>Majin for demons was reduced to +60% BP, from +75%. Mystic for Kaios buffed to +60%, from +50%.</li>
<li>Lowered BP/Energy gains from activities. Lots of rewards rearranged. This will only affect new activities, not existing ones.</li>
<li>Reduced Focus drain and reduces the nerf to recovery ticks from it.</li>
<li>Changeling forms recovery reduction reduced. Form 1 and 2 are 90%, Form 3 and 4 are 80%, from 80% at all levels.</li>
<li>Makyo expand buffed slightly.</li>
<li>Fixed a bug causing Inside areas to generate resources. You will be able to mine them out but it will no longer regenerate.</li>
<li>Sloppy fix for edges respawning after a reboot.</li>
<li>Added a save age requirement for building. It is now 1.5 IC years.</li>
<li>Makyo base anger buffed from 120% to 135%.</li>
<li>New hidden Pantheon for Demigods.</li>
<li>SSj requirements changed. Lowbies have a higher req and Elites have a lower req. Lowbies will still get it first, but it won't be ages apart.</li>
<li>Self Destruct damage reduced by 50%.</li>
<li>Admin revive renamed to Admin Give Life.</li>
<li>Piercer damage mult reduced to 1.3 from 1.5.</li>
<li>Ray damage mult increased to 0.35 from 0.2.</li>
<li>Ship Lasers disabled.</li>
<li>Power Control drain reduced. (Meaning that sustaining a certain level is less draining, the rate you drain for each tick of + BP Percent is the same.)</li>
<li>Kaios rebalanced. (Just check on an alt to see mods. All created Kaios have been adjusted)</li>
<li>Starter boost is now automatic.</li>
<li>You may now cancel expand at anytime by using Expand 0.</li>
<li>Androids now properly affected by HP % but still immune to energy %. Fixed a bug involving vampires not getting immunity to HP%.</li>
<li>DB wish power rebalanced.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.38 (DOOM runs on RT) - 4/13/2018</b><br>
<li>Reduced drain on force fields.</li>
<li>Guns now do 10x more damage.</li>
<li>Lowered lots of energy requires for teach.</li>
<li>You may now teach languages.</li>
<li>Basic blast now only has a 30% chance to KB, down from 100%.</li>
<li>Fixed it so that when you unlock seeing other people's HP bars it does not hide your energy bar.</li>
<li>Makyo change expand icon is back.</li>
<li>Communicators and Scouters now show up in IC and General tabs.</li>
<li>Admins may now toggle off player IC names in OOC.</li>
<li>Fixed repairing armor.</li>
<li>Changes to use less resources on AFK players.</li>
<li>Removed Overdrive from Androids. It is now admin granted. Androids are also now affected by HP until they get "angry" which for an Android is erratic energies.</li>
<li>Paralysis now stops flying.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.37b (5...7...9...) - 4/12/2018</b><br>
<li>FPS back down to 14 because... Performance!</li>
<li>Issue with Ki Mult on cyberized people fixed.</li>
<li>Manual Digging no longer requires the planet to have resources.</li>
<li>Yardrat racial affinity for warp combo returned. (Yardrats deal 25% damage using combo instead of the normal 20%.)</li>
<li>Some melee skills CDs reduced.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.37 (1...2...4...) - 4/11/2018</b><br>
<li>Hyper Tornado uses Speed.</li>
<li>Fixed issues with Skills not starting at 100 Experience. (Only affects new characters/skills)</li>
<li>Androids should stop being angry.</li>
<li>Fixed some Roofs not working with admin ghost.</li>
<li>Ship view fixed when you stop piloting.</li>
<li>New Pop Up CD temporarily disabled until we resolve timing issues.</li>
<li>Fixed the issue with not being able to roundhousekick without arms by changing roundhousekick into roundhouse punch.</li>
<li>Decreased teach cooldown to 2 months for a standard move, down from 4 months.</li>
<li>Decreased BP increase from Overdrive to 30% base instead of 50%.</li>
<li>Alien Transformation req increased to 100-200k.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.36 (EXPAAAAAAAAAAAAAAAAND) - 4/10/2018</b><br>
<li>Lowered impact of Magic/Int to 120 per level down from 200.</li>
<li>Buffed Expand. (-5% Off/Def per level, from -10%, +5% Res per level, from 0%, and +15% End per level, from 10%.)</li>
<li>Reset view no longer kicks from MKIII pods or Ships.</li>
<li>Removed passenger limit on MKIII pods. If it becomes an issue I will reimplement it.</li>
<li>Ray damage multiplier reduced to 20% down from 50%.</li>
<li>Cyberize year changed to 3.</li>
<li>Explosion damage increasion by 15%.</li>
<li>Hit rate on melee increased another 5%.</li>
<li>Reduced baseline KO time from 240 seconds to 200 seconds.</li>
<li>Offspring fixes.</li>
<li>Lots of skills that should begin mastered now do.</li>
<li>Body parts now heal properly when admin healed from missing status. Admins can now heal individual body parts.</li>
<li>If you get knocked back you will stop firing and charging all beams.</li>
<li>Buffed fruits.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.35 (Okay fine, maybe I do spend too much time working out...) - 4/09/2018</b><br>
<li>Assess fixed.</li>
<li>Stats now indicate when you are soft capped.</li>
<li>Ship fixes.</li>
<li>Login message error fixes?</li>
<li>Train/Meditate now properly affected by stat soft cap.</li>
<li>Those more than 1.2x above the cap have been reduced to that point.</li>
<li>Explosion damage now has Ki Power multiplier added to it. The effect will be much lower explosion damage.</li>
<li>Custom Charge Icon and Custom Form Icon verbs restored.</li>
<li>Int/Magic contribution to StatRank now much harsher to coincide with the new gains system.</li>
<li>You may now always remove weights, even if above the cap.</li>
<li>Character Creation stat display fixed.</li>
<li>Custom Icon pixel x/y fixed for ki.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.34 (Dodge This) - 4/08/2018</b><br>
<li>Custom Hair</li>
<li>Changed Stat Ranks to not be Stat Ranks! (Stat Ranks will now just keep a general sense of your position in the world. It will help you catch up but will no longer penalize you.)</li>
<li>Lowered Base dodge rate on Attack verb by 5-10%. Base damage slightly lowered as a result.</li>
<li>Soul Contract tab added for managing contracts.</li>
<li>Assess updated to show weighted stats instead of current/base.</li>
<li>Some activity assignment cleanup to make more sense. Still needs another revision or two.</li>
<li>Removed ability to use winset command to view your own mutations.</li>
<li>Added a confirmation to Black Water Infection.</li>
<li>Ki Damage modifier increased due to new stat system. Up from 0.13 to 0.16.</li>
<li>Speed's stat affect updated to coincide with the reduction to base dodge rate. 17% of Speed now works towards Offense, and 15% towards Defense. From 15% of on each.</li>
<li>Reduced power up drain to current BP Percent ^1.3 instead of ^2.  (^2 meaning squared.)</li>
<li>Removed Missile upgrades for bombs.</li>
<li>Rebalanced Zenkai.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.33 (Vegeta Nuclear Attack - Never Forget) - 4/07/2018</b><br>
<li>King Kold form 2 mult lowered to 1.6 from 2</li>
<li>Fixed Changeling Assess sheet.</li>
<li>The additional drain from zanzokmen was lowered to 1.5 down from 3. (Based on feedback.)</li>
<li>Lowered magic requirement for telekenesis to 50.</li>
<li>Changes to the rate of diminishing returns on Stat Soft Cap.</li>
<li>Fixed a math error that would cause you to gain Off based on your defense mod while focused on defense. (Sorry to anyone that found that AMAZING bug for training.)
<li>There are now stat caps on individual stats. We understand this is a very controversial change that some people will not agree with.  I too, initially disliked the idea but after talking at length with Xander and seeing the benefits on paper, it has too much potential to be a good solution to not try it. As we take all player feedback seriously, please give the new system a wholehearted try and let us know what your experience is. The cap will initially be 1000 x Mod of a stat, after which you will gain slower and slower until at 1301+ x Mod where gains will be as low as they will go. The scale is 100% when below the cap, 60% when above it, 40% when more that 1.1x above it, 20% when more than 1.2x above it, and 10% when 1.3x above it.</li>
<li>Because of this new change to stat caps, it will largely create a niche for medium and balanced players as well as no longer punishing someone for training a stat with a lower mod.</li>
<li>Change icon is back in thanks to some fixes from They Call Me Protoman.</li>
<li>Countdown optimization, also thanks to Protoman.</li>
<li>Added an "Exit" option to the login menu as a sloppy fix for those poor souls that were forever irradiated by the nuclear attack on Vegeta. (RIP)</li>
<li>New "Introduce Self" verb for people with special characters in their names.</li>
<li>After witnessing an Oozaru massacre, Oozaru no longer automatically attack when unmastered.</li>
<li>Fixed making drones/robots and commanding them.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.32 (Stone Cold Stunner) - 4/05/2018</b><br>
<li>SGKA attack issue fixed.</li>
<li>Additional refinement to Changeling mods.</li>
<li>Low Class FBM boosted to 2.5x without mutations.</li>
<li>Added measures to prevent maliciously altered icon files from causing server issues.</li>
<li>Lowered the gains for train/meditate.</li>
<li>Option to focus on just speed for sparring to not destroy stat builds.</li>
<li>Increased stun times on wall of flame and pressure punch to 3+ and 6+ seconds respectively.</li>
<li>Steeper gain slow down after hitting stat soft cap.</li>
<li>Grab resist attempts now show up in Combat tab.</li>
<li>Lowered Bushido's speed boost from 40% to 20%.</li>
<li>Increased leechable Base BP limit to 70%, up from 65%. You now gain 1.75x as fast when sparring someone that has more weighted Base, in addition to leech. Up from 1.5x</li>
<li>Formulas for Assess updated to be more accurate.</li>
<li>SSj 1 Add reverted to old level of 500k with the mult reduced to 1.5x. This will keep SSj powerful when it arrives but assist with balancing Saiyans against the other races come FBM.</li>
<li>Overlays now removes hair. New Add Hair verb to quickly toggle hair. May come up with a better work flow later.</li>
<li>Fixed Saiyan Tail layering.</li>
<li>SSj1-3 Drain and Mults adjusted.</li>
<li>Golden Changeling drain increased.</li>
<li>Wrap Tail is now in the Other tab.</li>
<li>Change Icon works for players again.</li>
<li>World FPS increased to 16.</li>
<li>Changeling offspring classes are now randomized.</li>
<li>Base movement speed lowered slightly due to increased FPS.</li>
<li>Introduced an energy soft cap which is 500 x Mod x year default.</li>
<li>Magic scouter icon fix, thanks Bishamon121.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.31 (Ch-Ch-Ch-Changelings!) - 4/03/2018</b><br>
<li>Tuffle Int mod increased to 5 base.</li>
<li>Item save updated.</li>
<li>You can now use Customize SSj Hair to set base hair. In addition, Space Pirates also get it.</li>
<li>Tribute verb to the BR of RT, Joaomps.</li>
<li>Changeling transformations and base stats updated.</li>
<li>Form 5 mult, add and req added for Cooler.</li>
<li>Changelings made immune to vampirism.</li>
<li>Changeling Zenkai buffed to 3 from 1.</li>
<li>Changeling birth base BP changed to 1200 - 2000 range from 1000 - 1800.</li>
<li>All forms reworked to be balanced out against Saiyans at varying stages of the wipe.</li>
<li>Changeling FBM is now 2.45x.</li>
<li>Rudimentary Soul Contract system added for Demons.</li>
<li>Fixed an issue with buff limitations.</li>
<li>Fly Skill is now displayed as a raw number instead of %.</li>
<li>Ki req lowered for death ball and spirit bomb.</li>
<li>Mana/Resource activities now reward BP instead of mana/resources.</li>
<li>Androids are no longer leechable by non-Androids.</li>
<li>Spars gains for Str/End/For/Res lowered. Stat focus gain ratio lowered for the non favored stat.</li>
<li>BP leech rate lowered substantially. (Raw leech lowered by 50% and probability reduced.)</li>
<li>Thanks Rasengetsu!</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.30 (WIEP) - 3/29/2018</b><br>
<li>SSG Hair is now properly applied when reverting from SSB.</li>
<li>Added a cancel option to homing finisher and SGKA.</li>
<li>SSG for each Saiyan type was rebalanced.</li>
<li>Better starter boost</li>
<li>Atom type organization round 1</li>
<li>Makosen reworked into a kaio skill</li>
<li>Ki blade damage normalized further</li>
<li>More penalty for Int/Maigc. Blame Chewyy.</li>
<li>Observe requires 10 familiarity or higher.</li>
<li>Burning Sho(o)t added.</li>
<li>Fixes to some forumlas for character creation</li>
<li>Off/Def gains slowed from spars</li>
<li>Added Megaton Throw.</li>
<li>New buff limit (3 by default). Transformations other than Changeling count as 1.</li>
<li>New Activities</li>
<li>Better Shield. (Now reduces explosion damage, chance to reflect ki blasts at your opp based on def mod, will force turn off below 10% ki, drains ki on each reflect, decreases beam damage to 40% but drains ki on each tick.)</li>
<li>UI buffed. It now counts as 3 buffs.</li>
<li>New pressure punch skill. First of many crowd control based abilities.</li>
<li>Bunch of random optimization. Namely using built in BYOND procedures in favor of defining excess variables and calculations.</li>
<li>Fixed Planet Restore and Destroy to work with the new map.</li>
<li>Transformations with adds have been reduced.</li>
<li>Rebalanced Changeling classes. Freiza being the most consistent. Cooler is the best at Form 4, but weaker before that, King Kold is best before the others unlock final form, but still competitive after.</li>
<li>Gravity upgrades now require select levels of intelligence. Max limit is 75, field range 50 and battery 20.</li>
<li>Spirit Ball</li>
<li>Slightly decreased speed gains and increased off/def gains for sparring. Speed affect on refire is now capped at 1/2 instead of 1/3.</li>
<li>Easier to break from grabs.</li>
<li>Drones readded at 50 int</li>
<li>Started reformatting logs for external HTML viewing.</li>
<li>Added a way for admins to audit the majinize/majin absorb trackers.</li>
<li>Teacher ranks can now set someone as a Disciple and the student will receive better stat/BP gains when they spar.</li>
<li>New zones for each planet.</li>
<li>Moons added but not yet implemented.</li>
<li>Reset view button now also resets pilot status.</li>
<li>Elites got a buff. Now admin-granted rare only.</li>
<li>Normal and Low class Saiyans are now one and the same. Mods adjusted.</li>
<li>Rebalanced Ki Blade to use 90% Endurance 10% Resistance.</li>
<li>Several race's mods rebalanced.</li>
<li>Stat focus will now only change gains to a 4:1 ratio as opposed to 1:0.</li>
<li>New messages for useless weights.</li>
<li>Androids now start with 10 stat points.</li>
<li>Swim drain reduced.</li>
<p>
<br>



<b>Roleplay Tenkaichi version 0.29 (Maffamatics) - 3/16/2018</b><br>
<li>Buff to halfie SSG</li>
<li>Black Water Mist Infection reworked to be effective at any point in the wipe. (+30% BP boost to infected. Each infection will increase the owner's BP boost by another +6%)</li>
<li>Pantheon reverts properly on log out.</li>
<li>All rare skills have had their teach cooldown normalized. (Range of 1-3 years typical)</li>
<li>Fixed egg babies not being able to lay eggs.</li>
<li>Armor upgrades fixed.</li>
<li>The person you are trying to Shunkan Ido to must have sufficient BP depending on the range. (5k for same planet, 250k for global)</li>
<li>Can no longer go Oozaru with God Ki enabled.</li>
<li>Make Fruit and False Moon cooldowns fixed.</li>
<li>Wolf Fang Fist and SGKA damage normalized.</li>
<li>Hyper Tornado added.</li>
<li>Chernobog Pantheon buffed.</li>
<li>Global ki damage raised slightly.</li>
<li>Buffed Deathball and Spirit Bomb damage.</li>
<li>Added catch up gains for magic/intelligence.</li>
<li>Check lift math fixed.</li>
<li>Ki Blade now follows the same formula as other ki attacks.</li>
<li>KS can now selectively add/remove permissions to teleport to their planet.</li>
<li>Kaio/Demon Teleports now have a three year cooldown and can not be used until after year 5. The cooldown is only for leaving the afterlife.</li>
<li>Admins can now toggle a debug command to get additional insight into leeching/gains.</li>
<li>Piercer stats changed.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.28 (DRAGON BALL.... IN SPACE!) - 3/15/2018</b><br>
<li>Reduced some adds on SSGSS and SSj4.</li>
<li>Gravity max battery increased to 1000, drain frequency reduced slightly and battery refueling costs reduced.</li>
<li>Stat catch up gains increased very slightly. Stat gain drop off after hitting cap increases as well.</li>
<li>Human stat mods buffed slightly.</li>
<li>False Moon cooldown reduced to 1/3 of what it was.</li>
<li>SSG reduced to 2.5x BP Mult to Half Saiyans, 3x to Full Saiyans.</li>
<li>UI BP boost reduced to +60% from +100%.</li>
<li>Base Gravity mastery rate increased slightly. (+33% across the board.)</li>
<li>Gravity overlay bug when battery is drained fixed.</li>
<li>Pantheon's description will not update as you unlock new Pantheons.</li>
<li>Stat catch up assistance on training equipment while below 50 stat rank.</li>
<li>Some FBMs reduced for the sake of balance.</li>
<li>SpacepodMKIII's fixed.</li>
<li>SSB BP Mult reduced to that of SSj.</li>
<li>Bunch of XYZ/Black Turf/Inaccessible zone fixes. (Mostly teleportation techniques.)</li>
<li>Bunch of stuff added to Skill Sheet verb.</li>
<li>UI is an overlay instead of an underlay.</li>
<li>Cleaned up upgrade turf code a little.</li>
<li>Power Up drain increased.</li>
<li>Super Ghost Kamikaze Attack added.</li>
<li>God Ki leech chance increased slightly.</li>
<li>Wolf Fang Fist added.</li>
<li>Walls strengthened again.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.27a (This Armor Was Made For Blocking, And That's Just What It'll Do) - 3/15/2018</b><br>
<li>Reincarnation fixes.</li>
<li>Stat Point distribution fixes.</li>
<li>SSG Hair more red.</li>
<li>UI boosts BP now.</li>
<li>SSB Aura fixed.</li>
<li>Ki Blade icon overlay fix.</li>
<li>Gravity drain lowered slightly.</li>
<li>Increased BP for Full Saiyans in SSG.</li>
<li>New upgrade system for armor/power armor. (This is in preparation for a better enchantment system.)</li>
<li>Majin absorb release fixes.</li>
<li>Added golden changie for King Kold.</li>
<li>Pop Up Countdown now the same as the old version.</li>
<li>Renamed Admin Heal to Admin Restore.</li>
<li>Combo attack through doors fix.</li>
<li>Fixed a bug involving first time SSj.</li>
<li>New magic potions. (Weak versions of senzu beans.)</li>
<li>Admins may now set a soft cap for stats.</li>
<li>Can now gain mana when focusing on Nothing.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.27 (This Hair of Mine is Burning Red!) - 3/13/2018</b><br>
<li>Respec potions now only reduce the stat to 50% instead of 25%.</li>
<li>SSG added. Now when a Saiyan is using God Ki they will be considered to be in "Super Saiyan God."</li>
<li>Gravity refined a bit more. (Math corrected for abnormally high Grav Mods)</li>
<li>Majins are able to voluntarily relase an absorb.</li>
<li>New hidden requirement Pantheon for Demigods. New Pantheons will be added in this manner periodically.</li>
<li>SSG now grants SSjMult x 1.5 (Average of 3x) BP.</li>
<li>Majin absorb area now grants better stat gains.</li>
<li>A person at maximum God Ki now has a flame-like aura.</li>
<li>You can now observe the person that absorbed you.</li>
<li>Zenkai normalized for buffs/transformations.</li>
<li>Melee should no longer burn through armor like crazy. (Damage to the armor is now based on the damage received.)</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.26 (Ha Ha Ho Ho... Ha Ha Ho Ho... Ha Haa Ho Ho Hoo) - 3/12/2018</b><br>
<li>No longer able to break power armor with a melee attack when it is not occupied.</li>
<li>No longer able to destroy a ship with melee.</li>
<li>Gravity damage now displays in combat.</li>
<li>Increased base gain multiplier gain rate.</li>
<li>There is now a seperate variable for the ability to pilot the android ship.</li>
<li>Additional controls for Android Mainframe over the Android Ship.</li>
<li>Grav Mod now plays a role in determining drain from gravity above mastery.</li>
<li>Fix for maimed body parts not properly responding to forced healing.</li>
<li>New Overdrive verb for Androids that have over 10 upgrades installed and then "consume" another upgrade. Each module consumed increases resting BP by 2% up to a cap of 20 or +40%.</li>
<li>Changeling Form Adds are no longer culmulative.</li>
<li>New icons for Super Majin/Super Mystic.</li>
<li>SSj4 Add reduced.</li>
<li>Changeling Form 5 Add increased.</li>
<li>Better age tracking. New Save age variable for admins.</li>
<li>Bunch of atom type clean up and organization.</li>
<li>New sounds for God Ki.</li>
<li>Finally re-added MKIII pods.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.25a (Spedermen - Speders kill bugs) - 3/10/2018</b><br>
<li>Combat freeze bug fixed</li>
<li>Warp attack cheese reduced</li>
<li>Better, more dynamic stat ranks with less server  impact</li>
<li>Rebranded warp as combo attack to reduce confusion when referring to the melee skill warp attack.</li>
<li>Reduced PotentialUnlocked's BPMod boost slightly</li>
<li>Gravity doesn't kill, but it will KO you and  you will not master it while KO'd. Be careful out there, folks!</li>
<li>Alien starting gravity mastered is now 10x.</li>
<li>Buffed SSj4</li>
<li>God Ki no longer follows skill leech, only God Ki toggle.</li>
<li>UI drain lowered.</li>
<li>Form 5 Changie now has a higher add and its mult is based on current God Ki. (Scales up to 3x)</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.25 (This -IS- My Final Form) - 3/10/2018</b><br>
<li>Magic/Machine/Sword Force added to skill sheet. (You know sword force as bushido)</li>
<li>Some CDs changed, mostly melee</li>
<li>Capped some effects of speed on refire</li>
<li>SSj Drains rebalanced</li>
<li>Zanzo mastery is easier</li>
<li>Decreased focus drain</li>
<li>LB changes</li>
<li>Lag fix attempts</li>
<li>SSj4 by clicking or ssj verb. anyone that can go oozaru can get ssj4</li>
<li>Increased the effectiveness of God Ki. (Instead of +100% stats against someone without it, it is now +300% stats)</li>
<li>Added oozaru mastery</li>
<li>Better color for bojack hair</li>
<li>Vampire and a bunch of other custom stuff re-added</li>
<li>Increased blast base cost but reduced the cost for spread</li>
<li>Buffed mastered space pirate bojack bp add slightly</li>
<li>Space Pirates no longer get extra mutations</li>
<li>Round one of code organization and obsolete item cleanup</li>
<li>Redo stat recovery bug fix attempt</li>
<li>Bushido/Sword Force added to teach list</li>
<li>Fixed some SSj4 bugs and lowered cost for emitter</li>
<li>Golden Oozaru requires ssj2, ssj4 requires ssj2 to unlock</li>
<li>Custom SSj Hair</li>
<li>Golden Changeling. (AKA Form 5)</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.24 (What You Got I Want, Got To Get It Put It In Me: AKA The Absorb Update) - 3/09/2018</b><br>
<li>Demigod God Ki chance 50%</li>
<li>Oni God Ki 20%</li>
<li>SSj mastery added to skill sheet</li>
<li>SSj FP now gives double the regular SSj Add</li>
<li>Warp Attack CD increased again</li>
<li>Glass doors work and added a Glass Roof</li>
<li>Fists of Fury drain lowered</li>
<li>Lowered Kaioken's raw speed.</li>
<li>No longer lose absorb BP on death regen</li>
<li>Absorb BP reduces Regen/Recov at a slower rate now. (About 60% healing with 100% Absorb BP. Androids and Majins only suffer -10% regen/recov.)</li>
<li>Stat Lag clean up. (Increased Stat Lag variable in an attempt to... decrease stat lag. The irony...)</li>
<li>Being absorbed by a Majin will now send you to an alternate reality Z, eventually replaced by a majin interior once we get the map done. While on this Z, you will get increased gains, similar to the HBTC but weaker. This is to encourage players to wait out the Majin's death and be revived/released back into reality. Alternatively, you have the option to reincarnate if absorbed by a Majin.</li>
<li>Fixed a bug with rare Changelings.</li>
<li>Fixed a bug where you could not regenerate missing limbs.</li>
<li>Gave body parts some quick descriptions so you know what stats they affect.</li>
<li>Android absorb works only on other androids and works differently now. Now you will take all of the modules they have installed and get an energy and base boost as opposed to Absorb BP. Eventually when I do the cybernetics system I will incorporate a facet of Absorb BP for androids/cyborgs, likely stemming from blast absorb.</li>
<li>Androids now properly forced to reincarnate on death if not rebuilt.</li>
<li>Kaioshin may now limit SI to the AL.</li>
<li>Second attempt at removing Majin upon death of the Majinizer.</li>
<li>Added Super Perfect Form for Bio Androids.</li>
<li>Third Eye no longer reduces anger but only boosts BP by 50% instead of 60% now.</li>
<li>Removed gravity death again. (Ryu was right, Chewyy was wrong.)</li>
<li>Demon Lord and Kaioshin now have a sense outsiders verb that will allow them to detect races that do not belong in the AL.</li>
<li>New icons for some SSj2 stuff.</li>
<li>Added a way to unlock SSj3 without admin help.</li>
<li>Reduced SSj1 Drain</li>
<li>Check lift now creates up to three weights for the person if their lift exceeds your max.</li>
<li>Admin verb clean up/organization. New stuff on player options menu.</li>
<li>Issues with SSj and God Ki fixed. Previously you would be unable to use SSj if you had unlocked God Ki.</li>
<li>Attempted to fix an issue with SSj2 drain sometimes being more or less.</li>
<li>Bloat server files removed and archived.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.23 (Respec My Authority) - 3/08/2018</b><br>
<li>Ban should get all multikeys now.</li>
<li>Some admin verbs moved to the Other tab.</li>
<li>Ship destruction now saves to logs.</li>
<li>Magic Force was nerfed. (+40% BP instead of +50%, -40% Strength instead of -30%)</li>
<li>Some God Ki display errors fixed.</li>
<li>Now you start with mastered common if it is after year 10.</li>
<li>Added Super Majin and Super Mystic for Kaioshin and DL. (For now they are admin granted at FBM for the corresponding rank.)</li>
<li>Offspring of Kaios and Demons will now properly learn Majin/Mystic when appropriate.</li>
<li>Fixed emotes/says sometimes not working with observe.</li>
<li>Telepathy will now indicate if the person you are targetting can not respond.</li>
<li>Super Saiyan God Rose added. Please redo your hair to avoid any issues.</li>
<li>Passive healing boosted.</li>
<li>Added better BP Catch up gains, similar to the stat catch up.</li>
<li>P Bags now gives 33% as much BP as a player, logs give 50% and split forms gives 66%.</li>
<li>Changed various equations, mostly buffs, to stop giving such small numbers, i.e. 1.666667. The result will be some increases/reductions changing slightly. The descriptions should still be accurate.</li>
<li>Retroactively reduced SSj2 At by 20%.</li>
<li>Kaioshin and DL will now always get God Ki at FBM regardless of race.</li>
<li>Buffed movement speed again.</li>
<li>You can no longer use Warp Attack while beaming/charging a beam or other charged attack, like kiezan. (The skills that allow normal movement will allow you to warp attack while charging still, though.)</li>
<li>Power Up drain increased from 2x to 3x.</li>
<li>Respec Potions added to Magic for level 55.</li>
<li>Warp attack cooldown increased.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.22B (ENDERZGAME) - 3/08/2018</b><br>
<li>Buffed Tuffle cyberizations. They will only suffer slightly in Health and Energy recovery.</li>
<li>Ki attacks added to combat text.</li>
<li>Magic heal can no longer heal over 100 health.</li>
<li>Boosted absorb BP.</li>
<li>Fixed Second Wind cooldown.</li>
<li>Increased the Cyber BP upgrade ratio to Int level.</li>
<li>Buffed Keep Body up to 80% power, dead without body buffed to 10%.</li>
<li>Less warp attack spam.</li>
<li>Changed the Odin Pantheon to be pure BP now. (+60%)</li>
<li>Ultra Instinct buffed/altered for Saiyans.</li>
<li>Mating formula changes.</li>
<li>Artificial Power no longer removes anger, just severely limits it. (Tuffles receive a small bonus.)</li>
<li>Fixed reward object duplication. (Sorry admins)</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.22A (The Xander Update) - 3/06/2018</b><br>
<li>SSj2 Drain fixed.</li>
<li>FBM's adjusted and now attainable.</li>
<li>Change in admin logs handling as we redo our system.</li>
<li>Slight nerf to explosion damage. (-10% damage)</li>
<li>Death Anger fixed.</li>
<li>Namekian offspring will now properly inherit the skills from their parent's clan.</li>
<li>More ability for admins to clean up backend objs, such as reports and old logs.</li>
<li>10 familiarity requirement to mate with someone. All mating is IC and this will help stop people that make alts just to breed with.</li>
<li>Better reward atom handling. You will now only have one reward object per key. This will make rewards, and by assosciation admin lives, much much easier and quicker.</li>
<li>Took some overhead off of the server by removing senseless loops, obsolete variables and procedures that were fruitless.</li>
<li>LSSj SSj mastery bug resolved.</li>
<li>Changeling Forms recovery nerf lowered. (Was /1.5 now /1.4)</li>
<li>SSj2 no longer reduces recovery further but has a higher natural drain.</li>
<li>SSj3 will reduce your recovery further, by the same factor as SSj1. It has had its natural drain lowered as a result.</li>
<li>Magic/Int Exp and Mana/Resources gained from spending RPP increased.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.22 (ADMINHALP) - 3/05/2018</b><br>
<li>Buffed walls.</li>
<li>Buffed scouters.</li>
<li>Third Eye no longer lowers regen/recov.</li>
<li>Dying will now remove any Majinizations you may have in place.</li>
<li>Cleaned up Planet Destruction and Restoration and ensured they work with new map.</li>
<li>Ranks/Rewards tab default to off for admins.</li>
<li>New Admin Insights window added as I continue to flush out the admin system. It is limited to the Ranks page and Server tab at the moment but will extend to rewards and other systems soon.</li>
<li>Attempts to increase the smoothness of zanzoken combo by ensuring you will properly face each other and step away appropriately.</li>
<li>Power Up drain increased by 20%. This only affects actively powering up and not sustaining a given level.</li>
<li>Mastered super saiyan will not be displayed to admins and will now offer a 20% higher add. (Bojack has a similar mastery system that grants additional add)</li>
<li>Reintroduced stricter means for Gravity death.</li>
<li>Increased monthly resource limit.</li>
<li>Better obj cleanup and option to delete weights, like clothing.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.21A (Insect Squashing) - 3/04/2018</b><br>
<li>Various changes to procedure handling. No changes to gameplay but should affect perfomance.</li>
<li>Bug fixes galore.</li>
<li>Zanzo direction issue fixed.</li>
<li>Non full-blooded SSj fixed.</li>
<li>Fixed punching bags.</li>
<li>Fixed spam from SSj message.</li>
<li>Adjusted cooldowns for various Ki Attacks.</li>
<li>Ki Damage modifier brought up by 10%, for a total reduction of -10% compared to the strart of the wipe.</li>

<p>
<br>
<b>Roleplay Tenkaichi version 0.21 (Space Station) - 3/01/2018</b><br>
<li>Changed combo warp to be 5x attack speed at 20% damage but with an additional drain, this is up from 14% damage. (Shunkan Ido increased the speed to 6x)</li>
<li>Reduced minimum power from energy loss to -90% BP at 0% energy.</li>
<li>Fixed Space Station planet bump.</li>
<li>Ki will no longer damage AFKs.</li>
<li>You will not transform into Oozaru from the yearly moon while inside.</li>
<li>Lowered overall Ki Damage by 20%.</li>
<li>Lowered contribution of Speed towards Off/Def to 10%  down from 20%.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.20 (Supah Numek) - 3/01/2018</b><br>
<li>FBM req increased across the board.</li>
<li>SNj Added.</li>
<li>Bio Forms rebalanced/reworked.</li>
<li>Few descriptions cleaned up.</li>
<li>Zanzoken damage lowered a little to account for faster attacks.</li>
<li>Usual round of tweaks/fixes.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.19c (Body Pahts) - 2/28/2018</b><br>
<li>Redid Body Parts. Again.</li>
<li>Gains tweaked a bit more. Should no longer need the assitive catch up gains.</li>
<li>Toggle for classic CD vs pop up window in other tab.</li>
<li>New power down sound. (Thanks to whoever sent this to Chewyy!)</li>
<li>Various end game level buffs rebalanced.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.19b (Hold Me) - 2/27/2018</b><br>
<li>Grab fully fixed.</li>
<li>Flying no longer gives you extendo arms. (Both players must be flying or not flying to attack. Didn't make a ton of sense and was very unbalanced before.)</li>
<li>PC changes. Powering up will no longer drain you out, only the drain to "sustain" PU will. </li>
<li>Renamed Olympus to Pantheon. (Thanks Omni!)</li>
<li>Added a new CD display. (CC inspired.)</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.19 (Warp Speed Captain) - 2/26/2018</b><br>
<li>Changed the way that energy/HP affect your BP. (HP now affects your BP normally until 90% HP then caps at 90% BP until you drop below 80% HP where it caps at 80% BP until you drop to below 70% HP and so on down to 30% BP being the lowest. Ki now affects it similarly but only down to 50% BP reduction and goes at intervals of 5% BP per 10% energy. Confusing. I know.)</li>
<li>Little more drop off for gains at the top of the Stat Ranks. This is only while fast catch up is enabled and will not be the norm.</li>
<li>Kaioken/Limit Breaker rebalanced again. You may now power up in Kaioken and LB.</li>
<li>Namekian Fusion now gives an extra 10% if someone is your counterpart.</li>
<li>Gains adjusted again. Should be about close to good.</li>
<li>Zanzoken warp attack speed and Warp-Attack speed and cooldowns reduced.</li>
<li>Third Eye now only reduces Regen/Recov by 10%.</li>
<li>Fly no longer drains in RP Mode.</li>
<li>Mystic buffed.</li>
<li>Grab bug fixed.</li>
<li>Manual Starter Boost added for Admin levels 2+.</li>
<li>Tiers removed due to confusion around their purpose and general dissatisfaction.</li>
<li>Added a donation link to contribute towards server costs.</li>
<li>Power up rebalanced. Everyone should be using power up no matter how bad their recovery. The key factor is how much you're able to hold. Bad recovery should net you around +10% while good around +75% reliably.</li>
<li>Starter boost option added to admin player options.</li>
<li>Demigod Buff added. (Will need balancing)</li>
<li>Tuffle buff added. (Genius aliens may also learn)</li>
<p>
<br>


<b>Roleplay Tenkaichi version 0.18b (DEM GAINZ) - 2/24/2018</b><br>
<li>Nerfed Cybber BP in that it actual has the negative effectives listed. It reduces regen/recov the more you have in proportion to your body's power and it removes anger. (Does not reduce regen/recov on Androids)</li>
<li>Starting with this version, each version will have a subtitle.</li>
<li>Removed Vampires.</li>
<li>Added Shunkan Ido Zanzo Toggle.</li>
<li>Gravity hurts less and batteries last longer. (Removed ability to "trap" gravity with opaque turf.)</li>
<li>More effective catch up manners.</li>
<p>
<br>


<b>Roleplay Tenkaichi version 0.18Ki - 2/23/2018</b><br>
<li>Ki Overhaul pt 2. (Rebalanced drains, cooldowns, fire-rates and damage for pretty much all ki attacks.)</li>
<li>Aliens may now change their racial transformation icon.</li>
<li>Updated Skill Sheet and skill mastery changes.</li>
<li>Various Status tab changes. (Click Regen/Recov!)</li>
<li>Gains altered again with new HA+ verb to enable faster catch up gains.</li>
<li>Limit Breaker will now damage you if your limbs can not be injured.</li>
<li>Speed Multiplier now affects movement speed and attacking.</li>
<li>FBMs rebalanced due to new forms.</li>
<li>Kaios now have the same affinity for Focus that Humans do.</li>
<li>Humans and Aliens now get a temporary buff called Adaptive. (If this is well received I will roll more of these out.)</li>
<p>
<br>


<b>Roleplay Tenkaichi version 0.17Ki - 2/22/2018</b><br>
<li>Ki Overhaul pt 1. (Everything now uses the Experience variable and there is a new way to view skill mastery with the Skill Sheet verb. Everything that has mastery is affected by it in some way, but for now it is mostly cooldowns. Several high end Ki techniques have had their damage multipliers nerfed to be more reasonable and less fail or one shot.)</li>
<li>Observers can now see say/rp around their targets.</li>
<li>Scouters work correctly in the AL now.</li>
<li>Magical OMNI - Onis are better.</li>
<li>Usual batch of fixes.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.17bb - 2/22/2018</b><br>
<li>Give Power now only sends +20 Health if the person is already fully healed. Send Power now heals half as much as it used to.</li>
<li>Increased chance to roll a changeling class. (Cooler, King Kold)</li>
<li>LOOC Toggle, use "INF" to bypass the toggle.</li>
<li>Altered Makyo Expand to have slightly less BP.</li>
<li>Reduced Magic Force's drain.</li>
<li>Alien may now use anger to unlock their Transformations.</li>
<li>Buffed Magic/Int exp from reward points.</li>
<li>Sword techs work with Ki Blade.</li>
<li>Started rebalancing some ki moves.</li>
<li>Mystic now only reduced anger instead of disabling it.</li>
<li>New Tier display for some insight into Stat/BP ranks.</li>
<li>Reset Stat Multipliers now resets BP mult too.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.17b - 2/21/2018</b><br>
<li>Focus drain balanced. (Now actually usable)</li>
<li>Kaioken again rebalanced.</li>
<li>Limit Breaker rebalanced and no longer using the scheduler.</li>
<li>Gains, specifically catch up gains, rebalanced and dialed back.</li>
<li>Language mastery speed increased.</li>
<li>Base movement speed buffs.</li>
<li>Babies and Androids can now be set to require passwords.</li>
<li>Power Control drain rebalanced.</li>
<li>Second Wind added. Now in a non Spar fight you will get a second wind if knocked below 50% health when initially above 50%. Self Destruct and bombs bypass this.</li>
<li>New Profiles, actually not messing with edit now!</li>
<li>Various fixes, including HBTC.</li>
<li>Players now have a Reset Stat Multipliers verb. (Don't abuse it or I'll just take it out.)</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.17a - 2/20/2018</b><br>
<li>Starter Boost increased according to current Year.</li>
<li>Various admin verb improvements.</li>
<li>Attempt to fix Limit Breaker suddenly losing its drain.</li>
<li>Gravity Mastery will now increase much slower. While in gravity above your mastery you will now benefit in training speed faster.</li>
<li>Train/Meditate antispam fix.</li>
<li>Based movement speed increased.</li>
<li>Kaioken balanced further. (Now grants +100% BP at 20x, +50% at 10x)</li>
<li>Admins can now set Gain Mult increase rate and see average Gain Mult.</li>
<li>Mating fixes.</li>
<li>Fixed Android Upgrade Module not taking mutations into account.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.17 - 2/19/2018</b><br>
<li>Futher balanced Kaioken. (Can't use expand/focus while using Kaioken as an example)</li>
<li>New Stat Multiplier system! (You can now see the current effects of buffs/transformations on your character in your stats display. This is not your mod and works the same way that the game keeps track of BP Multipliers.)</li>
<li>Two additional fixes to Body Parts. (One regarding injury and one healing)</li>
<li>Admins may now restrict Teleportation between realms.</li>
<li>Due to popular demand: brought back recyclers and throw. (Throw is still buggy)</li>
<li>Updated Assess sheets to reflect the new stat system to make it easier on admins.</li>
<li>Several adjustments to the contents of rewards and the manner in which they are rolled out.</li>
<p>
<br>

<b>Roleplay Tenkaichi version 0.16d - 2/18/2018</b><br>
<li>Fixed Rewards crashing.</li>
<li>Fixed bandages.</li>
<li>Fixed various skill learns.</li>
<li>Fixed issues with FF/GG icons.</li>
<li>Rebalanced Kaioken.</li>
<li>Sense requirements increased for later levels of sense. (Stats, Sense Galaxy, etc)</li>
<li>Increased the rate of Gravity Machine battery drain.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.16c - 2/16/2018</b><br>
<li>Body Part Fix involving Train verb.</li>
<li>Android Zanzoken icon is different. It is not a bug.</li>
<li>Cyberize year limit fixed.</li>
<li>Space Station added to space map. Teleporters and Portals now work to and from Space Station.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.16b - 2/15/2018</b><br>
<li>Telepad upgrade issue fixed.</li>
<li>Dead people can now regen HP normally in the AL.</li>
<li>Several typos fixed.</li>
<li>OOC toggle will now save with your character.</li>
<li>You may no longer leech skills while AFK.</li>
<li>First attempt at fixing obj save issue.</li>
<li>Zanzoken lag fix attempt.</li>
<li>Various Oozaru fixes.</li>
<li>Temporary admin help system implemented.</li>
<li>Spar gains adjusted to favor Off/Def/Spd.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.16a - 2/14/2018</b><br>
<li>Fixed bind.</li>
<li>Changed Body Size formula to match spreadsheet and generally be easier math.</li>
<li>Nerfed explosion damage.</li>
<li>Oozaru fixed again?</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.16 - 2/13/2018</b><br>
<li>Bunch of fixes to how the game handles stat assignment through redo stats and changing body size.</li>
<li>Additional null var checks and a new attempt to fix them in the moment.</li>
<li>Lowered rate of and actual damage to limbs while sparring with pull punches on.</li>
<li>Took Expand off the scheduler for two reasons. It didn't need it and I want to start moving away from such heavy reliance upon it.</li>
<li>Took Bushido off the scheduler for the above reasoning.</li>
<li>Took Fly off the scheduler. Should work more reliably now.</li>
<li>Fixed a couple admin verbs displaying incorrectly. (Int and Cyber BP Cap)</li>
<li>Improved the way admins grant Alien transformations.</li>
<li>Focus stats adjusted, added mastery and Humans have a racial bonus.</li>
<li>Few extra options added to Aliens based on player feedback. Will continue to add additional flavor options for Custom Aliens.</li>
<li>Small adjustments to Status Bar display rate.</li>
<li>Added the Teach verb to Rank exclusive beams.</li>
<li>Added a way for the Black Water Mist user to regain Infect counters.</li>
<li>Fixed Monkey Bois.</li>
<li>Kaioken fixed but be careful, you can die if you use more than 5x mastered.</li>
<li>Added back Activity cool down reduction for completing an Activity.</li>
<li>Build list organized by Int requirement and some requirements changed.</li>
<li>Upon request, added the ability to show resources/mana by clicking them.</li>
<li>Improved Namekian Fusion.</li>
<li>Throw removed until it is working again as per democracy. (Earth's Baseball League is cancelled until further notice.)</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.15c - 2/13/2018</b><br>
<li>Attempted to fix Super Fly.</li>
<li>Now instead of a flat reduction your int/magic gains are slowed more the futher past the soft cap you are.</li>
<li>Spin Blast verb changed to Barrage to avoid the prompt when you have it and regular Blast.</li>
<li>FBM requirement increased slightly.</li>
<li>Fixed a bug involving knock back, which had cascading effects on various other systems, including attack and Kaioken.</li>
<li>Few additional bugs with Body Parts not healing properly.</li>
<li>Fixed a few Oozaru bugs.</li>
<li>Couple Mutation things tweaked. Admins now have the ability to reroll someone's Mutations.</li>
<li>Added a new stat display for admins to see average Int/Magic above 20 for the server.</li>
<li>Regen rate lowered.</li>
<li>Increased global melee accuracy, this in addition to regen nerfs show make fights not last forever.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.15b - 2/11/2018 - 2/12/2018</b><br>
<li>No longer able to grab and zanzoken unless you are a Yardrat. (Credit to CC for the idea.)</li>
<li>Admin verb fixes.</li>
<li>Additional fixes/safeguards to character creation.</li>
<li>New Flight system. (1/2)</li>
<li>Fixed crashes, which were caused by TOO MANY LISTS DM crash. (Attacking was creating a list to store your combat stats each time it was called and never deleted itself after. This meant that after 66,000 attacks were processed, the server would die.)</li>
<li>Fixed some issues with icon change on certain skills.</li>
<li>Minor UI update.</li>
<li>Magic and Technology windows updated.</li>
<li>Fixed Expand.</li>
<li>You can no longer speak Punching Bag. (Sorry Saiyans.)</li>
<li>Increased Saiyan limit.</li>
<li>Found another source of list spam, the scheduling system. Should help with the Too Many Lists crashes.</li>
<li>Fixed issues with Mega Burst's icon.</li>
<li>Various other list clean up to help with the bug.  If I can not eliminate it within the next couple days I will work on a scheduled rebooter/reconnect system similar to CC as a short term solution.</li>
<li>Spar gains tinkered with again.</li>
<li>Fly gains lowered to compensate for faster cycle ticks.</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.15a - 2/10/2018</b><br>
<li>Bug fixes and typo corrections.</li>
<li>Fixed a bug involving character creation.</li>
<li>Addressed a couple oddities in gains. Much more consistent now.</li>
<li>Fly spar bug fixed.(?)</li>
<li>Reduced the rate that int/magic affect stat gains.</li>
<li>Train/Meditate now have a lower likelihood of increasing stats each tick, this will put it more in line with sparring.</li>
<li>Spar Gains are now hard limited so you will not gain faster if you attack faster, but there is still a minimum attack interval for ideal gains. (There is still an ideal attack interval, but doesn't punish larges as much.)</li>
<p>
<br>
<b>Roleplay Tenkaichi version 0.15 - 1/30/2018 - 2/9/2018</b><br>
<li>Changed Body Size system and equations for each size.</li>
<li>Body Sizes can now be changed mid-creation instead of needing to reconnect/redo.</li>
<li>Removed chance to roll a rare.</li>
<li>Redid every Race's base mods and balanced each to be in line with the others but still have a unique feeling.</li>
<li>Namekians overhauled into three clans, similar to Saiyan classes.</li>
<li>Body Parts rehauled again. (Six backend processes and systems reduced to two and injury healing now running on the same process as regular healing. Will result in less overhead for the server and less potential for error/whackiness. Rebalanced what injuries reduce what, arms = str/for, legs = off/def, chest = end/res)</li>
<li>Various skin elements updated.</li>
<li>Can now change your direction with holding CTRL and a direction.</li>
<li>More accurate Status Bars.</li>
<li>Pop up displays for Sense/Scouter when you toggle the tab.</li>
<li>Better displays for clothing and choosing icons, hair to follow.</li>
<li>Smoother process for character creation and more consistent with when you choose what. (Example, icons, skills, etc)</li>
<li>New save system. You only get one save per key.</li>
<li>Additional UI changes.</li>
<li>Bunch of new ki icons.</li>
<li>Build menu standardized with current map icons.</li>
<li>Better swords and armor. (Now affect your stats in addition to retaining some of their previous effects. i.e. Armor can still reduce damage, but will not negate it.  Sword still increase effective BP but not as much.)</li>
<li>Limit Breaker changes. (+20% Force, Strength and Speed, 2x Regen/Recov.  60-100 seconds x Regen length, can now revert as well.)</li>
<li>SSj/Space Pirate Transformation systems flushed out and mostly automated. (First SSj will require admin approval.  Admins have the ability to toggle global SSjs, which allows anyone with the right BP to transform.  There is still a First SSj variable, which tracks when those automated subsystems allow SSj. Essentially, first SSj happens, that allows other people to leech from him/unlock with death anger.  Some point after that, admins allow global SSj which removes the need to leech/witness the trans.)</li>
<li>FBM's rebalanced.  AL races sit on the top with Saiyans at the bottom (Due to SSj).</li>
<li>God Ki/SSGSS implemented. (God Ki comes from ascended AL race or Makaioshin Rare. God Ki is a requirement for SSGSS.)</li>
<li>Super Saiyan now has corresponding Transform/Revert skills so you can macro SSj.</li>
<li>Changelings now have Transform/Revert skills like Saiyans.</li>
<li>Text handling overhaul part 1!</li>
<li>All races with transformations got the same love.</li>
<li>Bunch of other stuff I forgot to write down.</li>
<li>Thanks to Relkreim for a bunch of nice icons.</li>
<li>Ultra Instinct added. (Non Saiyans with a certain amount of God Ki can learn it naturally.)</li>
<li>Mating reintroduced, it's cool.</li>
<li>New Activities.</li>
<li>Mods rebalanced again.</li>
<li>Demigods get an improved expand until I give them some real love.</li>
<li>Admins may not selectively disable/enable races at will.</li>
<li>Alien rework pt 1! (Aliens come in four flavors now. Try them all!)</li>
<li>You can now use TVs to turn into public security cameras. (Default freq is "TV" Galactic Wrestling Federation anyone?)</li>
<li>Magic and Int levels affect stat rank after a certain point. As such you may now use the Stat Focus verb to focus meditation on nothing but bp/energy.</li>
<li>Bunches of fixes/tweaks for the corresponding new systems.</li>
<li>Started addressing Ki rework. Probably 10% done.</li>
<li>Took another swing at Contacts. Streamlined management and added new options as well as a faster tick rate.  Offspring/Parents start with a developed bond.</li>
<li>Started my first attempts at overhauling cybernetics and cyberize. (Most modules disabled for now.)</li>
<li>Redid some other UI stuff.</li>
<li>Shit ton of small tweaks not significant on their own but collectively worth mentioning.</li>

<p>
<br>


<b>Roleplay Tenkaichi version 0.14a - 1/29/2018</b><br>
	<li>Can no longer reroll the same activity multiples times.</li>
	<li>Leeching was too high, brought it back down.</li>
	<li>Reduced impact of zanzoken mastery on hit/miss chance.</li>
	<li>Blast states added to a bunch of Changeling icons.</li>
	<li>Even more measures to ensure even "catch up" gains. (Even more of a boost to power ranks above(worse) than 55. Leeching is no longer weighted by a person's BP Mod.)</li>
	<li>Warp attack works over water.</li>
	<li>Even less BP from Gravity.</li>
	<li>You may no longer stack Regenerators.</li>
	<li>New formula for current BP. (No longer multiplied by the square root of your BPMod.)</li>


	<p>
<br>

<b>Roleplay Tenkaichi version 0.14 - 1/27/2018</b><br>
	<li>Added additional checks for null var references and procs running with null targets.</li>
	<li>Additional fixes on Kaioken. (Would not properly revert when KO'd previously.)</li>
	<li>Spelling and grammar corrections.</li>
	<li>Further reward system improvements and simplification.</li>
	<li>Mana and Loot Activities added back into rotation with their requirements properly updated for current activity logic.</li>
	<li>You can now only rename yourself and clothing.</li>
	<li>Power Ranks (BP/Stats) now follow a steeper curve, with more of a boost at the bottom and more of a slowdown at the top.</li>
	<li>Various objs are now off limits for change icon. (Magic balls, Clone Tanks, etc)</li>
	<p>
<br>





<b>Roleplay Tenkaichi version 0.13a - 1/26/2018</b><br>
	<li>Leeching cap raised to 85% a person's base.</li>
	<li>Black Water Mist BP boost lowered.</li>
	<li>Magic Scouter added.</li>
	<li>Bugfixes and security updates.</li>
	<li>Everything that should refer to Stat/BP ranks now does so.</li>
	<li>Kaioken mastery rate dramatically improved.</li>
	<li>Drastically reduced map size in an effort to address crashes.</li>
	<p>
<br>


<b>Roleplay Tenkaichi version 0.13 - 1/23/2018 - 1/24/2018</b><br>
	<li>Activity rewards now are based on server averages if you are below the average.  Otherwise based on your base BP/Energy.</li>
	<li>Admin panels cleaned up further and better organization of verbs.</li>
	<li>More tweaks/balancing to zanzoken and warp.</li>
	<li>Teaching/leeching addressed and normalized. May still need more tinkering.</li>
	<li>Better progress updates for activities.</li>
	<li>New activity types added. (Teach/Learn)</li>
	<li>Removed drowning message spam.</li>
	<li>Fixed dragonballs scattering and added admin scatter.</li>
	<li>Attempt 1 to make RP/Says viewable in observe.</li>
	<li>Increased maximum gain mult leeech to 30% from 10% and increased the range for catch up gains.</li>
	<li>Custom Black Water Infection added for early wipe villain ranks.</li>
	<li>Activity rewards normalized again.</li>
	<li>Better Character Profiles.</li>
	<li>Small delay added between creating new technology items. (0.2 seconds)</li>
	<p>
<br>




<b>Roleplay Tenkaichi version 0.12b - 1/21/2018 - 1/23/2018</b><br>
	<li>Various quality of life improvements for players and admins alike.</li>
	<li>Bunch of random bug fixes.</li>
	<li>Renamed a couple skills.</li>
	<li>Further tweaked some beams and other charge based attacks. Now you can only move with a select few and those that do allow you to move reduce your move speed.</li>
	<li>Better Stat Focus</li>
	<li>Countdowns fixed to be 30 seconds instead of 60.  May change back.</li>
	<li>Delay added to say to prevent macro spam for language mastery.</li>
	<li>Fixed Assess All.</li>
	<li>Changed stat gains to be more consistent across differing training methods.</li>
	<li>Changed Stats formating after player feedback.</li>
	<li>Better Makyo Star system and easier tracking for admins.</li>
	<li>Bushido and Magic Force fixed.</li>
	<li>Adjusted zanzoken refire to differ according to speed mod.</li>
	<li>Balancing/bugfixes to Kaioken.</li>
	<li>Changes to beam behavior, naming them draining while firing.</li>
	<li>FBMs reintroduced and implemented.</li>
	<p>
<br>



<b>Roleplay Tenkaichi version 0.12a - 1/20/2018 - 1/21/2018</b><br>
	<li>Added mana use option for Armor/Sword upgrades.</li>
	<li>Added boxing gloves to Magic tech list.</li>
	<li>Fixed Hell resource gains.</li>
	<li>Added magic level upgrade option for Turf upgrades.</li>
	<li>Said fuck it on Sky Break and just made it a strength version of Dragon Nova. (Damage reduced as a result)</li>
	<li>Drills can be upgraded to your Int x 5.</li>
	<li>The Speed stat and not just the mod will affect things like cooldowns, movement speed and attack speed.</li>
	<li>Contacts improvement rate lowered.</li>
	<li>Less frequent activity progress messages.</li>
	<li>Added auto learn req for zanzoken.  It is fairly high, still leaving leeching/being taught as the main source.</li>
	<li>Fixed item rewards for activities.</li>
	<li>Activity tracking in general is more accurate and more repsonsive.</li>
	<li>Sense requirements increased.</li>
	<li>More accurate Status Bar tracking.</li>
	<li>Lowered requirement for upgrading walls with mana.</li>
	<li>Teach added for Ki Blade and Megaburst.</li>
	<li>Fixed blasts spread setting so that it will be even.</li>
	<li>Race verb added back to players for visibility with certain races hidden.</li>
	<li>Changelings and Saiyans are now limited to an adjustable static number, similar to how Elites function.</li>
	<li>Made it so the day saves on world save.</li>
	<li>Slowed speed gains.</li>
	<li>Hitting an opponent from behind will increase your accuracy.</li>
	<li>Beams rebalanced.</li>
	<li>Better Races display for admins.</li>


	<p>
<br>


<b>Roleplay Tenkaichi version 0.12 - 1/19/2018</b><br>
	<li>Improved ease of use on admin verbs for those that do not have formulas handy and those that just can not math.</li>
	<li>Further melee skill rebalancing.</li>
	<li>Gravity fixes/changes.</li>
	<li>Character Creation revamped.</li>
	<li>Additional measures for admins to detect bugged characters on log in.</li>
	<li>Started first wave of revamping teaching/skill leech system.  Eventually, passive leech will always be on at a very low rate with the main method of teaching being the actual teach verb.</li>
	<li>Ease of use and quality of life improvements for admins.</li>
	<li>Small changes to player stat display and other verbs.</li>
	<li>Advanced measures to prevent rollbacks from even occuring.  System will detect and correct atom references within your save and alert admins to any potential future issues as well.</li>
	<p>
<br>


<b>Roleplay Tenkaichi version 0.11c - 1/18/2018</b><br>
	<li>Increased skill leech chance slightly to address issues with leech rate.</li>
	<li>Spam message from spar activity fixed.</li>
	<li>New Mods.</li>
	<li>Mutation system reworked.</li>
	<li>You will no longer die due to swimming.  Energy gains reduced as a result.</li>
	<li>Removed temperature system until futher notice.</li>
	<li>Language gains improved.</li>
	<li>Improved Assess and Assess All. Admins can now see a stat's weight and a player's total weighted stats.</li>
	<li>Added new activities and redid the progress check system.</li>
	<li>Changed learn system for new abilities and rebalanced them.</li>
	<li>Increased global chance to dodge.</li>
	<li>Nerfed fruits.</li>
	<li>Gravity machines can be upgraded up to your skill limit, but the field strength is limited by admins/year.</li>
	<p>
<br>

<b>Roleplay Tenkaichi version 0.11b - 1/14/2018 - 1/16/2018</b><br>
	<li>Power Control fixed again.</li>
	<li>Ki Blade damage nerfed.</li>
	<li>Activity Fixes pt 1.</li>
	<li>Planetary Gravity Fixed for various planets.</li>
	<li>Regen nerfed in general, especially while fighting.</li>
	<li>Sky Break fixed.</li>
	<li>Multiperson sparring stopped.</li>
	<li>Additional measures/work around for last clientless mob bug.</li>
	<li>Mana/Resource activities fixed. Need to click to turn in now.</li>
	<li>Advanced sense modes, thanks Bryce_Hego.</li>
	<li>Sword accuracy buffed 10%.</li>
	<li>Additional save back up parameters.</li>
	<li>Fixed ship interaction with planets.... Chewyy.</li>
	<li>Health Regen buffed.</li>
	<li>Attack damage increased.</li>
	<li>Dash Attack Bug that caused you to not attack fixed.</li>
	<li>Beams on the edge of the map bug fixed.</li>
	<li>Oozaru nerfed.</li>
	<li>Changeling Forms buffed.</li>
	<li>Additional controls for admins.</li>
	<li>Rewards tweaks.</li>
	<li>Global damage lowered.</li>
	<li>Warp nerfed.</li>

	<p>
<br>

<b>Roleplay Tenkaichi version 0.11a - 1/13/2018</b><br>
	<li>Leeching rate stabilized.</li>
	<li>Power Control bug fixed.</li>
	<li>Rollback bug fix 1.</li>
	<li>Other various bug fixes.</li>
	<p>
<br>

<b>Roleplay Tenkaichi version 0.11 - 1/12/2018</b><br>
	<li>Rebalanced activities and added a few new archtypes, will continue to add/rebalance in this manner for some time.</li>
	<li>UI improvements.</li>
	<li>More bugfixes.</li>
	<li>Gains tweaked.</li>
	<li>Added Energy Gain setting for admins.</li>
	<li>Added a guide verb, thanks to WolfxOmega.</li>
	<li>Added dynamic Ranks enabling/disabling.</li>
	<p>
<br>
<b>Roleplay Tenkaichi version 0.1a - 1/11/2018</b><br>
	<li>Lots of various bug fixes.</li>
	<li>Yep, mostly bug fixes.</li>
	<p>
<br>
<b>Roleplay Tenkaichi version 0.1 - 1/1/2018 - 1/10/2018</b><br>
	<li>12 Month Year</li>
	<li>Added new admins</li>
	<li>Fixed various custom skills</li>
	<li>IC Text color for emotes</li>
	<li>Fixed various admin verbs/systems and restructured admin levels</li>
	<li>Altered some Communication verbs</li>
	<li>Added mutation system, mods are no longer viewable as a result. You now can only see the raw stat and the %.</li>
	<li>Added a confirmation proc. Anything that should ask you to confirm something should use it. Report anything that doesn't ask properly.</li>
	<li>Various text handling improvements</li>
	<li>Added a language system</li>
	<li>Improved AFK system</li>
	<li>Better Body Parts</li>
	<li>Better Contacts</li>
	<li>Better Factions</li>
	<li>Status Bars</li>
	<li>Added several melee skills</li>
	<li>Debugged a bunch of crap that I didn't keep track of.</li>
	<li>Added Throw/Better Grabs</li>
	<li>Made the gods happy by removing armor and sword clutter from tech tab.</li>
	<li>Added a bunch of skills to make combat more exciting.</li>
	<li>SSj and some transformation systems revamped. Will eventually redo entirety.</li>
	<li>Daily Activity system. Eventually culminating into weekly events in a future update.</li>
	<li>Rules implemeted.</li>
	<li>Added stuff to make magic users feel important too. -Probably- not OP.</li>
	<li>Added Pods MKIII and a special ship for Space Pirate King.<br>
	<li>Added new ranks.</li>
	<li>Switched to way better maps. Special thanks to Chewyy for his hard work.</li>
	<li>Brought back a new system of FBM. For now, flushes out the non transformation races in the mid-late game and eventually allows the transformation races to catch back up.</li>
	<li>Made it so the body size window doesn't say \"p\" like in all the other rips out there. You'll never unsee it now.</li>
	<li>You don't leech gain mult.  If you are sparring someone with higher gain, your gain increases quicker, but you do not directly leech it in anyway. (Exception is if your gain is less than 10% theirs in which case you do leech it.)</li>
	<li>Body Parts use this formula: MaxHealth=80+(10*(ResMod*0.5+EndMod*1.5))</li>
	<li>Better RP Mode.</li>
	<li>Tweaks to Makyo Star Boost forumla.</li>
	<p>
	"}

var/OldUpdates={"
<br>
Before anyone asks why I haven't removed this or changed all of the Xenospheres to RT, it's because here we aren't ashamed of what we are.
Finale and its offspring are rips of rips of rips. That means that we are the collective years of work of a great deal of people, and we owe our own
success to all those that have come before us.  Ginseng gave us the Xenosphere code to produce a great game for the players, and that's what we're going to do.
<br>
<ul>
<b>Xenosphere Beta V.003 - 12th of July, 2016.</b><br>
	<li>Status tab now displays the total overall number of role play points you have earned on your character.</li>
	<li>Only Android Ship spawned Androids can set their frequency to the default communication channel of their starting scanners.</li>
	<li>Being afk now adds to your rested role play points, which means you gain a bonus to how many rp points you earn. This should help those who are afk at work or in a time zone that doesn't correlate with peek times, in catching up to others who constantly rp.</li>
	<li>No longer able to gain transformation mastery while afk.</li>
	<li>Changelings can now select their starting icon correctly.</li>
	<li>Role Play Points used on Battle Power are a little over twice as effective.</li>
	<li>New tech item. Adamantine Skeleton, which costs 100,000,000 resources on a genius level alien. Applying it to your character adds 10% to your durability and prevents limb damage. However, using it without 80 intelligence has a 50% chance to kill you.</li>
	<li>The Android Ship now starts with a set of security cameras which are linked to Android Ship created Androids starting scanners.</li>
	<li>Energy gained from Role Play Points were set to be a static number. RRP's X 50 X EnergyMod = Result</li>
	<li>Magic/Intelligence exp from RPP's were doubled.</li>
	<li>Resource/Mana gains from RPP's were doubled.</li>
	<li>Android Upgrade Components had the max they can upgrade an Androids energy mod to 5, instead of 10. Androids were refunded any investment also.</li>
	<li>Magicial Healing used to heal 25% of an injury, now it only heals 10%.</li>
	<li>Says, Whispers and Telepaths now all count toward your rp points earned again.</li>
	<li>It's now only possible for one rare of each type to spawn.</li>
	<li>New characters past year 10 will now be given automatic gain boosts based on the year to help them catch up.</li>
	<li>Ancient Vampires infection now costs them 1000 of their max energy and 10% of their current stats.</li>
	<li>Sounds and music, credit to Xiathyl.</li>
	<li>Can grab pods again, just not in space.</li>
	<li>The damage guns were doing were lowered to better match the mod changes from the last large update.</li>
	<li>Creating portals via magic no longer allow you to do so between the AL and LR.</li>
	<li>Bug fix for planets spawning inside bases in space upon reboot.</li>
	<li>Piercer must charge now before it can fire, instead of being available instantly.</li>
	<li>Kaioken/Spirit Bomb/Instant Transmission can't be taught except by the rank holder linked to those skills.</li>
	<li>Cyberize was disabled for now, until a better and newer system is in place.</li>
	<li>Anger should remain now, unless you meditate, get koed or start to self train.</li>
	<li>Admin verb Give Rank can now also be used to remove someone as a rank if needed.</li>
	<li>Earth Gurdian now starts with a special crystal ball which doesn't need mana to use, but can only spy on people who are on the surface of Earth.</li>
	<li>Should now be impossible to travel between the AL and LR via teleport pads.</li>
	<p>
<b>Xenosphere Beta V.002 - 10th of July, 2016.</b><br>
	<li>Fixed several run time errors and divisions by zero.</li>
	<li>Fixed a bug with security cameras not being able to be assigned a password.</li>
	<li>Only Androids can pilot the Android Ship now.</li>
	<p>
<b>Xenosphere Beta V.001 - 2nd of July, 2016.</b><br>
	<li>Android bridge's mainframe now spawns an AU component every month.</li>
	<li>Clicking the Android ships mainframe now removes only one AU Component at a time.</li>
	<li>When a player clicks a mana pylon, a magical link chains them all together and the mana from any pylon within that link, are moved to your location and absorbed into your mana stack.</li>
	<li>Newly created realm portals can now be closed permanently by the creator and for a small refund.</li>
	<li>Gravity gains were made a bit better.</li>
	<li>Fixed a bug where some ranks weren't being given full body when assigned their rank.</li>
	<p>
<b>Xenosphere V.000 - 2nd of July, 2016.</b><br>
	<li>Saiyan had their energy mods increased by 0.5.</li>
	<li>Bug fixed with saving and items vanishing.</li>
	<li>Ancient Vampire don't have anger, so instead they now do not lose power or speed when hurt, like Android.</li>
	<li>The max length of Emotes has been increased.</li>
	<li>Passive RP Point gains while not being afk were lowered.</li>
	<li>The time an Emote or other form of communication is open vs the time it was closed had its mathematics adjusted slightly to accommodate for faster typers so admins aren't alerted of legitimately typed text.</li>
	<li>Number of RP Points earned was halved, since it seemed people were capping at 5 a little too easily.</li>
	<li>RP Point cost for skills were adjusted slighty. Before it took on average about 2 IC years to gather enough points for a skill. Now it should be 3.</li>
	<li>The RP Point cap should now update correctly for people who were offline during a month change and missed out on their caps adjusting.</li>
	<li>Saiyans had their max angers raised to what they used to be at.</li>
	<li>No longer able to grab pods.</li>
	<li>Hacking Consoles can now be used to hack into anything that has a password protecting it.</li>
	<li>Demigod had their energy mod reduced by 1.</li>
	<li>Fixed a bug with using RP points toward Int/Magic gains.</li>
	<li>Another bug with rp points and caps has now been fixed, it can be used once more.</li>
	<p>
<b>Xenosphere V.000 - 19th of June, 2016.</b><br>
	<li>All rares have a much lower chance to spawn now and in some cases, only one will spawn per type.</li>
	<li>Power leech toggle was removed. It's now always on.</li>
	<li>DBZ race names added back in.</li>
	<li>Bug where super fly was giving more BP than Self Train was fixed.</li>
	<li>Bug where Power Armour was unequipping Android Scanners fixed.</li>
	<li>Expand now only increases strength by 20% instead of 40% per level.</li>
	<li>Expand now only increases dura by 10% instead of 20% per level.</li>
	<li>Heaven spawn was redone.</li>
	<li>Hell spawn was redone.</li>
	<li>Namek spawn was redone.</li>
	<li>Elite Saiyan is now available for every 4 non-elites online.</li>
	<li>Oni now have a magic mod of 4, like their tech mod.</li>
	<li>Fixed a bug with power armor not displaying the correct durability.</li>
	<li>New rare. Small chance for a Kynoshi to spawn as an Ancient Vampire.</li>
	<li>Ancient Vampire can detect people through walls, due to the energy signature their potential prey emit.</li>
	<li>Androids now have highly sophisticated and advanced sensors and can see through walls.</li>
	<li>Unable to blind Androids and Vampries using Taiyoken, but Taiyoken will hurt a Vampire and damage it a little instead.</li>
	<li>New roofs, walls and objects.</li>
	<li>There is now a very low chance to learn a skill even if someones skill leech is off, if your energy is very high.</li>
	<li>Having good relations or rival relations with someone increases the chance of learning a skill from them.</li>
	<li>All stat mods for all races, for all sizes, were rebalanced based on a much older version of the game.</li>
	<li>Kynoshi incline speed was changed from 6 to 2, meaning they mature alot quicker.</li>
	<li>Reverted the +25% bonus to Resistence and Durability, since the current stat mods should be more balanced.</li>
	<li>King/Queen of Vegeta now gain the ability to create artifical moons out of energy.</li>
	<li>King/Queen of Vegeta now gain the Power Control ability.</li>
	<li>No longer able to expand while in Power Armor.</li>
	<li>Limit Breaker is no longer available to mutant/aliens upon creation.</li>
	<li>Tech items now have serial numbers.</li>
	<li>Kaioshin and Namekian Elder start out with their potentials unlocked. Demon Lord starts out with their equivalent, Dark Blessing, unlocked.</li>
	<li>Bandages last quite a bit longer.</li>
	<li>Now only able to put a max of 5 points into a new characters stat mods using your stat point, unless playing an Alien, which allow for 15.</li>
	<li>Magic based healing is easy to get, so its effectiveness is now only 1/4 that of the rarer energy based healing.</li>
	<li>Suggested Ranks, an old verb that stated guidelines on playing a rank responsibly, was re-added.</li>
	<li>Oozaru was changed somewhat back to what it used to be, stat wise. Now, it only halves def. Instead of adding speed, it adds 50% dura. Instead of x5 bp, it only gives x2. It lasts twice as long as before.</li>
	<li>Contacts are now automatically added when you meet a new person for the first time.</li>
	<li>Bojack and Ki Burst were rebalanced to work better with the new stat mods.</li>
	<li>Third eye was rebalanced and changed. It's no longer based off anger.</li>
	<li>Android stat cap for upgrades were changed from 3 to 2 to reflect the new stat mods for all races.</li>
	<li>Android Upgrade Components were once again doubled in price, to reflect the new stat mods for all races.</li>
	<li>Limit Breaker was rebalanced to work better along side the new stat mods and now includes strength in its formula.</li>
	<li>Kaioken was rebalanced to work better along side the new stat mods, it now scales at a steady pace with your base bp too and doesn't remove as much def.</li>
	<li>Third eye was made twice as easy to attain, within a random perimeter of 1 - 50,000 base bp, instead of 1 - 100,000.</li>
	<li>Gravity machines were made cheaper.</li>
	<li>Gravity was reworked and rebalanced. Training in it will give you a slight boost to bp gains. Mastering it will also give a slight bp gain boost during and out of a gravity field.</li>
	<li>Gravity no longer kills, but it can crush you to a pulp.</li>
	<li>Planetary Gravity was added back in.</li>
	<li>Aliens can now choose from three types of transformation upon creation. Melee, Ki and Hybrid. Each one has a random requirement between 10,000 base bp and 300,000.</li>
	<li>New Injury System!</li>
	<li>New tab named Injuries, which lists how much damage has been done to each limb, as a percentage.</li>
	<li>Injuries so far include Hearing, Speech, Arms and Legs, Head and Torso, along with the inability to Mate.</li>
	<li>A head injury at 100% will half your Intelligence and Magic mods until healed.</li>
	<li>A torso injury at 100% will take 25% away from your available power and 20% from your energy.</li>
	<li>A throat injury at 100% will prevent you speaking until healed.</li>
	<li>A hearing injury at 100% will prevent you hearing until healed.</li>
	<li>Explosion has a 25% chance to cause your ear drums to explode if you're caught in it.</li>
	<li>A limb injury at 100% will break that limb and remove 20% from your Strength, Defence, Offence, Force and Speed.</li>
	<li>Having an injury produces a little bit of zenkai.</li>
	<li>Head injury at 100% will prevent telepathy.</li>
	<li>Meditating will heal your injuries quicker.</li>
	<li>An injury will heal fairly slowly, based on your regeneration mod.</li>
	<li>Bandages increase the rate you heal from injuries.</li>
	<li>Having death regen helps you heal slightly faster than normal.</li>
	<li>Regenerators increase the rate you heal from your injuries.</li>
	<li>Energy Heal and Magical Heal will restore a random damaged limb.</li>
	<li>When hitting someone with Ki or Melee attacks, there is a chance based on the damage done to you, that a limb will take a percentage injury.</li>
	<li>New verb, Injure. Used on KO'ed players to apply an injury of your choosing upon them.</li>
	<li>New verb, Toggle Pull Punches. Pulling your punches prevents injury in melee. You pull your punches by default.</li>
	<li>Boxing Gloves always force you to count as pulling your punches in melee.</li>
	<li>Cloner and Phylactery sickness. Applies all injuries apart from sight to the user.</li>
	<li>Limit Breaker and Kaioken will slowly injure the user.</li>
	<li>Using TriBeam will injure you a little.</li>
	<li>Training with an injured limb prevents it healing.</li>
	<li>Training with a broken limb makes it worse.</li>
	<li>Gravity will injure you slowly, based on how much you have mastered and how much you use.</li>
	<li>New Reward System!</li>
	<li>Role Play Points. They are shown under the Status tab, along with how many emotes and says total you have done.</li>
	<li>RP Points increase from using emote, say whisper and telepathy. They also increase slowly when not afk.</li>
	<li>The number of RP Points earned from using verbs that increase them is determined by how often you use them and how long the text is.</li>
	<li>RP Points are not biased and only take into consideration effort put into how often you rp and how much, not the quality, since quality can vary both in actuality and opinion.</li>
	<li>Typing spam or pasting too larger an emote vs how long the verb remained open for won't count toward RP Points and alerts admins, and can also get you banned in some cases for trying to abuse the system.</li>
	<li>New verb. Role Play Points. Allows you to trade your RP Points for Energy, BP and skills.</li>
	<p>
<b>Xenosphere Alpha V.051 - 11th of June, 2016.</b><br>
	<li>Blast, Charge, ect, now instantly destroy a wall, bot not a roof, when they hit them.</li>
	<li>Fire! Don't stand in it.</li>
	<li>Kyonshi now start with energy telekinesis.</li>
	<li>Anti-virus now cures Heart Virus. Increased its price slightly.</li>
	<li>Androids no longer have an energy signature.</li>
	<li>Androids now spawn from an Android Chassis on the Ship. Chassis can now also be named and players can choose specific ones to create into.</li>
	<p>
<b>Xenosphere Alpha V.050 - 9th of June, 2016.</b><br>
	<li>Fixed a bug preventing the correct use of Shunkan Ido.</li>
	<li>New tech item, bandages. Equipping them increases your regen by 25%, but they only last two minutes and can't be used in battle.</li>
	<p>
<b>Xenosphere Alpha V.049 - 8th of June, 2016.</b><br>
	<li>Using Examine then selecting a skill you have learned should tell you the year you learned it and from who.</li>
	<li>LSSJ now only unlocks at year 10.</li>
	<li>LSSJ can only transform after the first SSJ, or as the first SSJ in future wipes.</li>
	<li>May have fixed a bug with doors and magic portals stacking on reboots.</li>
	<li>Contact familiarity was fixed and now raises correctly.</li>
	<li>Ancient Namekians starting ship had its speed increased so it doesn't just get left in one spot the whole wipe.</li>
	<li>Bio Android had its forms adjusted and were balanced better.</li>
	<li>Number of years before being able to teach someone a newly taught skill you have learned lowered from 10 to 5.</li>
	<li>Fixed a possible bug with absorbed bp and also lowered the time it takes for the absorb to fade away from 2.5 years to 5.</li>
	<li>Fixed a bug with an admin panel displaying player rank afk time incorrectly.</li>
	<li>Text indication when an Aquatian transforms.</li>
	<li>Aquatian forms BP's and starting BP were adjusted to be much closer to the show they're based on.</li>
	<li>Shunkan Ido was changed so you can only teleport to players in your contacts and only if you have 25+ familiarity.</li>
	<li>Added a Donate tab.</li>
	<p>
<b>Xenosphere Alpha V.049 - 31st of May, 2016.</b><br>
	<li>Fixed a bug where you can equip normal armour while wearing power armour. The two were stacking for unreasonable defence chances and enchantmeant gains.</li>
	<p>
<b>Xenosphere Alpha V.049 - 30th of May, 2016.</b><br>
	<li>Possible fix for an item duplication bug, and at the very least, a tidy up of old saving code.</li>
	<li>Fixed a bug with Lesser Teleport.</li>
	<li>Players must of had a skill for ten years before being able to teach it freely. This is mainly for balance purposes, but roleplay wise, we can assume that the student doesn't have enough experience. Ranks are able to teach skills straight away.</li>
	<p>
<b>Xenosphere Alpha V.049 - 29th of May, 2016.</b><br>
	<li>Android Upgrade Components now recalulate your current stats based on your new mod and adjust them accordingly.</li>
	<li>Bio Android's Imperfect form, after absorbing their 1st Android, no longer has a 75% nerf on Regen/Recov and is instead 25%.</li>
	<li>Being KO'ed didn't seem to reset your expand if it was in use, this should be fixed now.</li>
	<li>Death now cures the Heart Virus.</li>
	<li>LSSJ have .2 more recov and .5 more energy to their mods.</li>
	<li>LSSJ's SSJ2 form is now equal to a Low/Normal/Elite's SSJ1. SSJ1 on LSSJ can be considered as a restricted SSJ form.</li>
	<li>New tech item - Android Chassis. It costs 30,000,000 resources on a genius level mutant. When a player creates an Android, they have a chance to spawn into the new Chassis.</li>
	<p>
<b>Xenosphere Alpha V.048 - 25th of May, 2016.</b><br>
	<li>Imitate can be used on afk people now correctly.</li>
	<li>Makyojin expand doesn't drain as much.</li>
	<li>Lowered the percentage chance of rolling each rare race depending on their popularity, for the moment.</li>
	<li>No longer able to downgrade doors.</li>
	<li>New icon for Makyojin expand.</li>
	<li>Reverted the -25% damage nerf to Blast, since the +25% Resistence made Force 50% weaker overall.</li>
	<li>Tweaks to Blast relating to Speed Mod, and possible fix to Focus making Blast slower instead of faster.</li>
	<li>Should be able to upgrade Magical doors with the Enhance verb now.</li>
	<li>The range limit on Shunkon Ido was removed, but the mastery/skill level you aquire from using it still counts to how long it takes to use.</li>
	<li>The verb to make doors unable to be hacked is now Enchant instead of Enhance.</li>
	<li>Added an option to countdown that displays when you're close to 0 by doing a 10-0 mini countdown at the end.</li>
	<li>Energy gains were increased slightly to compensate for some of the balance changes.</li>
	<li>Fixed a bug with magic doors where it would cost 200,000 resources to upgrade, instead of 40,000 like other doors.</li>
	<li>All ki skills like Charge, Sokidan, ect, had their charging times halved in hopes we can see them used more in pvp instead of massive Blast spam.</li>
	<li>Fixed a calculation error with the new +25% dura buff that actually made it weaker.</li>
	<li>Explosion will now toggle off once used, so there's less risk of accidently leaving it on.</li>
	<li>Activation of the Focus skill looks better. Plans are to add flashy graphics to most skills if possible..</li>
	<p>
<b>Xenosphere Alpha V.047 - 23rd of May, 2016.</b><br>
	<li>More resource pool respawning fixes and tweaks.</li>
	<li>Adjusted blocking so it halves damage.</li>
	<li>Adjusted the melee calculations for dodge to include speed mod instead of the old speed stat. Thanks to Adamrpg and Nevets for their help.</li>
	<li>Fixed a bug where off was gaining twice as fast as def when training.</li>
	<li>Fixed yet more bugs with shield.</li>
	<li>Reboot now disconnects everyone from the server the moment the reboot message appears. Done to prevent item duping.</li>
	<p>
<b>Xenosphere Alpha V.045 - 22nd of May, 2016.</b><br>
	<li>Another fix to shields.</li>
	<li>Damage from blocking is no longer halved, but takes 1/3 off the damage instead now.</li>
	<li>Speed now factors more into how fast you can blast.</li>
	<li>The 25% increase to defence was removed in favour of the new blocking mechanic.</li>
	<li>Blast had its damage reduced by 25%. This is very experimental and I want to see how this pans out.</li>
	<li>Piercer now starts off at x4 charge, instead of x6 and charges at the same power rate as Final Flash.</li>
<p>
<b>Xenosphere Alpha V.045 - 22nd of May, 2016.</b><br>
	<li>The drain on expand was increased ever so slightly.</li>
	<li>Tweaked resource spawns again on planets.</li>
	<li>There is now a chance equal to your defence stats, that a melee attack/blast is blocked if a roll to dodge is failed. Blocking takes 50% damage off an attack. A block is indicated now by the tiny shock wave that used to appear in battle.</li>
	<li>The Majin race had their stats balanced and improved.</li>
	<li>There is now a 2% chance that the option to create a Majin will appear on your race selection menu.</li>
	<li>Majin start trapped within a randomly selected realm and must wait for someone to open a portal to it.</li>
	<li>Bojack and Ki burst now only need 10,000 bp to use, instead of 15,000.</li>
	<li>Bojack and Ki Burst drain like SSJ, but can be mastered.</li>
	<p>
<b>Xenosphere Alpha V.044 - 20th of May, 2016.</b><br>
	<li>Max dmg telekinesis can do capped at 10% HP.</li>
	<li>Energy absorb - Absorbs half as much energy from someone. Also fixed a bug with it.</li>
	<li>Android upgrade component had its price halved.</li>
	<li>New build menu.</li>
	<li>Adjusted resource spawnings on planets to scale with the year and made all places start with a moderate cache of resources to exploit.</li>
	<li>Locked doors are now only built within the tech menu and cost 100,000 resources on a genius level mutant. They can be upgraded like walls.</li>
	<li>Taiyoken won't last as long.</li>
	<li>Calculations for Endurance and Resistance were changed so fights last a bit longer.</li>
	<li>New icons/objs to build/place.</li>
	<li>Shield will now instead take 25% of the energy you use for Recovering and convert it into a shield which increases your Resistance by 25% while active.</li>
	<li>Digging manually now takes resources from the planets resource pool.</li>
	<li>Stat gains were nerfed slightly, as some changes to the code a while back made them too high.</li>
	<li>Shoud now gain quicker stats only when appropriate to your standing on the stat rankings.</li>
	<li>Android now start with a 2 bp mod again and a 3 energy mod.</li>
	<li>Android now start with a built in scanner.</li>
	<li>All smalls with mods below 1 were adjusted to 1.</li>
	<li>Pikkon have better and more balanced stats now.</li>
	<li>Large Demigod was made 0.2 faster.</li>
	<li>Slight nerf to medium Demigod stats.</li>
	<li>Celestial mods were adjusted to be better, especially for larges.</li>
	<li>Beastmen now decline at 40 instead of 30.</li>
	<li>Beastmen have a 25% chance to catch a Heart Virus when they land on Earth and leave a ship/pod, for the first time, before year 20.</li>
	<li>Slight buff to resources on all places apart from Ice.</li>
	<li>Expand now drains half as much energy as Focus does when in use.</li>
	<li>No longer able to land a ship or pod onto solid walls when landing.</li>
	<li>5% chance for an Android to spawn as an Ancient Progenitor; a fully upgraded mechanical being left over from a long forgotten fallen empire.</li>
	<li>5% chance for an Beastman to be born with an unstable Legendary gene.</li>
	<li>5% chance for an Earthen to awake as an Ancient of their species.</li>
	<li>5% chance for an Android to be created as a Biological Android.</li>
	<li>The server/code only allows you one chance every 10 ic years to roll a rare, so remaking for another chance is impossible until then.</li>
	<li>-1% chance per player with a rare of that type on subtracted from the chance to roll a rare of that same type.</li>
	<p>

	<li>Oni now spawn in the checkpoint.</li>
	<li>Cloning tanks now break once the clone inside activates and require half their cost in repairs to use again.</li>
	<li>Telepathy can no longer be learned naturally, only certain ranks can attain it.</li>
	<li>Magic system!</li>
	<li>New resource, Mana. Gained from focusing on magic levels or from the harvest of local ambient mana via pylons.</li>
	<li>The Makyo Star doubles all mana generated each month on the month it comes out.</li>
	<li>New meditation options. Focus on Intelligence or Magic.</li>
	<li>Magic Potential, a new variable that determines how good a race is at magic. Kaio, Demon and Mayko are the best. Earthen, Kynoshi and Oni are second. Humans and Pikkons are about half as good as the best races.</li>
	<li>Magical Attunement, a new starting trait for mutants that acts how the Genius trait does for technology, only it's for magic.</li>
	<li>Telekinesis and Magical Telekinesis. The former can be chosen as a new trait for mutants and makes use of energy to move objects and players. The latter makes use of mana as a resource and is unlocked at 60 magic skill. Both are used by holding a click on an object/player and dragging it around the screen. You can also throw items into people to harm them based on either your max energy or magic level.</li>
	<li>Demon Lord and Kaioshin start with both versions of Telekinesis unlocked.</li>
	<li>Changeling Lord starts with Telekinesis.</li>
	<li>Earthen Elder gains +1 Magical Poetential when ranked, making him as good as a Makyo.</li>
	<li>Each realm/planet has mana, like they do resources. The afterlife has the most, where as Namek, Earth and Arconia have half as much.</li>
	<li>New magic item, Mana Pylon. Acts like a tech drill and extracts ambient mana from planet/realms.</li>
	<li>New magic item, Crystal Ball. Once enough mana is added to the arcane device, it allows players to observe others.</li>
	<li>New magic item, Magic Circle. Sitting in the middle will increase the rate you gather ambient mana. It is also used in some advanced rituals.</li>
	<li>New magic item, Spell Book. When kept on you, increases the amount of ambient mana absorbed. When clicked, it can also be used to cast certain spells which unlock at certain magic levels.</li>
	<li>New magic item, Mana Vault. Like a tech safe, it can store mana and keep it secure.</li>
	<li>New magic item. Phylactery. Like a cloning tank, only the user dies if the item is destroyed. It also doesn't incur a decline lose.</li>
	<li>New spell, Heal. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to heal others.</li>
	<li>New spell, Create Portal. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to do one of two things. Either create a portal from one location to another that lasts a small amount of time, or create a Realm of your own, sort of like with ship creation, only the portal is permanent and can't be moved or closed.</li>
	<li>New spell, Enchant. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to enchant swords and armor with percentage bonus stats, up to +5% per piece.</li>
	<li>New spell. Lightning Bolt. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to send bolts of pure magical energy into the ground, damaging items and players.</li>
	<p>
<b>Xenosphere V.040 - 16th of January, 2016.</b><br>
	<li>Fixed another bug with adding resources to walls.</li>
	<li>Added Pikkon back as a race you can choose.</li>
	<li>Made it so there's no anger fail or cooldowns between anger.</li>
	<li>Emote now shows a typing overlay.</li>
	<li>Added a new tech item, the Boxing Glove, which makes you do 10 times less damage in melee, good for sparring. Icon courtesy of Alfogus.</li>
	<li>Sparring/Punching bag gains were made twice as good.</li>
	<p>
<b>Xenosphere V.039 - 7th of January, 2016.</b><br>
	<li>Moons are now unlocked at Intelligence level 100 and cost 20,000,000 resources on a genius-level mutant.</li>
	<li>Moons can only be used once every 3 months and if used near players who have a cooldown on their moon usage, the moon won't effect them. Natural moon transformations will still trigger once per year.</li>
	<li>Upgrading walls with resources was made twice as good.</li>
	<li>Power armor now increases raw power by +33%, instead of +25%.</li>
	<li>Defence bonus lowered from +50% to +33%.</li>
	<li>Moon transformations don't shake the screen nearly as much.</li>
	<li>Motion detectors will only activate near players now, instead of also split forms and drones.</li>
	<li>Low class now have a 2 bp mod, normal class a 2.2 and elite a 2.4.</li>
	<li>Human now start with a 1.5 bp mod, instead of only 1.</li>
	<li>Made Oni have slightly better off/def stats, speed and recovery.</li>
	<li>The Demon Lord can now observe those they have given Majin.</li>
	<p>
<b>Xenosphere V.038 - 17th of December, 2015.</b><br>
	<li>Fixed a bug with energy leech that made players able to gain far in excess of what their mods would normally allow via sparring.</li>
	<li>Android upgrade component is now 20,000,000 instead of 10,000,000, for a Genius-level mutant.</li>
	<li>Changed auto-repair/revive chance for Android to respawn back on their ship from 90% to 50%.</li>
	<li>New tech item, Power Armor. Unlocked at 120 intelligence and requires 200,000,000 resources on a genius-level mutant. Acts as normal armor, but gives +25 to Strength, Durability, Resistance and Power but -25% Speed. You also need 100 intelligence to enter it.</li>
	<li>Being absorbed, even if you have regeneration, kills you, since all available matter to regenerate from is transfered into power and used by the absorber.</li>
	<li>Defence is now +50% more effective than before.</li>
	<li>Contacts were re-added. They don't actually do much beyond keeping track of who you've met and what they look like just yet though.</li>
	<li>New tech item. Motion Detector, costs 100,000 resources on a genius-level mutant and unlocked at 30 intelligence.</li>
	<li>New tech item. Security Camera, costs 100,000 resources on a genius-level mutant and unlocked at 30 intelligence.</li>
	<li>You can now add extra resources to your walls to enhance them further.</li>
	<p>
<b>Xenosphere V.037 - 9th of December, 2015.</b><br>
	<li>Head admins can now toggle global reincarnation on and off. It is off by default.</li>
	<li>Expand will now only give +40% strength, instead of +50%.</li>
	<li>Majin for Demon now only gives +75% to power, as opposed to +100% before.</li>
	<li>Demon and Celestial will mature around age 18, instead of 32.</li>
	<li>Mystic now gives +30% power to Celestials and +15% to non-Celestials.</li>
	<li>Celestials now unlock their Observe skill at 1000 energy, instead of starting with it straight away.</li>
	<li>Limit Breaker previously had a 2% chance to KO the player every 2 seconds. It now has a 1% chance.</li>
	<li>Androids now start at 1 in every mod and can't choose a body size, but they have become highly customizable mod-wise via tech items.</li>
	<li>New tech item. Android Upgrade Component which is unlocked at intelligence level 40, costing 10,000,000 for a Genius-level mutant.</li>
	<li>Android Upgrade Components can be used on Androids to upgrade one of their mods by +0.1, or in the case of energy, +0.5, up to a max of 3 or 10 for energy.</li>
	<li>Small tweak to Focus, making it drain slightly less.</li>
	<li>Explosion now has a 25% chance to force someone to land, the power from the vacuum caused by the attack sucking its victim to the ground.</li>
	<li>May have fixed an issue that was causing crashes, along with a few smaller problems that may have contributed to accumulative chances of crashing the game.</li>
	<li>Made Self Destruct not randomly leak and adjusted and balanced the damage it caused.</li>
	<li>Spirit Dolls/Kyonshi now start with around 50% of their power, instead of only just 30%.</li>
	<li>Expand now gives +5% resistance per level.</li>
	<li>It should take twice as long to drown now if you're not being carried through water while ko.</li>
	<li>A new reward system has been added for the admins to make use of.</li>
	<li>Safes unlock at intelligence level 40 and cost 1 million resources for a genius level mutant.</li>
	<li>Kaioken can only be used at half its power now whilst dead.</li>
	<li>Fixed a bug where Solar Flare disabled your ability to see Says and Emotes.</li>
<p>
<b>Xenosphere V.036 - 2nd of December, 2015.</b><br>
	<li>Dig now has a cooldown between its uses, to prevent an issue with stacking.</li>
	<li>May have fixed a bug with Fly where if you spammed it, the skill would disturb your flight.</li>
	<li>Fixed a bug with Grab where you could make players and items teleport to you.</li>
	<li>Notifications for when a player charges and fires a beam.</li>
	<li>Magic balls no longer delete or become stuck when you log out in a pod.</li>
	<li>Head admins can now respawn global planet resources instead of rebooting the server</li>
	<li>You can now use the Remove verb on doors you own to delete them.</li>
	<li>Shockwaves damage was greatly reduced.</li>
	<li>Notifications for when a player equips armor and weapons.</li>
	<li>You can now unbolt items.</li>
	<li>Teleport pads can be bolted.</li>
	<li>Made Shockwave less laggy.</li>
	<li>Bojack now only gives +50% Strength and Endurance instead of +100%.</li>
	<li>Ki Burst now only gives +50% Speed instead of +100%.</li>
	<li>In regards to the Bojack/Ki Burst adjustment, these are subject to change and seem to be a way to balance them better. Especially seeing as at the time of writing this, going Expand x2 in Bojack is prohibited. Hopefully that can change soon.</li>
	<li>Fixed a bug where Focus drains were stacking.</li>
	<p>
<b>Xenosphere V.035</b><br>
	<li>The Amulet is no longer capable of sucking in doors and bolted items.</li>
	<li>Yes/No promps were added to certain admin verbs to avoid mistakes.</li>
	<li>Shadow Spar has been disabled for the moment due to many bugs. It was never actually added into the game anyway.</li>
	<li>Fairly certain that the bug where you are spam killed by beams and the likes has been fixed.</li>
	<li>Force fields become stronger when upgraded, based on the year, to help mitigate growing bp/force.</li>
	<li>Shield was adjusted to take less energy away.</li>
	<li>Certain vars like Super Tuffle are now hidden from admin edit and can only be granted by a head admin now or unlocked upon creation as normal.</li>
	<li>The Countdown verb has been fixed, it will now also display to everyone within 20 tiles and even through walls.</li>
	<li>Changed Third Eye so you can't buff into it via Expand/Focus, ect. Lowered the require of Third Eye from between 1 bp and 1,000,000 current bp to 1 and 100,000 base bp. </li>
	<li>Added a RNG to the admin verbs so admins can fairly roll a number between a lowest and highest setting which is then added to the logs and recorded for the team to see.</li>
	<li>Self train and Meditate now give the same bp.</li>
	<li>Fixed reverse sparring.</li>
	<p>

<br><br><b>Xenosphere V.03306</b><br>
	<li>Fixed contacts. </li>
	<li>Added a check to make sure AI is not activated when they're in the 'Death' area.</li>
	<li>Added an extra area called 'Limbo' and created a box on the map where the players will be sent to when they have a cloning tank, previously this was the same area NPCs were sent to awaiting a respawn.</li>
	<li>Changed the way digging checks for multiple instances. Propagated this check to training and digging.</li>
	<li>Made sure that looted armor does not auto-equip onto the robber, allowing infinite stacking of armor.</li>
	<br><br>

<br><br><b>Xenosphere V.03305</b><br>
	<li>Altered the structure of the event scheduler to attempt to address an issue causing crashing.</li>
	<li>Added an if null check to a client.address issue with emote.</li>
	<li>Removed a bug that was causing crashes with PC.</li>
	<li>Fixed a bug with train timers that could cause a crash.
	<li>Fixed a bug with scanning that could sometimes omit mobs.</li>
	<li>Fixed a very rare bug with reading a save that could cause it to register as a NPC save file.</li>
	<li>Increased the number of checks to cancel scheduled events on mob deletion and logout.</li><br><br>

<b>Xenosphere V.033042</b><br>
<li>Added a clause to mob deletion that should catch bad event scheduler calls that weren't terminating properly.</li>
<li>Added a clause to attack to handle a null.KB error that was initiating within a while loop due to logout and scheduler related issues.</li><br><br>

<b>Xenosphere V.033042</b<br>
	<li>Fixed an exploit that could allow players to stack stat gains.</li>
	<br><br>

<b>Xenosphere V.033041</b><br>
	<li>A new tech item, the altered teleportation watch, has been added in along with a new tier of travel gear progression.</li>
	<br><br>

<b>Xenosphere V.03304</b>
	<li>Added in a new base for male and female Aquatians and white male humanoids.  Enjoy the new animations, slightly bigger icons, and higher detail they have!  Raws for the artistic types will come once every race icon is done.</li>
	<li>Removed a pesky bug with power control that was causing crashes when used in conjunction with variable gravities.</li>
	<li>Modified the hair selection code to account for the larger bases.</li>
	<li>Removed a rare bug that could cause a crash on firing null beams.</li>
	<li>Added an experimental fix to stop the calling of null events.</li>
	<li>Fixed an error that could sometimes cause a crash mid-wipe.</li>
	<li>Added in a number of new turfs in preparation for the introduction of the new map.</li>
	<br><br>

<b>Xenosphere V.032 (Part 2 of 3 -  Part Two:  New Base Icons, Intelligence Energy Gain Revamp, Aquatian Base Graphical Revamp, Beastman KO Gains Revamp)</b><br>
	<li>Altered the path for PC to a more generalized setting, instead of being player specific.</li>
	<li>Numerous bug fixes.</li>
	<li>Added a check for power control to ensure that their user's ID was not applied to a NPC or non-valid mob</li>
	<li>Implemented numerous defensive programming measures against issues with scheduling events and loading saves.</li>
	<li>Aquatians are no longer genderless.  Currently, only male gender Aquatians can be made.  This will change once the female icon goes live for usage.</li>
	<li>Added in energy gains for meditating while leveling intelligence.  After testing, the lack of energy gains while meditating proved to be somewhat grindy for intelligence focused characters wanting to do something other than crafting.</li>
	<li><b>Added in new base icons for humanoid races.</b>  These icons are the new standard for humanoid races, and are vastly improved over the prior base icons.  The base possesses animated idle states for each race and a much higher level of detail in the icon.  The enhanced detailing should also allow for more much easier production of varied and interesting clothing from both players and the game.  Aquatians currently use these new icons as their base form.  The male version is complete and live for player usage, with animated idle states.  The female version currently has a workable private beta, but requires a bit more touching up visually before I put the version with animated idle states live for player usage.</li>
	<li>Cleaned up the text in the character creation process for Aquatians.  The new character creation process will obsolete the stodgy process being used now, but until then a bit of readability for new players will probably be helpful.</li>
	<li>Updated the Aquatian placeholder text for race description during character creation to be a bit more accurate.</li>
	<li>Added in energy gains for meditating while obtaining intelligence at a coefficient of .001.</li>
	<li>Increased the meditation energy gain coefficient from .001 to .002. </li>
	<li>At the request of the hosts, i'm releasing part of this update early.  As a result, I am splitting the content of the update into 3 parts.</li>
	<li>Changed low type Beastmen's KO BP bonus to 10 from 3.</li>
	<li>Changed normal type Beastmen's KO BP bonus to 10 from 5.</li>
	<li>Altered the coefficient for blast energy gains from .001 to .004.</li>
	<li>Altered the coefficient for sparring energy gains from .004 to .009.</li>
	<li>Altered the coefficient for flying energy gains from .004 to .009.</li>
	<li>Altered the coefficient for absorbing maximum energy from people with higher maximum energy from .002 to .005.</li>


	<br><br>
<b>Xenosphere V.03158</b><br>
	<li>Increased Celestial endurance mods across the board by .2.</li>
	<li>Fixed a bug with reincarnate that was allowing people to avoid death.</li>

	<br><br>
<b>Xenosphere V.03157</b><br>
	<li>Redid the reincarnation formula for intelligence so that there is a 1:1 ratio for same race transitions, and appropriate decreases or additions in required XP for other races.</li>
	<li>Added a stand in var to fix another null.var error that was occurring on knockbacks.</li>
	<li>Added a stand in var to fix another null.var error that was occurring on attempting to scan for players.</li>
	<li>Fixed yet another null.var error being caused by Byond.  This one fixes power control.  This represents the last known bug on that front.</li>
	<li>Fixed a null.var error being caused by Byond.  This one was linked to gravity machinery, and will ensure that they can be run without crashing the core statistics processes.</li>
	<li>Removed a src.var reference in power drain, that was sometimes causing crashes.</li>
	<li>Fixed a bug that could temporarily halt gains.</li>
	<li>Added in a weather system.</li>
	<li>Fixed a bug (again) with Matter Absorption being chooseable multiple times in custom character creation.  This was not intended, and could lead to characters wasting trait points.</li>
	<li>Vastly reduced the amount of formulas used for stats being tracked by the dynamic content balancing code.  This should reduce the CPU load for weaker computers.</li>
	<li>Added a new variable to handle the assignment, collection, and calculation of the active playerbase's combined stat progression.  This stat was applied to every NPC, and may require some minor tweaking in terms of balance.</li>
	<li>Altered when the dynamic content balancing code triggers, making it trigger every twenty five minutes, as opposed to every time a NPC spawns.  This should reduce the CPU load for weaker computers.</li>
	<li>Made optimizations to reduce the CPU load within the combat system.</li>
	<li>Increased the cooldown when hitting a bag to be equal to a normal attack.</li>
	<li>Made some optimizations to various background processes to lower the CPU requirements of hosting.</li>
	<li>Rebalanced the gains of multiple NPC's.</li>
	<li>Rebalanced the stat distribution of several high tier NPC's to make them more of a challenge.</li><br><br>
<b>Xenosphere V.03156</b><br>
	<li>Added in a small prototype mini dungeon on Earth.  This area contains mid tier mobs, and while currently unfinished will most likely serve as a testing bed for other features such as loot lists, bosses, NPC's using skills, controllable areas, and recruitable NPC's.</li>
	<li>Tweaked the gains of several mobs.  Several mobs had gains beyond their intended amounts.  This has been fixed.</li>
	<li>Added a new mob to the game.  This variant of bandit is stronger than the base type, scales, has its own unique clothing, and often attacks in much larger numbers.</li>
	<li>Tweaked the time to recalculate NPC Power after a reboot.  This should help ensure that NPC's are more challenging for "first in" players, making it harder to game the system.</li>
	<li>Added a penalty to reincarnation.  This is to offset the increased gains and remove an exploit.  It also gives benefits to not reincarnating.</li>
	<li>Added in a new "wish" type item, which can be crated by technicians.  This item is one of the higher end rewards from the yet to be implemented "Occult" tech tree.</li>
	<li>Added in a new "teleporter" type item.  It allows players to punch a hole through to the Afterlife and vice versa.  Anchoring two points can lead to a permanent route until one anchor is destroyed.</li>
	<li>Added in the framework for a NPC "uniform generator".  This system allows the game to create unique outfits for NPC's dependent on their profession and race while also randomizing each NPC so they they remain visually unique while following their profession's "theme".</li>
	<li>The current bandit NPC's are currently drawing from a (deliberately limited) testing list of clothing items, allowing them to look like human players.</li>
	<li>Added in a new NPC only piece of gear.  The goggles will be available as a rare drop off of Red Reaver bandits in one of the next updates.  This is to test the loot list system.</li><br><br>
<b>Xenosphere V.03155</b><br>
	<li>Added in new prototype respawn mechanics.</li>
	<li>Finished up the second part of the code that allows for faction NPC armies.  This is demonstrated on the new humanoid mob that was implemented this wipe.</li>
	<li>NPC AI type areas now have proper layering to allow for accurate weather effects.</li>
	<li>Updated the frontloaded blast on nukes to hit past walls that it can destroy.  This keeps it from deleting on contact with a wall it can destroy.</li>
	<li>Updated the planet destruction event.  It now contains updated special effects.</li>
	<li>Tweaked the Shade's stats..</li>
	<li>Decreased the overall time to activation for NPC's that are currently idling.</li>
	<li>Fixed a bug that was keeping the destruction of planets from firing properly.</li>
	<li>Added new graphics for a NPC type.</li><br><br>

<b>Xenosphere V.03154</b><br>
	<li>Changed the atmosphere of the ice planet to match the weather around the Aquatian spawn.</li>
	<li>Fixed the null.var bugs.</li>
	<li><b>Changed the way training works</b>.  Sparring with training NPC's or PC's now gives 2x gains.  Hunting NPC's now gives anywhere from 3x gains to 20x gains depending on the strength of the mob.</li>
	<li><b>NPC's now scale in power</b>.  Many NPC's now scale in relative power to the playerbase's average strength.  The scaling is dynamic.  For instance, a bandit might always be very weak compared to even new players.  However, a high level mob could be equivalent to the upper tiers of the stat and BP ranks.</li>
	<li>Added a new savable file.  NPCPower is now used to calculate the strength of NPC's, drones, and some weaponry and armor.  It is loaded on start up to calculate the initial spawn power for NPC's.</li>
	<li>Updated several craftable item icons.</li>
	<li>Added 122 new icons to the game, as part of the continuing icon update.  This places us at around 144 icons implemented out of the roughly 1000 new icons to be implemented.</li>
	<li>Removed shades from the desert region on Earth.  Shades are a top tier mob with equivalent top tier gains for killing them, however, with NPC's now having scaling power their overall power level is a bit beyond the average starting player on that planet.</li>
	<li>Added a large spawn of bandits at the desert region on Earth.  These mobs always have low BP by default, no matter what the average power of a wipe is.  This allows new characters to always be able to fight them for quick gains.</li>
	<li>Added a rare spawn of gremlins to the desert region on Earth.  These mobs have low BP by default, letting new players always be able to hunt them for early gains.</li>
	<li>Added a  new area to the IP, redoing the Aquatian spawn and adding an overlook to the island.</li>
	<li>Fixed a bug that could sometimes cause rare items to not be saved on shutdown.</li><br><br>


<b>Xenosphere V.03153</b><br>
	<li>Added a prototype of the Contacts system for public testing.  The Contacts features functions as both a friends and enemies list for IC characters, and has some minor hidden gameplay features.</li>
	<li>Added the ability for admins to silently message the game world for communication and story telling purposes.  This is available to any admin with beyond the probationary rank, and is titled "world narrate" in the commands.</li>
	<li>Fixed a bug with the new build code that was causing doors to spawn every reboot.</li>
	<li>Merry Christmas!  Added in roughly twenty new icons out of a range of almost 1000 at most.  These icons are part of a large number of assets I paid for the commercial rights too.  Further updates (Taking place immediately after this one.) will include more of the 1000 or so new icons as I convert them into a usable dmi. compatible format.</li>
	<li>Fixed a LARGE number of Byond-side null.var bugs.</li>
	<li>Resisted the urge to begin drinking heavily upon realizing how extensive the null.var bug was prior to the aforementioned fixes.</li><br><br>

<b>Xenosphere V.03152</b><br>
	<li>Fixed a typo in Fusion referencing a skill that no longer exists.</li>
	<li>Added an ASSERT(src.Str) call in the Stat Rank code.  May catch the last remaining null.var error.</li>
	<li>Removed a src.(var) call in the core stat code.</li>
	<li>Removed a src.(var) call in swimming for androids and demons.  The null.var Byond bug could chain outwards through other processes into causing fairly large stat gain issues if they attempted to enter any fluids.</li>
	<li>Temporarily removed a src.(var) call in Beastman character creation.  The null.var Byond bug was preventing Beastmen from making their characters properly.</li>
	<li>More fixes for a Byond-side error that hasn't been fixed on their end yet.</li><br><br>
<b>Xenosphere V.03151</b><br>
	<li>More fixes for a Byond-side error that hasn't been fixed on their end yet.</li>
	<li>Gave (un needed, but possibly useful in this case) definitions to a large number of variables classed under the var file in the hopes of preventing other runtime errors.</li>
	<li>Fixed a godawful number of runtime errors brought on by a bug with Byond.</li>
	<li>Fixed a divide by zero runtime error that could rarely crop up in the stat ranks.</li>
	<li>Fixed a bug that was causing people to intermittently not gain.</li>
	<li>Fixed a bug that had logs outputting as much gains as sparring did.</li>
	<li>Prototype death mechanics have been added.  The current prototype allows you to choose to reincarnate upon death, or continue to the afterlife.  As it is very new, some bugs may apply in this specific version.</li>
	<br><br>

<b>Xenosphere V.0315</b><br>
	<li>Aquatians are now immune to cold based damage</li>
	<li>World Narrate can now be used to narrate IC events in world without applying a name to the post.</li>
	<li>Fixed a bug that was causing periodic lag spikes.</li>
	<li>Demons no longer take damage or can die from lava.</li>
	<li>Demons no longer lose energy in lava.</li>
	<li>Aquatians can now breathe in water.</li>
	<li>Aquatians will no longer lose energy while in water.</li>
	<li>The ice planet now has weather effects reflecting it's dangerous climate.</li>
	<br><br>

<b>Xenosphere V.0314</b><br>
	<li>Holding items preventing you from drowning now fixed</li>
	<li>Don't piss in the pool kids. (KO bug now fixed)</li>
	<li>Added the 'Watch' command to Who for admins, as per requested by admins =)</li>
	<li>Added a sanity check in the statrank proc. Nothing the players will notice but hopefully deal with admin fuckups a bit.</li>
	<li>Changed how items are saved on the server.</li>
	<li>Changed how drills work in the background.</li>
	<li>Doubled the rate gravity mastery is gained.</li>
	<li>Slightly increased the BP gains from gravity training under gravity.</li>
	<li>Fixed a bug with absorb that was giving more power to the absorber than it should have.</li>
	<li>Increased the max craftable weight of materialize to the equivalent of a user's maximum energy.  Materialize previously capped out at previously half of a user's max energy.</li>
	<li>Added a new selection of learnable skills to several races.</li>
	<li>Lowered the energy requirements of almost every skill for every race, to reflect the current energy gain system.</li>
	<li>Added five new skills to the Celestial race.  These skills are Materialize, Fusion, Heal, Reincarnate (Rare), and an alternate form of revival that does not have any chance to kill the user (Very Rare.).</li>
	<li>The skill requirements for a Demon to learn imitate have changed so that it only requires five hundred energy to obtain.</li>
	<li>Imitate is now a "common" skill for Demons.  Every Demon has it as part of their learnable skill tree by default.</li>
	<br><br>

<b>Xenosphere V.0313 (Full)</b><br>
	<li>Removed a few debug verbs that did not belong in the player selection of verbs.</li>
	<li>Added a basic variant sidewalk tile for modern day environments.</li>
	<li>Added six damaged and cracked variants for sidewalk tiling.</li>
	<li>Added the basic variant street tile for modern day environments.</li>
	<li>Added a very large number of road markings and other similar objects for detailing streets and other locations.</li>
	<li>Added a new modern door type.  Glass doors fit especially well with the roof and modern door set in the next update.</li>
	<li>Added five new wall types.  These can be used by players to make modern buildings, and by admins to create modern skyscrapers and similar buildings with modeled interiors buildings using warpers.</li>
	<li>Added four new edge types.  These can be used to do the edges for various building types, or as makeshift "walls" similar to fences and the like.</li>
	<li>Added one new sign type.  The mailbox is a modern day variant to existing signs, and can be mounted on any tile.</li>
	<li>Added five new fence types.  Chain link fences can now be produced.</li>
	<li>Added three variants of traffic lights.  These can be mounted on any tile for visual effect.  The new version will include poles to place them on streets for extra decorative purposes.</li>
	<li>Added three new debris icons under the misc type tab.  These go well with destroyed or run down areas.</li>
	<li>Added two new fire types under the heatsource tab.</li>
	<li>Added two barrels from the basic variant.  The basic variant has both a normal and on fire version.  Lit barrels are located in the heat source tab.</li>
	<li>Added four damage overlays for all environments to the misc tab of props.  These have no density, and can be placed just about anywhere.</li>
	<li>A number of icons were held back in this update so as to facilitate getting it to the hosts on time.  The next update should include these icons, and possibly the various variant tilesets with them.</li>
<br><br>
<b>Xenosphere V.0312 - Test Build (Version 5)-</b><br>
	<li>Give Power can no longer be used to stack the extra recovery it gives you. (Thanks Burgle)</li>
	<li>Extra power is no longer retained when knocked out. (Thanks Burgle)</li>
	<li>Subcategories should now always load properly.</li>
	<li>The new build system has been adjusted to improve speed, will require feedback for possible further tweaking/adjusting.</li>
	<li>The Build verb has been removed and replaced with a panel that's integrated into a skin. A new window will no longer pop up.</li>
	<li>Admin help's spam filter has been adjusted.</li>
	<li>The Androidship is automagically spawned if it doesn't exist.</li>
	<li>Window focus defaults back to the map window when you select something in the build menu.</li>
	<li>Fixed a long standing issue with the admin and who panel where admins sometimes couldn't properly access player menus.</li>
	<li>The build menu was moved to a new window and sorted by category.</li>
	<li>The admin editing system has been changed using GhostAnime's library.</li>
	<li>Changed the way objects save, causing the map to load and save faster.</li>
</ul>

"}

var/New_Stuff={"

<html><head>
<title></title>

<meta name="save" content="history" />

<style type="text/css"><!--
.save{
   behavior:url(#default#savehistory);}
a.dsphead{
   text-decoration:none;
   color:white;
   margin-left:1.5em;}
a.dsphead:hover{
   text-decoration:underline;}
a.dsphead span.dspchar{
   font-family:monospace;
   font-weight:normal;}
.dspcont{
   display:none;
   color:white;
   margin-left:1.5em;}
//--></style>


<script><!--
function dsp(loc){
   if(document.getElementById){
      var foc=loc.firstChild;
      foc=loc.firstChild.innerHTML?
         loc.firstChild:
         loc.firstChild.nextSibling;
      foc.innerHTML=foc.innerHTML=='+'?'-':'+';
      foc=loc.parentNode.nextSibling.style?
         loc.parentNode.nextSibling:
         loc.parentNode.nextSibling.nextSibling;
      foc.style.display=foc.style.display=='block'?'none':'block';}}


//--></script>

<noscript>
<style type="text/css"><!--
.dspcont{display:block;}
//--></style>
</noscript>

</head><body bgcolor="#000000"><font size=3 color="#FFFFFF">

<b><u>Welcome!</u></b>
<hr>
<p>
Hello and welcome to Roleplay Tenkaichi!<br>
Thanks for joining us for the new wipe! A lot of things have changed so be sure to read the patch notes.<br>
Please join the discord and share your ideas and insights in order to make this the best place for DBZ RP.<br>
<br>
</p></font>
<hr>

<div class="save">

<h1><a href="javascript:void(0)" class="dsphead"
   onclick="dsp(this)">
   <span class="dspchar">+</span>Recent Updates</a></h1>
   <div class="dspcont">[Recent_Updates]</div>

<h1><a href="javascript:void(0)" class="dsphead"
   onclick="dsp(this)">
   <span class="dspchar">+</span>Old Updates</a></h1>
      <div class="dspcont">[OldUpdates]</div>
</div>

</body></html>
"}

var/Version_Notes={"
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
<html><head><title>Roleplay Tenkaichi!</title></head>
<body><a href="https://discord.gg/nqJWvbhfn9">Discord</a><br><hr>
Welcome friends, we are pleased to bring you to the culmination of a lot of hard work and planning.  Our goals are to deliver a fun, fair experience for everyone where the players
have the freedom and ability to create their own story and affect the story of others.  We pride ourselves in transparency and our goals of automation to remove the need for admin
intervention.<br><br>
We eagerly welcome any and all players who would like to apply for rares and ranks and ask that they do so through the provided links.<br>
Like you, we are also players and will play the game, but despite our titles of 'owner,' this game belongs to all of us.  Any player suggestions and feedback will be taken seriously
and valued as we continue to move toward the ultimate Dragon Ball roleplaying experience.<br>
<br><br>
The server is currently live! Join the server and make a character! Gains and year speed will be reduced for the first couple days to allow people to join and not be immeditely behind.
Anything you have access to on the character creation screen, does not require approval (Example; Changies, Yardrat, etc).  Things that do not show up, such as LSSj/Space Pirate, however do require an application.<br><b>
Thanks!
<br><br>

<font color=#33CCFF>
Join the Discord using the link in the top left under Help!



</body></html>
"}
/*
<a href="https://roleplaytenkaichi.com/guide/"> Guide </a><br><hr>
<a href="https://roleplaytenkaichi.com/rules/"> Rules </a><br><hr>
<a href="https://roleplaytenkaichi.com/apps/"> Applications </a><br><hr>
<a href="https://roleplaytenkaichi.com/story/"> In-Game Story </a><br><hr>
<a href="https://roleplaytenkaichi.com/feedback/"> Feedback & Suggestions </a><br><hr>
*/
var/mob/WritingUpdates



/*mob/verb/DB_BPs()
	set category="Other"
	usr<<browse(Battle_Powers,"window= ;size=700x600")
var/Battle_Powers={"<html><head><body><body bgcolor="#000000"><font size=1><font color="#CCCCCC">

These are the battle powers throughout the dragon ball chronology, as they would be if it had
happened within Finale. They are not all that different from the actual amounts, within reason. The
term "Max" refers to when their anger kicks in, and they hit the limit of their power.
<br><br>

Pre-Dragon Ball<br>
Bardock's Team in Oozaru = 40'000 to 60'000<br>
Bardock (base 300) = 6'000<br>
Toma (base 275) = 5'500<br>
Celipa (base 250) = 5'000<br>
Totepo (base 225) = 4'500<br>
Panboukin (base 200) = 4'000<br>
Tooro - Kanassan Warrior (base 200) = 4'000<br>
Tooro Limit Breaker = 8'000<br>
Bardock recovered from Kanassa (base 500) = 9'000<br>
Nappa (base 220, age 30) = 4'400<br>
Prince Vegeta (base 600, age 6) = 6'000<br>
Saibaman = 1'000 to 1'500 each<br>
Average Saiyan (100 base) = 2'000<br>
Alien Henchmen on Vegeta = 1'000 to 5'000<br>
Alien Henchmen from other planets = 5'000 to 20'000<br>
King Vegeta = 16'000<br>
Bardock angry from seeing his friends dead = 13'500<br>
Dodoria's Elite Squad = 5'000 to 7'000<br>
Dodoria = 18'000<br>
Zarbon = 20'000<br>
Frieza = 530'000<br>
Goku (2 base, age 1) = 2<br>
Paragus (40 base) = 800<br>
Broly (10'000 base, age 1) = 10'000<br>
<br>

Dragon Ball Beginning<br>
Grandpa Gohan (base 15, body 50%, age 55) = 150<br>
Goku (base 6, age 11) = 82<br>
Bear Bandit = 30<br>
Pterodactyl = 50<br>
Average Human = 20<br>
Average Human Fighter = 40<br>
Yamcha (base 4, age 15) = 60<br>
Roshi (base 29, body 20%) = 116<br>
Roshi 4x Expand = 232<br>
Roshi 5x Kamehameha 100% Mastered = 1'160 (Blew up a mountain)<br>
Goku 1x Kamehameha 10% Mastered = 9 (Dints a car lol)<br>
Krillan (base 4, age 12) = 48<br>
Tyrannosaurus = 160 to 200<br>
<br>

21st Budokai<br>
Goku (base 10, age 12) = 150<br>
Krillan (7 base, age 13) = 91<br>
Yamcha (5 base, age 16) = 80<br>
Bacterian = 20<br>
Ran Fuan = 30<br>
Namu = 100<br>
Giran = 130<br>
Namu Max = 150<br>
Krillan Max = 137<br>
Jackie Chun (base 30, body 20%) = 120<br>
Goku 3x Kamehameha 50% Mastered = 225<br>
Jackie Chun 2x Kamehameha = 240
Goku Max = 300<br>
Jackie Chun Max = 180<br>
Goku Oozaru = 3'000<br>
Jackie Chun x4 Expand = 360<br>
Jackie Chun 10x Kamehameha = 3'600 (Blows up the moon apparently)<br>
<br>

After recovering from the 21st Budokai<br>
Goku = 165<br>
Krillan = 93<br>
Yamcha = 82<br>
<br>

Red Ribbon Army<br>
Goku (base 11, age 12) = 165<br>
Seargent Metallic = 100<br>
Ninja Murasaki = 90<br>
Android 8 = 140<br>
Gum = 200<br>
Goku x4 Kamehameha 60% Mastered = 396<br>
Krillan after training with Roshi another month or two (9 base, age 13) = 117
General Blue = 140<br>
Pirate Robot = 140<br>
Mercenary Tao = 170<br>
Korin = 200<br>
Goku after Korin's "training", most of his new power is zenkai from getting his ass kicked by
Tao (base 12, age 12) = 180<br>
Goku Max = 360<br>
Yadjirobe = 150<br>
<br>

Baba Tournament<br>
Krillan after another Roshi training session (10 base, age 14) = 140
Goku (13 base, age 13) = 212<br>
Master Roshi (base 35, 20% body) = 140<br>
Yamcha after Roshi's training (9 base, age 17) = 153<br>
Devil Man = 115<br>
Mummy = 100<br>
Invisible Man = 70<br>
Dracula Man = 60<br>
Grandpa Gohan (16 base, 50% body) = 160<br>
Grandpa Gohan x3 Kamehameha = 480<br>
Goku x3 Kamehameha 75% Mastered = 477<br>
Goku Max = 424<br>
Grandpa Gohan Max = 240<br>
<br>

22nd Budokai<br>
Goku = 220<br>
Tien = 220<br>
Choutzu = 120 (Great skill masteries though)<br>
King Chapa = 110<br>
Tien theoretically without 3rd eye = 170
Yamcha = 159<br>
Krillan = 145<br>
Krillan x1 Kamehameha 50% Mastered = 73<br>
Yamcha x2 Kamehameha 70% Mastered = 223<br>
Tien's Ki Deflection Barrier = 330<br>
Tsurusennin (Crane Hermit) = 128<br>
Jackie Chun (36 base) = 144<br>
Jackie Chun x1 Expand = 173<br>
Tien x1 Kamehameha 20% Mastered = 44 (Roshi deflects it easily, but is surprised that Tien picked it
up so fast)<br>
Tien Dodompa = 330<br>
Tien TriBeam = 1'100<br>
Goku x4 Kamehameha 80% Mastered = 704<br>
Goku Max = 440<br>
<br>

King Piccolo<br>
Goku exhausted = 100<br>
Tien exhausted = 100<br>
Yamcha = 160<br>
Krillan 146<br>
Yadjirobe = 170<br>
Tambourine = 170<br>
King Piccolo (70% body) = 238<br>
Cymbal = 150<br>
Tien recovered, mastery of demon containment technique = 222<br>
Goku recovered = 260<br>
King Piccolo +20% = 286<br>
Drum = 240<br>
Goku sacred water = 270 (sacred water in here gives more endurance than anything)<br>
King Piccolo (100% body) = 340<br>
King Piccolo Demon Ray = 510 each<br>
Goku x3 Kamehameha 80% Mastered = 648<br>
Goku Max = 540<br>
<br>

23rd Budokai<br>
Goku with weights (base 25, age 16) = 330
Tien (base 15, age 20) = 300<br>
Choutzu (base 9) = 180<br>
Yamcha (base 12, age 20) = 240<br>
Krillan (base 13, age 17) = 221<br>
Chichi (base 10, age 17) = 170<br>
Roshi (37 base, 20% body) = 148<br>
Goku = 500<br>
Piccolo with weights (base 34, 75% body because a namek isn't fully grown til age 4) = 255<br>
Krillan Max = 332<br>
Krillan x3 Kamehameha 80% Mastered = 797<br>
Piccolo = 510<br>
Goku x4 "Super" Kamehameha 100% Mastered = 2'000<br>
Goku Max, half health = 500<br>
Piccolo 80% Health = 408<br>
Goku's final attack, energy colission = 2'000<br>
<br>

Raditz - 5 years later<br>
Goku with weights (base 30, age 21) = 400<br>
Piccolo with weights (base 40) = 400<br>
Gohan (base 56, age 4) = 224, Gohan is apparently packaged <_< Only way to explain him having more
base than his father after he was born<br>
Raditz = 1'200<br>
Goku without weights = 600<br>
Piccolo without weights = 800<br>
Goku x2 Kamehameha = 1'200<br>
Gohan Max = 1'120<br>
Raditz Max = 1'800<br>
Piccolo +50% = 1'200<br>
Piccolo x5 Piercer = 6'000<br>
<br>

After Raditz<br>
Goku dead (base 40) = 800<br>
Tien (base 20, age 25) = 520 (30% more from 3rd eye, as usual, just listed different here)<br>
Yamcha (base 20, age 25) = 400<br>
Krillan (base 20, age 22) = 400<br>
Choutzu (base 14) = 280<br>
Yadjirobe (base 12) = 240<br>
<br>

One Year Later<br>
Krillan, Choutzu, Yamcha, Tien, and Yadjirobe benefitted from the time room and using weights during
their training, thus they improved immensely unlike ever before. Goku, through a combination of his
weights, mastering kaioken, mastering gravity, and mastering genki dama, also improved at a more
rapid pace than ever before. Piccolo always trains with weights of course, and Gohan has a huge bp
mod for an unascended race, so he also improved greatly through survival training and Piccolo's
teachings.<br>
Choutzu (base 42) = 840<br>
Krillan (base 60, age 23) = 1'200<br>
Yamcha (base 60, age 26) = 1'200 (It would not be unusual for two grown humans who spar together
often without outside interference to be the exact bp as each other, due to the weaker one always
gaining twice as much from the spars it would keep it even if one falls behind even in the
slightest.<br>
Tien (base 60, age 26) = 1'560<br>
Gohan (base 200, age 5) = 1'000<br>
Piccolo (base 100) = 2'000<br>
Saibamen = 1'200<br>
Krillan +20%, Angry from Yamcha's death = 2'160<br>
Krillan's Large Ki Ball = 10'800<br>
Large Ki Ball divided into 5 homing shots = 2'160 each<br>
Nappa (base 400, age 51, 50% body) = 4'000<br>
Nappa +10% = 4'400
Choutzu Self Destruct = 8'400 (I guess Nappa must have had great resistance to survive this?)
Krillan's Destructo_Disc = 9'000<br>
Tien +40%, but half health due to only having 1 arm = 5'460<br>
Gohan Max = 5'000<br>
Gohan x4 Masenko 50% Mastered = 10'000<br>
Nappa Max = 6'000<br>
Goku (base 200, body age 21, age 22) = 4'000<br>
Goku Kaioken = 8'000<br>
Goku Kaioken x2 = 12'000 (I don't remember if he used x2 on Nappa or not but here it is anyway)<br>
Vegeta (900 base, age 27) = 18'000<br>
Goku Kaioken x2 Max = 24'000<br>
Vegeta Max = 22'500<br>
Gohan Oozaru, 80% health = 40'000<br>
Vegeta Oozaru, 80% health = 180'000<br>
Goku Kaioken x3 Max = 32'000<br>
Goku Kaioken x3 Max, x5 Kamehameha = 160'000<br>
Vegeta Max x7 Galic Gun = 157'500 (So close it'd be a stalemate for a long time)<br>
Goku Kaioken x4 Max, x5 Kamehameha = 200'000<br>
Goku Kaioken x4 Max, 20% Health = 8'000
Vegeta Max, 50% Health = 11'000
Goku's Small Genki Dama = 40'000<br>
<br>

Arrival on Namek<br>
Krillan (110 base, age 24) = 2'200<br>
Gohan (450 base, age 6) = 2'700<br>
Alien Henchmen = 1'500 (Unskilled and badly trained by comparison as well)<br>
Vegeta (base 1400, age 28) = 28'000 (nearly all of his new power is zenkai from the toughest fight
of his life with Goku)<br>
Kui = 14'000<br>
Dodoria = 18'000<br>
Zarbon = 20'000<br>
Zarbon x2 Expand = 29'000<br>
Vegeta Max +10% = 37'000<br>
<br>

That same time, on King Kai's planet...<br>
Through a combination of the experience with the saiyans, maxed out zenkai from dying, gravity
mastery, much sparring, they have all improved quite more than Krillan and Gohan have having
survived the battle with the Saiyans<br>
Choutzu (140 base) = 2'800<br>
Yamcha (190 base, age 26) = 3'800<br>
Tien (190 base, age 26) = 3'800<br>
Piccolo (350 base) = 7'000<br>
<br>

And, that same time, as Goku has finished most of his training in space<br>
By mastering 100x gravity, and kaioken x20, and from the zenkai he recieved from battling Vegeta,
he has improved immensely.<br>
Goku (1'000 base, age 22) = 20'000<br>
Goku Kaioken x10 = 420'000<br>
<br>

Ginyu Force<br>
Krillan Potential Unlocked (1'200 base, age 24) = 24'000<br>
Gohan Potential Unlocked (3'000 base, age 6) = 18'000<br>
Vegeta (1'800 base, age 28) = 36'000<br>
Guldo = 20'000<br>
Burter = 30'000<br>
Jeice = 32'000<br>
Recoome = 44'000<br>
Vegeta Max = 45'000<br>
Recoome Max = 66'000<br>
Goku (1'000 base, age 22) = 20'000<br>
Goku Kaioken x5 = 220'000 (Ginyu's scouter broke, but its last reading was 180'000)<br>
Ginyu = 40'000<br>
Ginyu Max = 60'000<br>
Ginyu in Goku's Body = 20'000, and with none of Goku's skills.<br>
<br>

Frieza<br>
Krillan (1'300 base, age 24) = 26'000<br>
Gohan (3'500 base, age 6) = 21'000<br>
Vegeta (3'000 base, age 28) = 60'000<br>
Vegeta +20% = 72'000<br>
Vegeta Max = 90'000<br>
Frieza = 530'000<br>
Frieza Form 2 = 1'000'000<br>
<br>

Piccolo fuses with Nail<br>
Nail = 40'000<br>
Piccolo (500 base) = 10'000<br>
Piccolo fused with Nail (30'500 base) = 610'000<br>
Piccolo +40% = 854'000<br>
Frieza Form 3 = 2'000'000<br>
Gohan Max = 105'000<br>
<br>

Goku recovers and heads to the battle<br>
Frieza Final Form 50% Power = 4'000'000
Goku, zenkai maxed once again (1'500 base, age 22) = 30'000
Goku Kaioken x10 = 430'000<br>
Goku Kaioken x10 Max = 860'000<br>
Goku Kaioken x20 Max = 1'660'000<br>
Goku Kaioken x20 Max, x3 Kamehameha = 4'980'000<br>
Frieza 75% Power = 6'000'000<br>
Goku's Large Genki Dama = 24'900'000<br>
Frieza 100% Power = 8'000'000 (Frieza could possibly survive a spirit bomb of that power, since a
Changeling's resistance mod is extremely high)<br>
Super Saiyan Goku = 10'000'000<br>
Frieza x2 Expand Angry = 13'200'000<br>
Super Saiyan Goku Angry = 20'000'000<br>
<br>

One Year Later<br>
Choutzu (3'800 base) = 76'000<br>
Yamcha (5'500 base, age 27) = 110'000<br>
Tien (5'500 base, age 27) = 143'000<br>
Krillan (6'000 base, age 25) = 120'000<br>
Gohan (20'000 base, age 7) = 140'000<br>
Piccolo (41'000 base) = 820'000<br>
Vegeta (16'000 base, age 29) = 320'000<br>
Frieza = 10'000'000<br>
King Kold Expand x1 = 10'000'000<br>
Trunks (200'000 base, age 16) = 4'000'000<br>
Trunks +25% = 5'000'000<br>
Super Saiyan Trunks = 17'000'000<br>
Super Saiyan Trunks +25% = 21'250'000<br>
Goku (400'000 base, age 23) = 8'000'000<br>
Super Saiyan Goku = 20'000'000<br>
Super Saiyan Goku +25% = 25'000'000<br>
<br>

3 Years Later<br>
Humans are falling behind by a lot now, as the Saiyans have already ascended, and Piccolo, and Gohan
will sometime soon.<br>
Choutzu (11'000 base) = 220'000<br>
Yamcha (16'000 base, age 30) = 320'000<br>
Tien (16'000 base, age 30) = 416'000<br>
Krillan (16'000 base, age 28) = 320'000<br>
Gohan (70'000 base, age 10) = 700'000<br>
Piccolo (500'000 base) = 10'000'000<br>
Vegeta (1'000'000 base, age 32) = 20'000'000<br>
Trunks (400'000 base, age 17) = 8'000'000<br>
Goku (900'000 base, age 26) = 18'000'000<br>
Android 19 = 20'000'000<br>
Android 20 = 8'000'000<br>
SSj Goku (Before the sickness) = 32'500'000<br>
SSj Vegeta = 37'500'000<br>
SSj Vegeta Max (If it had restored his health) = 47'000'000<br>
Android 18 = 40'000'000 (17 & 18 have the stats of a human, so they are more dangerous than their bp tells)<br>
SSj Trunks = 23'000'000<br>
SSj Trunks Max = 34'500'000<br>
<br>

Imperfect Cell<br>
Piccolo (2'000'000) = 40'000'000<br>
Piccolo +25% = 50'000'000<br>
Imperfect Cell = 25'000'000<br>
Android 17 = 40'000'000<br>
Piccolo +40% = 56'000'000<br>
Imperfect Cell Focused +40% = 52'500'000<br>
Android 16 = 60'000'000<br>
<br>

Perfect Cell<br>
Semiperfect Cell = 75'000'000<br>
Trunks (1'600'000 base, age 18) = 32'000'000<br>
Vegeta (2'250'000 base, age 33, 95% body) = 42'000'000<br>
SSj Trunks = 59'000'000<br>
SSj Vegeta = 65'000'000<br>
SSj Trunks Expand x2 = 85'000'000<br>
SSj Vegeta Expand x2 = 94'000'000<br>
Perfect Cell = 150'000'000<br>
SSj Vegeta Expand x3, 70% energy, Angry = 99'000'000<br>
SSj Trunks Expand x4 Max = 183'000'000 (Energy draining fast due to accelerated ssj drain
from using expand)<br>
Cell Expand x2 (Used it to show Trunks that it is futile to try and match him) = 225'000'000<br>
<br>

Cell Games<br>
Choutzu (21'000 base) = 420'000<br>
Yamcha (30'000 base, age 31, 97.5% body) = 585'000<br>
Krillan (30'000 base, age 29) = 600'000<br>
Tien (30'000 base, age 31, 97.5% body) = 760'500<br>
Trunks (1'700'000 base, age 18) = 34'000'000<br>
Vegeta, after entering the time room again (3'000'000 base, age 34, 90% body) = 54'000'000<br>
Gohan (2'000'000 base, age 11) = 22'000'000<br>
Goku (2'400'000 base, age 27) = 48'000'000<br>
SSj Gohan = 59'000'000<br>
SSj Goku = 70'000'000<br>
Android 16 Upgraded = 80'000'000<br>
Piccolo (4'000'000 base) = 80'000'000 (Sure Piccolo and Android 16 seem uber, but they have 0 anger.)<br>
Cell = 150'000'000<br>
<br>

Goku vs Cell<br>
SSj Goku = 70'000'000<br>
Cell = 150'000'000<br>
SSj Goku +50% = 105'000'000<br>
Cell +10% = 165'000'000<br>
Goku x2 Kamehameha = 210'000'000<br>
Cell x5 Kamehameha = 825'000'000<br>
SSj Goku Max, 80% energy = 168'000'000<br>
Cell Focused = 247'000'000<br>
SSj Goku Max, 60% energy = 126'000'000<br>
<br>

Gohan vs Cell<br>
SSj Gohan = 59'000'000<br>
Cell = 150'000'000<br>
SSj Gohan Angry = 295'000'000<br>
Super Saiyan 2 Gohan Max = 443'000'000<br>
Cell Juniors = 100'000'000 each<br>
Cell Focused = 225'000'000<br>
Cell Expand x4 = 300'000'000<br>
Semiperfect Cell = 75'000'000<br>
Semiperfect Cell's Self Destruct = 750'000'000<br>
<br>

Cell is seemingly defeated<br>
Super Saiyan 2 Gohan, 60% Energy = 265'000'000<br>
Cell Max +40% = 315'000'000<br>
SSj Trunks Expand x2 = 90'000'000 (Before Cell owned him)<br>
Cell x5 Kamehameha = 1'575'000'000<br>
Gohan x5 Kamehameha = 1'375'000'000<br>
Choutzu Max +100%, Focused = 1'890'000<br>
Yamcha Max +60%, Focused = 2'106'000<br>
Krillan Max +70%, Focused = 2'295'000<br>
Tien +70%, Focused = 1'940'000<br>
Piccolo +40%, Focused = 168'000'000<br>
SSj Vegeta x2 Expand Max Focused, 70% energy = 151'000'000<br>
Vegeta's Big Bang or whatever he used on Cell, x5 Charged = 755'000'000<br>
SSj Goku Max Focused +20%, 70% body due to being dead = 177'000'000<br>
Goku x5 Kamehameha = 885'000'000<br>
Goku and Gohan's Kamehameha's combined = 2'260'000'000<br>
<br>

1 Years Later<br>
Sometime during the last year, Tien was the first human to ascend. After the Satan Tournament,
Krillan gives up fighting to settle down with #18. Right after this point, Krillan ascends, but he
still gives up much training. Yamcha ascends sometime not long after that too. Human ascension
increases decline by 10 years as well.<br>
Choutzu (35'000 base) = 560'000<br>
Yamcha (50'000 base, age 32, 95% body) = 950'000<br>
Krillan (50'000 base, age 30) = 1'000'000<br>
Tien (1'500'000 base, age 32, 100% body) = 30'000'000<br>
Trunks (2'900'000 base, age 19) = 58'000'000<br>
Vegeta (3'600'000 base, age 35, 85% body) = 62'000'000<br>
Gohan (2'600'000 base, age 12) = 32'000'000<br>
Piccolo (6'000'000 base) = 120'000'000<br>
Goku (3'400'000 base, age 27) = 68'000'000<br>
<br>

7 Years after Cell<br>
Vegeta has not declined too much, due to luck and harder training, he has remained stable.<br>
Choutzu (800'000 base) = 16'000'000<br>
Yamcha (1'100'000 base, age 38) = 22'000'000<br>
Krillan (800'000 base, age 36) = 16'000'000<br>
Tien (2'500'000 base, age 38) = 50'000'000<br>
Vegeta (6'250'000 base, age 41, 85% body) = 107'000'000<br>
Gohan (2'700'000 base, age 18) = 49'000'000<br>
Goku (5'000'000 base, age 27) = 100'000'000<br>
Piccolo (10'000'000 base) = 200'000'000<br>
Goten (3'000'000 base, age 7) = 21'000'000<br>
Trunks (3'000'000 base, age 8) = 24'000'000<br>
<br>
SSj Goten = 37'000'000<br>
SSj Trunks = 47'000'000<br>
SSj Gohan = 113'000'000<br>
Dabura = 150'000'000<br>
SSj2 Gohan = 157'000'000<br>
SSj Vegeta = 147'000'000<br>
SSj2 Vegeta = 355'000'000<br>
Majin SSj2 Vegeta = 426'000'000<br>
SSj2 Goku = 320'000'000<br>
SSj2 Goku Max, 80% energy = 512'000'000<br>
Majin SSj2 Vegeta Max, 70% energy = 300'000'000<br>
Fat Buu = 500'000'000<br>
Super Saiyan 3 Goku = 528'000'000<br>
Super Buu = 550'000'000<br>
<br>

Gotenks<br>
Goten and Trunks enter the time chamber, and master SSj2, and fusion.<br>
Goten (4'000'000 base, age 7) = 28'000'000<br>
Trunks (4'000'000 base, age 8) = 32'000'000<br>
SSj Goten = 45'000'000<br>
SSj Trunks = 63'000'000<br>
SSj2 Goten = 140'000'000<br>
SSj2 Trunks = 161'000'000<br>
Gotenks = 301'000'000<br>
Super Gotenks = 362'000'000<br>
SSj3 Gotenks = 595'000'000<br>
SSj3 Gotenks Max = 715'000'000<br>
<br>

Mystic Gohan<br>
Gohan (3'500'000 base, age 18) = 63'000'000<br>
SSj2 Gohan = 192'000'000<br>
Mystic Gohan = 192'000'000<br>
Mystic Gohan +300% = 574'000'000<br>
Buu + Piccolo = 670'000'000<br>
Buu + Gotenks = 970'000'000<br>
Buu + Gohan = 1'040'000'000<br>
Buu - Gotenks = 740'000'000<br>
Buu + Goten + Trunks = 800'000'000<br>
Tien's TriBeam = 250'000'000<br>
<br>

Vegetto<br>
Vegeta is now at 70% body, due to being dead.<br>
Goku (5'000'000 base, age 27) = 100'000'000<br>
Vegeta (6'500'000 base, age 41, 70% body) = 91'000'000<br>
SSj2 Vegeta = 315'000'000<br>
SSj2 Goku = 320'000'000<br>
Vegetto = 860'000'000<br>
Super Vegetto = 1'032'000'000<br>
Super Vegetto +20% = 1'239'000'000<br>
Buu + Vegetto = 1'660'000'000<br>
<br>

End of Buu<br>
SSj2 Vegeta = 315'000'000<br>
SSj2 Goku = 320'000'000<br>
Majin Buu = 650'000'000<br>
SSj2 Vegeta Max = 394'000'000<br>
SSj2 Goku Max = 640'000'000<br>
SSj3 Goku Max = 1'056'000'000 (Drains down quite fast though)<br>
SSj3 Goku Max, 70% energy, x5 Kamehameha = 3'700'000'000 (He would need to generate like 6.5 billion to actually kill Majin Buu)<br>
SSj3 Goku Max, 50% energy = 528'000'000<br>
Goku Max, 50% energy, +50% Powerup = 150'000'000<br>
Goku's Large Genki Dama = 2'250'000'000<br>
Goku Max, +50% Powerup, Energy restored = 300'000'000<br>
Genki Dama adjusting to Goku's full power = 4'500'000'000<br>
SSj2 Goku Max, +50% Powerup, Energy restored = 960'000'000<br>
Genki Dama adjusted to Goku's SSj2 Power = 14'400'000'000<br>
<br>

5 Years Later<br>
Choutzu (2'200'000 base) = 44'000'000<br>
Yamcha (3'100'000 base, age 43, 92.5% body) = 57'350'000<br>
Krillan (2'500'000 base, age 41, 97.5% body) = 48'750'000<br>
Tien (5'500'000 base, age 43, 92.5% body) = 101'750'000<br>
Vegeta (7'000'000 base, age 46, 80% body) = 112'000'000<br>
Gohan (3'650'000 base, age 23) = 73'000'000<br>
Goku (5'500'000 base, age 32) = 110'000'000<br>
Piccolo (11'250'000 base) = 225'000'000<br>
Goten (4'100'000 base, age 12) = 49'200'000<br>
Trunks (4'300'000 base, age 13) = 55'900'000<br>
<br>

10 Years After Buu<br>
Choutzu (3'600'000 base) = 72'000'000<br>
Yamcha (5'100'000 base, age 48, 85% body) = 86'700'000<br>
Krillan (4'000'000 base, age 46, 85% body) = 68'000'000<br>
Tien (8'000'000 base, age 48, 85% body) = 136'000'000<br>
Vegeta (7'700'000 base, age 51, 60% body) = 92'400'000<br>
Gohan (3'800'000 base, age 28) = 76'000'000<br>
Goku (6'000'000 base, age 37) = 120'000'000<br>
Piccolo (12'500'000 base) = 250'000'000<br>
Goten (4'300'000 base, age 17) = 73'100'000<br>
Trunks (5'000'000 base, age 18) = 90'000'000<br>
Pan (4'000'000 base, age 9) = 36'000'000<br>
Uub (15'000'000 base, age 10) = 150'000'000 (If Majin Buu ("Kid" version or whatever), reincarnated,
this is what he would be. He would be a born ascended human. This includes death zenkai as well.)<br>
<br>

Goku vs Uub<br>
Goku = 120'000'000<br>
Uub = 150'000'000 (But at this point, far less skilled than Goku, in terms of Offense and Defense,
and actual abilities he has available to use in battle)<br>
Uub Max = 225'000'000<br>
Uub kicks Goku's ass down to the ground, everyone thinks Uub has won, but Goku busts out of the
ground powered up.<br>
Goku +50% = 180'000'000<br>
Goku then kicks Uubs ass, Uub is kicked to the edge of the ring, he then thinks about his tribe back
home, and how he promised he wouldn't lose, then to Goku's surprise he began to powerup just from
seeing Goku use it. Goku is knocked back just by the force of his increased power.<br>
Uub +60% = 360'000'000<br>
As Uub comes at him, Goku disappears into the sky, Uub is surprised that he can fly, and then, Goku
begins charging his Kamehameha <_<, but before Goku can fire it, the ring underneath Uub breaks and
Uub is about to fall to the ground, but Goku swoops down and grabs him before that can happen. And
flies off into the horizon grasping Uub by his arm, right then, Michael Jackson jumps over the
tournament walls, and yells "Damn, too late", then he starts moonwalking and everyone turns into
MJ clones and diarea shits themselves as Goku flies out of sight.<br>
<br>



<br><br>
2 Years Later<br>
Choutzu (4'300'000 base) = 72'000'000<br>
Yamcha (6'100'000 base, age 50, 80% body) = 97'600'000<br>
Krillan (4'500'000 base, age 48, 80% body) = 72'000'000<br>
Tien (9'200'000 base, age 50, 82.5% body) = 151'800'000<br>
Vegeta (9'000'000 base, age 53, 50% body) = 90'000'000<br>
Gohan (4'000'000 base, age 30) = 80'000'000<br>
Piccolo (15'000'000 base) = 300'000'000<br>
Goten (4'600'000 base, age 19) = 87'400'000<br>
Trunks (6'000'000 base, age 20) = 120'000'000<br>
Pan (5'000'000 base, age 11) = 55'000'000<br>
Goku (7'000'000 base, age 39) = 140'000'000<br>
Uub (17'000'000 base, age 12) = 204'000'000<br>
Goku Focused, +50% = 315'000'000<br>
Uub Focused, +70% = 520'000'000<br>
Goku x3 Kamehameha = 945'000'000<br>
Uub x3 Beam = 780'000'000<br>
<br>

If they went Super Saiyan at this time<br>
Goten = 120'000'000<br>
Vegeta = 125'000'000<br>
Gohan = 175'000'000<br>
Goku = 185'000'000<br>
Trunks = 191'000'000<br>
<br>

Super Saiyan 2<br>
Gohan = 234'000'000<br>
Goten = 290'000'000<br>
Vegeta = 313'000'000<br>
Trunks = 374'000'000<br>
Goku = 420'000'000<br>
<br>

Super Saiyan 3<br>
Super Saiyan 3 Goku = 693'000'000<br>
<br>

Max Form, Max Anger<br>
Choutzu Max = 90'000'000<br>
Yamcha Max = 147'000'000<br>
Krillan Max = 108'000'000<br>
Tien doesn't have anger in 3rd eye, but if he were to revert:<br>
Tien reverted = 117'000'000<br>
Tien Max = 176'000'000<br>
Pan Max = 275'000'000<br>
Piccolo Max = 315'000'000<br>
SSj2 Vegeta Max = 392'000'000<br>
SSj2 Goten Max = 435'000'000<br>
SSj2 Trunks Max = 561'000'000<br>
SSj2 Gohan Max = 1'160'000'000<br>
SSj3 Goku Max = 1'386'000'000<br>
Since Mystic Gohan would not have anger, I'll instead show what he would be at +300% powerup, since
he could easily hold that for quite a long time<br>
Mystic Gohan = 934'000'000<br>


http://www.tv.com/dragon-ball/show/4607/new-and-improved-power-level-list/topic/3205-1091809/msgs.html

"}*/