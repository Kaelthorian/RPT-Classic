var/RaceEra
var/RaceEraCurrent
var/RaceEraPrevious
var/EraLock=0

var/EraMaxChance	= 50
var/EraMinChance	= 10

var/ScoreSaiyan		= EraMinChance
var/ScoreTuffle		= EraMinChance
var/ScoreHuman		= EraMinChance
var/ScoreSD			= EraMinChance
var/ScoreNamek		= EraMinChance
var/ScoreChangeling	= EraMinChance
var/ScoreAndroid	= EraMinChance
var/ScoreOni		= EraMinChance
var/ScoreDemon		= EraMinChance
var/ScoreKaio		= EraMinChance
var/ScoreDemigod	= EraMinChance
var/ScoreAlien		= EraMinChance
var/ScoreHeran		= EraMinChance
var/ScoreYardrat	= EraMinChance
var/ScoreKanassa	= EraMinChance
var/ScoreMakyo		= EraMinChance

var/EraPowerUp
var/EraPowerDown

proc/EraDeathScore(mob/S,mob/R)
	if(S.Race==R.Race)
		return

	if(S.Race== "Saiyan")
		ScoreSaiyan--
		if(ScoreSaiyan >= EraMinChance)
			ScoreSaiyan=EraMinChance
	if(S.Race== "Tuffle")
		ScoreTuffle--
		if(ScoreTuffle >= EraMinChance)
			ScoreTuffle=EraMinChance
	if(S.Race== "Human")
		ScoreHuman--
		if(ScoreHuman >= EraMinChance)
			ScoreHuman=EraMinChance
	if(S.Race== "Makyo")
		ScoreMakyo--
		if(ScoreMakyo >= EraMinChance)
			ScoreMakyo=EraMinChance
	if(S.Race== "SD")
		ScoreSD--
		if(ScoreSD >= EraMinChance)
			ScoreSD=EraMinChance
	if(S.Race== "Namek")
		ScoreNamek--
		if(ScoreNamek >= EraMinChance)
			ScoreNamek=EraMinChance
	if(S.Race== "Changeling")
		ScoreChangeling--
		if(ScoreChangeling >= EraMinChance)
			ScoreChangeling=EraMinChance
	if(S.Race== "Android")
		ScoreAndroid--
		if(ScoreAndroid >= EraMinChance)
			ScoreAndroid=EraMinChance
	if(S.Race== "Oni")
		ScoreOni--
		if(ScoreOni >= EraMinChance)
			ScoreOni=EraMinChance
	if(S.Race== "Demon")
		ScoreDemon--
		if(ScoreDemon >= EraMinChance)
			ScoreDemon=EraMinChance
	if(S.Race== "Kaio")
		ScoreKaio--
		if(ScoreKaio >= EraMinChance)
			ScoreKaio=EraMinChance
	if(S.Race== "Demigod")
		ScoreDemigod--
		if(ScoreDemigod >= EraMinChance)
			ScoreDemigod=EraMinChance
	if(S.Race== "Alien")
		ScoreAlien--
		if(ScoreAlien >= EraMinChance)
			ScoreAlien=EraMinChance
	if(S.Race== "Heran")
		ScoreHeran--
		if(ScoreHeran >= EraMinChance)
			ScoreHeran=EraMinChance
	if(S.Race== "Yardrat")
		ScoreYardrat--
		if(ScoreYardrat >= EraMinChance)
			ScoreYardrat=EraMinChance
	if(S.Race== "Kanassa")
		ScoreKanassa--
		if(ScoreKanassa >= EraMinChance)
			ScoreKanassa=EraMinChance

proc/EraPowerChange()
	EraPowerUp		+= 0.02
	EraPowerDown	-= 0.02

proc/EraScore(mob/S)
	if(S.RaceEraScore && Year == 5||10||15||20||25||30||35||40||45||50||55||60||65||70)
		if(S.Race== "Saiyan")
			ScoreSaiyan++
			if(ScoreSaiyan >= EraMaxChance)
				ScoreSaiyan=EraMaxChance
		if(S.Race== "Tuffle")
			ScoreTuffle++
			if(ScoreTuffle >= EraMaxChance)
				ScoreTuffle=EraMaxChance
		if(S.Race== "Human")
			ScoreHuman++
			if(ScoreHuman >= EraMaxChance)
				ScoreHuman=EraMaxChance
		if(S.Race== "Makyo")
			ScoreMakyo++
			if(ScoreMakyo >= EraMaxChance)
				ScoreMakyo=EraMaxChance
		if(S.Race== "SD")
			ScoreSD++
			if(ScoreSD >= EraMaxChance)
				ScoreSD=EraMaxChance
		if(S.Race== "Namek")
			ScoreNamek++
			if(ScoreNamek >= EraMaxChance)
				ScoreNamek=EraMaxChance
		if(S.Race== "Changeling")
			ScoreChangeling++
			if(ScoreChangeling >= EraMaxChance)
				ScoreChangeling=EraMaxChance
		if(S.Race== "Android")
			ScoreAndroid++
			if(ScoreAndroid >= EraMaxChance)
				ScoreAndroid=EraMaxChance
		if(S.Race== "Oni")
			ScoreOni++
			if(ScoreOni >= EraMaxChance)
				ScoreOni=EraMaxChance
		if(S.Race== "Demon")
			ScoreDemon++
			if(ScoreDemon >= EraMaxChance)
				ScoreDemon=EraMaxChance
		if(S.Race== "Kaio")
			ScoreKaio++
			if(ScoreKaio >= EraMaxChance)
				ScoreKaio=EraMaxChance
		if(S.Race== "Demigod")
			ScoreDemigod++
			if(ScoreDemigod >= EraMaxChance)
				ScoreDemigod=EraMaxChance
		if(S.Race== "Alien")
			ScoreAlien++
			if(ScoreAlien >= EraMaxChance)
				ScoreAlien=EraMaxChance
		if(S.Race== "Heran")
			ScoreHeran++
			if(ScoreHeran >= EraMaxChance)
				ScoreHeran=EraMaxChance
		if(S.Race== "Yardrat")
			ScoreYardrat++
			if(ScoreYardrat >= EraMaxChance)
				ScoreYardrat=EraMaxChance
		if(S.Race== "Kanassa")
			ScoreKanassa++
			if(ScoreKanassa >= EraMaxChance)
				ScoreKanassa=EraMaxChance

		S.RaceEraScore=1

proc/RaceEraPick()
	if(EraLock==1)
		return
	A
	RaceEra=pick(
	prob(ScoreSaiyan)
		"Saiyan",
	prob(ScoreTuffle)
		"Tuffle",
	prob(ScoreHuman)
		"Human",
	prob(ScoreMakyo)
		"Makyo",
	prob(ScoreSD)
		"SD",
	prob(ScoreNamek)
		"Namek",
	prob(ScoreChangeling)
		"Changeling",
	prob(ScoreAndroid)
		"Android",
	prob(ScoreOni)
		"Oni",
	prob(ScoreDemon)
		"Demon",
	prob(ScoreKaio)
		"Kaio",
	prob(ScoreDemigod)
		"Demigod",
	prob(ScoreAlien)
		"Alien",
	prob(ScoreHeran)
		"Heran",
	prob(ScoreYardrat)
		"Yardrat",
	prob(ScoreKanassa)
		"Kanassa")
	if(	RaceEra == RaceEraCurrent)
		goto A

	RaceEraPrevious = RaceEraCurrent
	RaceEra 		= RaceEraCurrent
	EraPowerUp		= 1
	EraPowerDown	= 1.1

	EraLock=1




mob/Admin1/verb/CheckEraChance()
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr<<"--------------------------------------"
	usr<<"Chances for next era:"
	usr<<"ScoreSaiyan		=[ScoreSaiyan]%"
	usr<<"ScoreTuffle		=[ScoreTuffle]%"
	usr<<"ScoreHuman		=[ScoreHuman]%"
	usr<<"ScoreSD		=[ScoreSD]%"
	usr<<"ScoreNamek		=[ScoreNamek]%"
	usr<<"ScoreChangeling	=[ScoreChangeling]%"
	usr<<"ScoreAndroid		=[ScoreAndroid]%"
	usr<<"ScoreOni		=[ScoreOni]%"
	usr<<"ScoreDemon		=[ScoreDemon]%"
	usr<<"ScoreKaio		=[ScoreKaio]%"
	usr<<"ScoreDemigod		=[ScoreDemigod]%"
	usr<<"ScoreAlien		=[ScoreAlien]%"
	usr<<"ScoreHeran		=[ScoreHeran]%"
	usr<<"ScoreYardrat		=[ScoreYardrat]%"
	usr<<"ScoreKanassa		=[ScoreKanassa]%"
	usr<<"ScoreMakyo		=[ScoreMakyo]%"
	usr<<"Current			=[RaceEraCurrent]"
	usr<<"EraPowerUp			=[EraPowerUp]"
	usr<<"EraPowerDown			=[EraPowerDown]"
	usr<<"--------------------------------------"


mob/Admin1/verb/Set_Era()
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	RaceEra=input("What race you want to be in the current era? (Currently : [RaceEra]") in list ("Saiyan","Tuffle","Human","Makyo","SD","Namek","Changeling","Android","Oni","Demon","Kaio","Demigod","Alien","Heran","Yardrat","Kanassa","Cancel")
	if(RaceEra == "Cancel")
		return

	RaceEraPrevious = RaceEraCurrent
	RaceEraCurrent	= RaceEra
	EraPowerUp		= 1
	EraPowerDown	= 1.1

	logAndAlertAdmins("[src.key] Changed the era from [RaceEraCurrent]",2)