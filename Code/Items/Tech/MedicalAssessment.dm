obj/items/Medical_Assessment
	icon='Lab.dmi'
	icon_state="Lab2"
	Level=1

	desc="This will perform a medical assessment of a person and tell you information about them based on your intelligence."
	verb/Use(mob/M in view(5))
		if(usr.Confirm("Use [src] on [M]?"))
			view(usr)<<"[usr] performs a medical assessment of [M]."
			for(var/mob/player/P in view(usr)) P.MedicalAssessment(M,usr.Int_Level,usr.Int_Mod)
			//del(src)






mob/proc/MedicalAssessment(mob/M,SkillWith,SkillMod)
	var/MedicalWindow={"
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
</style>
</head>
<body>
</div>
<div class="main">
<center><h2>[name]</h2></center>
<tr><td>[M] is a [M.Size] [M.gender]<br></td></tr>
<tr><td>Health: [M.Health] Max Health: [M.MaxHealth]<br></td></tr>
<tr><td>Body: [M.Body*100]%<br></td></tr>
<tr><td>Race: [M.Race]<br></td></tr>
</div>
</body>
</html>
"}
	if(usr.Int_Mod>=1)MedicalWindow+={"<tr><td>Age: [M.Age] <br>Incline Age: [M.InclineAge] <br>Decline Age: [M.Decline]<br></td></tr>"}
	if(usr.Int_Mod>=2)MedicalWindow+={"
<tr><td>Energy: [round(M.MaxKi)] ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)<br></td></tr>
<tr><td>Strength: [round(M.Str)] ([M.StrMult] Mult [round(M.StrMod/M.StrMod)] Weighted)<br></td></tr>
<tr><td>Endurance: [round(M.End)] ([M.EndMult] Mult [round(M.EndMod/M.EndMod)] Weighted)<br></td></tr>
<tr><td>Speed: [round(M.Spd)] ([M.SpdMult] Mult [round(M.SpdMod/M.SpdMod)] Weighted)<br></td></tr>
<tr><td>Force: [round(M.Pow)] ([M.PowMult] Mult [round(M.StrMod/M.StrMod)] Weighted)<br></td></tr>
<tr><td>Offense: [round(M.Off)] ([M.OffMult] Mult [round(M.OffMod/M.OffMod)] Weighted)<br></td></tr>
<tr><td>Defense: [round(M.Def)]  ([M.DefMult] Mult [round(M.DefMod/M.DefMod)] Weighted)<br></td></tr>
<tr><td>Regeneration: [M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)<br></td></tr>
<tr><td>Recovery: [M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)<br></td></tr>
<tr><td>Weighted Stats: [Commas(round(M.WeightedStats))]<br></td></tr>
<tr><td>Potential (Gain Multiplier): [(M.GainMultiplier)]<br></td></tr>


<br>"}

	else if(usr.Int_Mod>=3)MedicalWindow+={"
<tr><td>Energy: [round(M.MaxKi)]<br></td></tr>
<tr><td>Strength: [round(M.Str)]<br></td></tr>
<tr><td>Endurance: [round(M.End)]<br></td></tr>
<tr><td>Speed: [round(M.Spd)]<br></td></tr>
<tr><td>Force: [round(M.Pow)]<br></td></tr>
<tr><td>Offense: [round(M.Off)]<br></td></tr>
<tr><td>Defense: [round(M.Def)]<br></td></tr>
<tr><td>Regeneration: [M.Regeneration]<br></td></tr>
<tr><td>Recovery: [M.Recovery]<br></td></tr>
<tr><td>Weighted Stats: [Commas(round(M.WeightedStats))]<br></td></tr>

"}
	if(usr.Int_Mod>=4)MedicalWindow+={"
<tr><td>Max Anger: [M.MaxAnger]% ([M.AngerMult] x)<br></td></tr>
<tr><td>Zenkai: [Commas(M.ZenkaiPower)] ([M.Zenkai] x)<br></td></tr>
<tr><td>Gravity: [round(M.GravMastered)]<br></td></tr>
<tr><td>Combat Mod Total: [((M.StrMod+M.EndMod+M.SpdMod+M.OffMod+M.DefMod))]<br></td></tr>"}
	if(usr.Int_Mod>5)MedicalWindow+={"
<tr><br><font color=#FFFF99>Mutations: [M.MutationNumber]<br>[M.Mutations.Join(", ")]"<br></td></tr>"}

	if(usr.Int_Mod>=6) MedicalWindow+="<br><font color=#FFFF99>Infection Status: [M.Infection?"Infected":"Uninfected"]<br></td></tr>"

	usr<<browse(MedicalWindow,"window='Medical Window';size=500x500")