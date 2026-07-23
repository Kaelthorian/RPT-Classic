mob/Admin1/verb

	Assess(mob/M in Players)
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr.Get_Assess(M)


mob/proc/Get_Assess(mob/M)
	if(!M) src<<"The person you just assessed is broken in some way. Please alert Trashman."
	log_admin({"[key_name(src)] Assessed [M]"})
	var/Gravity_Multiplier=min(2.5,1+((M.GravMastered/25)/25))
	var/A={"
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

body {
  background-color:black;
  color: #449999;
  font-size:12
  font-family: "Lato", sans-serif;
}

.sidenav {
  height: 100%;
  width: 160px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 20px;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  display: block;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.main {
  margin-left: 160px; /* Same as the width of the sidenav */
  font-size: 15px; /* Increased text to enable scrolling */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
* {
  box-sizing: border-box;
}
--------------------------------
.dropbtn {
  background-color: #04AA6D;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: grey;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}
.dropdown-content a:hover {background-color: grey;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}

.btn {
  border: none;
  color: #818181;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  background-color:#111;
}
</style>
</head>
<body>

<div class="sidenav">
  <A HREF='?src=\ref[src.client.holder];privatemessage=\ref[M]'>Admin Message</A>
  <A HREF='?src=\ref[src.client.holder];command=edit;target=\ref[M];type=view;'>Edit</A>
  <A HREF='?src=\ref[src.client.holder];GiveEXP=\ref[M]'>Give EXP</A>
  <A HREF='?src=\ref[src.client.holder];heal=\ref[M]'>Heal</A>
  <A HREF='?src=\ref[src.client.holder];subtlemessage=\ref[M]'>IC Message</A>
  <A HREF='?src=\ref[src.client.holder];mute2=\ref[M]'>Mute</a>
  <A HREF='?src=\ref[src.client.holder];adminplayeropts=\ref[M]'>Player Panel</a>
  <A HREF='?src=\ref[src.client.holder];RemoveCombatFlag=\ref[M]'>Remove Combat Flag</a>
  <A HREF='?src=\ref[src.client.holder];ForceReincarnate=\ref[M]'>Reincarnate</A>
  <A HREF='?src=\ref[src.client.holder];revive=\ref[M]'>Revive</A>
  <A HREF='?src=\ref[src.client.holder];MakeEC=\ref[M]'>MakeEC</A>
  <A HREF='?src=\ref[src.client.holder];knockout=\ref[M]'>Knockout</A>
  <A HREF='?src=\ref[src.client.holder];kill=\ref[M]'>Kill</A>
  <A HREF='?src=\ref[src.client.holder];observe=\ref[M]'>Watch</A>
  <A HREF='?src=\ref[src.client.holder];WPRestore=\ref[M]'>WP restore</A>
</div>

<div class="main">
  <div class="btn dropdown">
  <a>Give</a>
  <div class="dropdown-content">
    <A HREF='?src=\ref[src.client.holder];GiveAnger=\ref[M]'>Anger</A>
    <A HREF='?src=\ref[src.client.holder];alterstats=\ref[M]'>Alter Stats</A>
    <A href='?src=\ref[src.client.holder];GiveBuild=\ref[M]'>Build</A>
    <A href='?src=\ref[src.client.holder];ControlPoint=\ref[M]'>Control Point</A>
    <A href='?src=\ref[src.client.holder];CapStats=\ref[M]'>Cap Stats</A>
    <A href='?src=\ref[src.client.holder];GodKi=\ref[M]'>God Ki</A>
    <A href='?src=\ref[src.client.holder];giveobj=\ref[M]'>Object</A>
    <A href='?src=\ref[src.client.holder];PowerMate=\ref[M]'>Power Mate</A>
    <A href='?src=\ref[src.client.holder];Rank=\ref[M]'>Rank</A>
    <A href='?src=\ref[src.client.holder];Rare=\ref[M]'>Rare</A>
    <A HREF='?src=\ref[src.client.holder];statredo=\ref[M]'>Give Redo Stats</A>
    <A HREF='?src=\ref[src.client.holder];givemenu=\ref[M]'>Give Menu</A>
    <A HREF='?src=\ref[src.client.holder];Transformation=\ref[M]'>Transformation</A>
  </div>
</div>
  <div class="btn dropdown">
  <a>Teleport</a>
  <div class="dropdown-content">

    <A HREF='?src=\ref[src.client.holder];jumpto=\ref[M]'>Jump to</A>
    <A HREF='?src=\ref[src.client.holder];summon=\ref[M]'>Summon</A>
    <A HREF='?src=\ref[src.client.holder];sendToSpawn=\ref[M]'>Send to Spawn</A>
    <A HREF='?src=\ref[src.client.holder];UnSummon=\ref[M]'>UnSummon</A>
    <A HREF='?src=\ref[src.client.holder];XYZTele=\ref[M];'>XYZ Teleport</A>
  </div>
</div>
  <div class="btn dropdown">
  <a>Admin</a>
  <div class="dropdown-content">
    <A HREF='?src=\ref[src.client.holder];readmind=\ref[M]'>Player Journal</A>
    <A HREF='?src=\ref[src.client.holder];boot2=\ref[M]'>Boot</A>
    <A href='?src=\ref[src.client.holder];newban=\ref[M]'>Ban</A>
    <A HREF='?src=\ref[src.client.holder];getlog=[M.lastKnownKey];portion=0'>Check Logs</A>
    <A HREF='?src=\ref[src.client.holder];Warning=\ref[M]'>Warning</A>
  </div>
</div>
  <h2>Assess</h2>

  	<A HREF='?src=\ref[src.client.holder];assess=\ref[M]'>Refresh</A><br>
	Coordinates: ([M.x], [M.y], [M.z]) (Infection: [M.Infection])<br>
	[M] (Key: [M.key]) [M.Rank ? "([M.Rank])" : ""]<br>
	[M.Size] [M.gender] [M.Race]<br>
	Current Anger: [M.Anger]% <br>
	Current Power: [round(M.BPpcnt)]%<br>
	Current Ki: [M.Ki]/[M.MaxKi]<br>
	Willpower: [M.Willpower] / [M.MaxWillpower]<br>
	Health: [M.Health] / [M.MaxHealth]<br>
	Alignment: [M.AlignmentNumber] ([M.Alignment])
	<table cellspacing="6%" cellpadding="1%">
	<tr><td>Buffs:</td><td>Buffs [M.BuffNumber] ([M.Buffs.Join(", ")])</td></tr>
	<tr><td>Power Rank:</td><td>BP ([round(M.BPRank)]) / Stat ([round(M.StatRank)])</td></tr>
	<tr><td>RP Power:</td><td>Mult ([M.RPPower]) / Add ([M.RPPowerAdd]) / Racial [Commas(M.RacialPowerAdd)]</td></tr>
	<tr><td>Age:</td><td>[M.Age] ([M.Real_Age] True Age) (Save Age [M.SaveAge])</td></tr>
	<tr><td>Body:</td><td>[M.Body*100]% ([M.Decline] Decline/[M.InclineAge] Incline)</td></tr>
	<tr><td>Base:</td><td>[Commas(M.Base)] ([M.FBMAchieved ? "(FBM) " : ""][M.BPMod] x [Commas(M.Base/M.BPMod)])[M.PotentialUnlocked?" Potential Unlocked":""]</td></tr>
	<tr><td>Current BP:</td><td>[Commas(M.BP)] ([M.BPMult] Mult)</td></tr>
	<tr><td>Energy: ([M.Total_Stats_Recov] points)</td><td>[round(M.MaxKi)] ([M.KiMod] Mod) ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)</td></tr>
	<tr><td>Strength: ([M.Total_Stats_Strength] points)</td><td>[round(M.Str)] ([M.StrMod] Mod) ([M.StrMult] Mult [round(M.StrMod/M.StrMod)] Weighted)</td></tr>
	<tr><td>Endurance: ([M.Total_Stats_Endurance] points)</td><td>[round(M.End)] ([M.EndMod] Mod) ([M.EndMult] Mult [round(M.EndMod/M.EndMod)] Weighted)</td></tr>
	<tr><td>Speed: ([M.Total_Stats_Speed] points)</td><td>[round(M.Spd)] ([M.SpdMod] Mod) ([M.SpdMult] Mult [round(M.SpdMod/M.SpdMod)] Weighted)</td></tr>
	<tr><td>Force: ([M.Total_Stats_Strength] points)</td><td>[round(M.Pow)] ([M.StrMod] Mod) ([M.PowMult] Mult [round(M.StrMod/M.StrMod)] Weighted)</td></tr>
	<tr><td>Offense: ([M.Total_Stats_Off] points)</td><td>[round(M.Off)] ([M.OffMod] Mod) ([M.OffMult] Mult [round(M.OffMod/M.OffMod)] Weighted)</td></tr>
	<tr><td>Defense: ([M.Total_Stats_Def] points)</td><td>[round(M.Def)] ([M.DefMod] Mod) ([M.DefMult] Mult [round(M.DefMod/M.DefMod)] Weighted)</td></tr>
	<tr><td>Regeneration:</td><td>[M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)</td></tr>
	<tr><td>Recovery:</td><td>[M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)(PU cap [(M.RecovMult * M.BaseRecovery * 12.5) + 100]%)</td></tr>
	<tr><td>Zenkai:</td><td>[Commas(M.ZenkaiPower)] ([M.Zenkai] x)</td></tr>
	<tr><td>Gravity:</td><td>[round(M.GravMastered)] ([Gravity_Multiplier] x BP Boost)</td></tr>
	<tr><td>Max Anger:</td><td>[M.MaxAnger]% ([M.AngerMult] x)</td></tr>
	<tr><td>Flying:</td><td>[round(M.FlySkill)] ([M.FlyMod])</td></tr>
	<tr><td>Zanzoken:</td><td>[round(M.Zanzoken)] ([M.ZanzoMod])</td></tr>
	<tr><td>Unarmed:</td><td>[round(M.UnarmedSkill)]</td></tr>
	<tr><td>Weapon:</td><td>[round(M.SwordSkill)]</td></tr>
	<tr><td>Ki Manipulation:</td><td>[round(M.KiManipulation)]</td></tr>
	<tr><td>Evasion:</td><td>[round(M.Athleticism)]</td></tr>
	<tr><td>Intelligence:</td><td>[M.Int_Level] ([M.Int_Mod])</td></tr>
	<tr><td>Magic Skill:</td><td>[M.Magic_Level] ([M.Magic_Potential])</td></tr>
	<tr><td>Energy Signature:</td><td>[M.Signature]</td></tr>
	<tr><td>Gain Multiplier:</td><td>[(M.GainMultiplier)]</td></tr>
	<tr><td>Weighted Stats:</td><td>[Commas(round(M.WeightedStats))]</td></tr>
	<tr><td>Combat Mod Total:</td><td>[((M.StrMod+M.EndMod+M.SpdMod+M.OffMod+M.DefMod))]</td></tr>
	<tr><td>EXP:</td><td>[round(M.EXP)]/[round(M.EXPLifetime)]</td></tr>
	<tr><td>MilePoints:</td><td>[round(M.MilestonePoints)] / [round(M.TotalMilestonePoints)] ([max(0,round(Year)-M.TotalMilestonePoints)] MPs to catch up)</td></tr>
	<tr><td>Fishing:</td><td>[round(M.Fishing_Level)]</td></tr>
	<tr><td>Cooking:</td><td>[round(M.Cooking_Level)]</td></tr>
	<tr><td>Smithing:</td><td>[round(M.Smithing_Level)]</td></tr>
	<tr><td>Mining:</td><td>[round(M.Mining_Level)]</td></tr>
	</td></tr></table><br><table>"}// [M.Int_Level>20 ? "(Int Level [M.Int_Level*70/M.Int_Mod])" : ""] [M.Magic_Level>20 ? "(Magic Level [M.Magic_Level*70/M.Magic_Potential])" :""]
//	if(M.Race=="Namekian") A+="<tr><td><font color=#FFFF99>SNj At: [Commas(M.SNjAt)]</td></tr>"
	if(M.Race=="Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 2 Mult: [M.SSj2Mult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 3 Mult: [M.SSj3Mult]</td></tr>"
	if(M.Race=="Android")
		A+="<tr><td><font color=#FFFF99>Android level:[round(M.AndroidLevel)]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Modules:[round(M.Upgrade_Components)]</td></tr>"
	if(M.Race=="Android" || M.Race=="Spirit Doll"|| M.Race=="Bio-Android"|| M.Race=="Demon"|| M.Race=="Kaio")
		A+="<tr><td><font color=#FFFF99>Made by [M.Builder]</td></tr>"
	if(M.Race=="Half-Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 2 Mult: [M.SSj2Mult]</td></tr>"
	if(M.Race=="Part-Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
	if(M.Race=="Changeling")
		A+="<tr><td><font color=#FFFF99>Form 2 Mult: [M.Form2Mult]</td></tr>"
		if(M.Class!="King Kold") A+="<tr><td><font color=#FFFF99>Form 3 Mult: [M.Form3Mult]</td></tr>"
		if(M.Class!="King Kold") A+="<tr><td><font color=#FFFF99>Form 4 Mult: [M.Form4Mult]</td></tr>"
		if(M.Class=="Cooler") A+="<tr><td><font color=#FFFF99>Form 5 Mult: [M.Form5Mult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Golden Form Mult: [M.Form6Mult]</td></tr>"
	if(M.Race=="Alien")
		A+="<tr><td><font color=#FFFF99>Ascension At: [Commas(M.FBMAt*5)] (>1 God Ki)</td></tr>"
	if(M.Race=="Heran")
		A+="<tr><td><font color=#FFFF99>Bojack Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Super Bojack Mult: [M.SSj2Mult]</td></tr>"
	if(M.Offspring)
		A+="<tr><td><font color=#FFFF99>Offspring: [M.Parents]</td></tr>"
	if(M.Vampire==1)
		A+="<tr><td><font color=#FFFF99>Vampire</td></tr>"
	A+={"<tr><td><font color=#C5CAE9>FBM At: [Commas(round(M.FBMAt))] Base</td></tr>
	<tr><td><font color=#C5CAE9>God Ki: [M.GodKi] / [M.MaxGodKi]</td></tr></table>"}
	A+="<br><font color=#FFFF99>Mutations: [M.MutationNumber]<br>[M.Mutations.Join(", ")]"
	//A+="<br><font color=#FFFF99>Milestones: [M.DisplayMilestones()]<br>"
	for(var/Milestone/MP in M) A+="<br><font color=#FFFF99>[MP]<br>"

	A+="<tr><td><font color=#ff9999>Skills: </td></tr>"
	for(var/contents in M)
		if(istype(contents,/Skill/))
			A+="<tr><td><font color=#ff9999>[contents], </td></tr>"


	usr<<browse(A,"window=[M.name];size=650x800")


	//	[M.Size] [M.gender] [M.Race] [M.Class=="Undefined Class" ? "" : "([M.Class])"]<br>