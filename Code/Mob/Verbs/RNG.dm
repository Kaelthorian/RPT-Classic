mob/verb/RNG()
	//set name = "Random Number Generator"
	//set category = "Other"
	var/L=input(usr,"Lowest number. (0 minimum)") as num
	var/H=input(usr,"Highest number. (1000 maximum)") as num
	if(L<0)L=0
	if(H>1000)H=1000
	if(L && H)
		var/N = rand(L,H)
		view(10,usr)<<"[usr] used RNG and rolled between [L] and [H] to get [N]."