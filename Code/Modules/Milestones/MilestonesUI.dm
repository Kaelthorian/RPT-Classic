mob/verb/MPWindows(mob/M)
	MPWindow(usr)

mob/proc/MPWindow(mob/M)
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
	<A HREF='?src=\ref[src];Milestones=\ref[src]'>Refresh</A>
</div>
<div class="main">
<h2>Limbs Health</h2><br>

"}

	for(var/Milestone/B)
		A+={"<a id="myLink">[B]</a>

<script>
  const link = document.getElementById("myLink");

  link.addEventListener("click", function() {
"}
for(var/Milestone/MM in usr)
	if(MM.AlienMP&&AlienMP)
		usr<<"You already have an Alien MP."
		return
{";
  });
</script>

"}

	usr<<browse(A,"window=[M.name];size=650x800;titlebar=1")