/mob/Topic(href, href_list)
	..()
	if(href_list["LimbWindow"])
		var/mob/M = locate(href_list["LimbWindow"])
		usr.client.mob.LimbWindow(M)

mob/verb/Health_Window(mob/M)
	LimbWindow(usr)

mob/proc/LimbWindow(mob/M)
	var/A={"
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
}
.sidebar {
  height: 100%;
  width: 160px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 16px;
}

.sidebar a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  display: block;
}

.sidebar a:hover {
  color: #f1f1f1;
}


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

<div class="sidebar">
	<A HREF='?src=\ref[src];LimbWindow=\ref[src]'>Refresh</A>
</div>
<div class="main">
<h2>Limbs Health</h2><br>
"}

	for(var/BodyPart/B in M)
		if(B.Health<B.MaxHealth & B.Status=="Healthy")
			A+={"[B]:Healthy<br><div class="w3-black"><div class="w3-container w3-green w3-center" style="width:[(B.Health)]%">[B.Health]%</div></div><br>"}
		if(B.Health<B.MaxHealth & B.Status=="Broken")
			A+={"[B]:Broken<br><div class="w3-black"><div class="w3-container w3-blue w3-center" style="width:[(B.Health)]%">[B.Health]%</div></div><br>"}
		if(B.Health<B.MaxHealth & B.Status=="Maimed")
			A+={"[B]:Maimed<br><div class="w3-black"><div class="w3-container w3-red w3-center" style="width:[(B.Health)]%">[B.Health]%</div></div><br>"}

	usr<<browse(A,"window=[M.name];size=650x800;titlebar=1")

