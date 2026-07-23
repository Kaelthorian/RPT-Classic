mob/verb/Read_Login()
	//set category="Other"
	var/ServerInfo={"<body style="background-color:#212121" text="#80d8FF"><font size=4>Server Information<br><font size=2>
	[YearOutput()]<br>
	Year Speed: 1 Week Every [(Year_Speed)] Minutes<br>
	Wipe Day: [WipeDay]<br>
	True BP Cap: [Commas(TrueBPCap)]x BPMod<br>
	Tech/Magic Cap: [TechCap] + Tech/Magic Mod<br>
	"}
	if(Year>5)
		ServerInfo+={"
		Starter Boost BP: [Commas(StarterBoostBP)]<br>
		"}

	ServerInfo+={"<br>
	Global Transformations: [Global_Trans ? "On" : "Off"]<br>
	Global SSj: [Global_SSJ2 ?"2" :Global_SSJ ? "1" : "Off"]<br>
	Global Ascension: [Global_Ascension ? "On" : "Off"]<br>
	Global God Ki: [Global_GodKi ? "On ([Global_GodKiCap] Cap)" : "Off"]<br>
<br><br>
Current Objective: [GlobalObjective]<br>
	"}
	usr << browse(ServerInfo,"window=version;size=300x325;bgcolor=#000000;fontcolor=#FFFFFF")

var/tmp/mob/WritingNotes

mob/verb/Rules()
	usr<<link("http://15.235.112.20/rules/")
	usr<<"http://15.235.112.20/rules/"


mob/verb/Story()
	set category="Other"
	usr << browse(Story,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")

mob/proc/StoryPrompt()
	switch(z)
		if(1) src << browse(EarthStory1,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(2) src << browse(NamekStory1,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(3) src << browse(VegetaStory1,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(5) src << browse(ArconiaStory1,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(7) src << browse(SpaceStationStory1,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
mob/Admin1/verb/Change_Story()
	switch (input("What planet story you want to change?") in list ("Global","SpaceStation","Vegeta","Earth","Namek","Arconia","Cancel"))
		if("Global")
			Story1= input("What story you want to create?") as text
		if("SpaceStation")
			SpaceStationStory1= input("What story you want to create?") as text
		if("Vegeta")
			VegetaStory1= input("What story you want to create?") as text
		if("Earth")
			EarthStory1= input("What story you want to create?") as text
		if("Namek")
			NamekStory1= input("What story you want to create?") as text
		if("Arconia")
			ArconiaStory1= input("What story you want to create?") as text
var/global/
	Story1
	EarthStory1
	NamekStory1
	VegetaStory1
	ArconiaStory1
	SpaceStationStory1


var/Story={"
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
	<center><h2>Wipe Lore</h2></center>
	-Global-<br>
	https://pastebin.com/0gcHJN6S<br>


	"}