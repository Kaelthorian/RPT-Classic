mob/verb/LearnTest1()
	set category="Testing"
	LearningListUpdate(usr)
	LearnTest(usr)

proc/LearningListUpdate(mob/M)

	ListSkill = dd_list2text(typesof(/Skill/Unarmed),";")
//	ListSkill.Remove()

	ListSkill.Remove("/Skill/Unarmed")
	for(var/A in ListSkill)
//		world<<"[A]"

var/list/ListSkill
//					var ObjectTypes = "[dd_list2text(typesof(/Skill/),";")]";

mob/proc/LearnTest(mob/M)
	var/V={"<HTML><HEAD><TITLE>Learning Tree</TITLE></HEAD><BODY>

				<html>
				<head>
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<style>
				border-style: none;
				h1 {text-align: center;}
				body {
				  background-color:black;
				  color: #449999;
				  font-size:12
				  font-family: "Lato", sans-serif;

				.main {
				  margin-left: 160px; /* Same as the width of the sidenav */
				  padding: 0px 10px;
				}

				@media screen and (max-height: 450px) {
				  .sidebar {padding-top: 15px;}
				  .sidebar a {font-size: 18px;}
				}
				</style>
				</head>
				<body>

				<center>
				<FORM NAME="Spawner" ACTION="byond://?src=\ref[src]" METHOD="GET">
				<b>Name of the Skill:</b> <INPUT TYPE="text" NAME="SearchBar" VALUE="" onKeyUp="updateSearch()" onKeyPress="submitFirst(event)" style="width:250px"><BR>
				<INPUT TYPE=hidden NAME="GiveObjectListMob" VALUE="\ref[M]">
				<SELECT NAME="TEST2244" id="TEST2244" size="20" multiple style="width:400px"></SELECT><BR>
				<INPUT TYPE="hidden" name="src" value="\ref[src]"><BR>
				<INPUT TYPE="submit" value="Learn" style="width:400px">
				</center>

				</FORM>
				<SCRIPT LANGUAGE="JavaScript">
					var OldSearch = "";
					var TEST2244 = document.Spawner.TEST2244;
					var ObjectTypes = "[ListSkill]";
					var ObjectArray = ObjectTypes.split(";");
					document.Spawner.SearchBar.focus();
					populateList();
					function populateList()
					{
						var myElem;
						TEST2244.options.length = 0;
						for(myElem in ObjectArray)
						{
							var oOption = document.createElement("OPTION");
							oOption.value = ObjectArray\[myElem\];
							oOption.text = ObjectArray\[myElem\];
							TEST2244.options.add(oOption);
						}
					}
					function updateSearch()
					{
						if(OldSearch == document.Spawner.SearchBar.value) return;
						OldSearch = document.Spawner.SearchBar.value;
						ObjectArray = new Array();
						var TestElem;
						var TmpArray = ObjectTypes.split(";");
						if(OldSearch!=null) OldSearch = OldSearch.toLowerCase(); // Turn the search string into lowercase
						for(TestElem in TmpArray)
						{
							if(TmpArray\[TestElem\].toLowerCase().search(OldSearch) < 0) continue; //compare the lowercase entry to the lowercase search string for a match.
							ObjectArray.push(TmpArray\[TestElem\]);
						}
						populateList();
					}
					function submitFirst(event)
					{
						if(!TEST2244.options.length) return false;
						if(event.keyCode == 13 || event.which == 13)
							TEST2244.options\[0\].selected = 'true';
					}
				</SCRIPT></BODY></HTML>"}

	usr<<browse(V,"window=[M.name];size=440x490;titlebar=1")

/client/Topic(href, href_list[], hsrc)
	if(holder)		//Edit vars in here too GUYS

		if (href_list["TEST2244"])
			if(src)
				//world << "Href_list = [list2params(href_list)]"
				var/mob/player/M = locate(href_list["GiveObjectListMob"])
				var/object = href_list["TEST2244"]
				var/number = dd_range(1,100,text2num(href_list["number"]))
				var/objectPath=text2path(object)

				if(!M || !ismob(M))
					alert("ERROR: NOT A PLAYER")
					return

				for(var/i = 1 to number)
					if(M)
						M.contents += new object // Dont add a TYPE PATH add an OBJECT using NEW!


				for(var/Skill/B in M.contents)
					if(B.type==objectPath)
						if(M.EXP<B.Tier*200)
							usr<<"You don't have enough experience."
							del(B)
							return
						if(M.EXP>B.Tier*200)
							M.EXP-=(B.Tier*200)
							usr<<"You have learn [B]."

				if(number == 1)
					log_admin("[key_name(M)] learned \a [object]")
					alertAdmins("[key_name(M)] learned \a [object]")
					return
//				else
//					log_admin("[key_name(usr)] gave!!!!! [key_name(M)] [number]ea [object]")
//					alertAdmins("[key_name_admin(usr)] gave!!!!! [key_name(M)] [number]ea [object]")
//					return
//			else
//				alert("You cannot perform this action. You must be of a higher administrative rank!")
//				return

	..()
	return