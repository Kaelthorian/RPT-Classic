proc/YearBook()
//	set background=1
	while(1)
		TrueBPCap=150
		DayScaler=1.218005413
		TechCap=25
		TrueBPCap=TrueBPCap*(DayScaler)
		StarterBoostBP=TrueBPCap*0.3
		MaxEXPReward=Year*50
		ExpCatchUp()

//		if(MaxEXPReward>=0)
//			MaxEXPReward=50
		if(Year == 0)
			MaxEXPReward=50
//		if(Year >= 1)
//		if(Year >= 2 )
		if(Year >= 3)
			TechCap=30
//		if(Year >= 4 )
//			return
		if(Year >= 5 )
			GravTune=5
			AfterlifeGrav=5*4
			TechCap=35
			RaceEraPick()
		if(Year >= 6 )
			EraLock=0
		if(Year >= 7 )
			TechCap=40
//		if(Year >= 8 )
//			return
		if(Year >= 9 )
			TechCap=45
		if(Year >= 10 )
			GravTune=10
			AfterlifeGrav=10*4
			RaceEraPick()
		if(Year >= 11 )
			EraLock=0
			TechCap=50
//		if(Year >= 12 )
//			return
		if(Year >= 13 )
			TechCap=55
//		if(Year >= 14 )
//			return
		if(Year >= 15 )
			GravTune=15
			AfterlifeGrav=15*4
			TechCap=60
			RaceEraPick()
		if(Year >= 16 )
			EraLock=0
		if(Year >= 17 )
			TechCap=65
//		if(Year >= 18 )
//			return
		if(Year >= 19 )
			TechCap=70
		if(Year >= 20 )
			GravTune=20
			AfterlifeGrav=20*4
			RaceEraPick()
		if(Year >= 21 )
			TechCap=75
			DayScaler=1.258925412
			TrueBPCap=100000
			EraLock=0
//		if(Year >= 22 )
//			return
		if(Year >= 23 )
			TechCap=80
//		if(Year >= 24 )
		if(Year >= 25 )
			GravTune=25
			AfterlifeGrav=25*4
			TechCap=85
			RaceEraPick()
		if(Year >= 26 )
			EraLock=0
		if(Year >= 27 )
			TechCap=90
//		if(Year >= 28 )
//			return
		if(Year >= 29 )
			TechCap=95
		if(Year >= 30 )
			GravTune=30
			AfterlifeGrav=30*4
			RaceEraPick()
		if(Year >= 31 )
			TechCap=100
			DayScaler=1.258925412
			TrueBPCap=1000000
			EraLock=0
//		if(Year >= 32 )
//			return
		if(Year >= 33 )
			TechCap=105
//		if(Year >= 34 )
//			return
		if(Year >= 35 )
			GravTune=35
			AfterlifeGrav=35*4
			TechCap=110
			RaceEraPick()
		if(Year >= 36 )
			EraLock=0
		if(Year >= 37 )
			TechCap=115
//		if(Year >= 38 )
//			return
		if(Year >= 39 )
			TechCap=120
		if(Year >= 40 )
			GravTune=40
			AfterlifeGrav=40*4
			RaceEraPick()
		if(Year >= 41 )
			TechCap=125
			DayScaler=1.128837892
			TrueBPCap=10000000
			EraLock=0
//		if(Year >= 42 )
//			return
		if(Year >= 43 )
			TechCap=130
//		if(Year >= 44 )
//			return
		if(Year >= 45 )
			GravTune=45
			AfterlifeGrav=45*4
			TechCap=135
			RaceEraPick()
		if(Year >= 46 )
			EraLock=0
		if(Year >= 47 )
			TechCap=140
//		if(Year >= 48 )
//			return
		if(Year >= 49 )
			TechCap=145
		if(Year >= 50 )
			GravTune=50
			AfterlifeGrav=50*4
			RaceEraPick()
		if(Year >= 51 )
			TechCap=150
			EraLock=0
//		if(Year >= 52 )
//			return
		if(Year >= 53 )
			TechCap=155
//		if(Year >= 54 )
//			return
		if(Year >= 55 )
			GravTune=55
			AfterlifeGrav=55*4
			RaceEraPick()
			TechCap=160
		if(Year >= 56 )
			EraLock=0
		if(Year >= 57 )
			TechCap=165
//		if(Year >= 58 )
//			return
		if(Year >= 59 )
			TechCap=170
		if(Year >= 60 )
			GravTune=60
			AfterlifeGrav=60*4
			RaceEraPick()
		if(Year >= 61 )
			TechCap=175
			EraLock=0
//		if(Year >= 62 )
//			return
		if(Year >= 63 )
			TechCap=180
//		if(Year >= 64 )
//			return
		if(Year >= 65 )
			GravTune=65
			AfterlifeGrav=60*4
			RaceEraPick()
			TechCap=185
		if(Year >= 66 )
			EraLock=0
		if(Year >= 67 )
			TechCap=190
//		if(Year >= 68 )
//			return
		if(Year >= 69 )
			TechCap=195
		if(Year >= 70 )
			GravTune=70
			AfterlifeGrav=60*4
			DayScaler=1.1
			TrueBPCap=100000000
			RaceEraPick()
		if(Year >= 71 )
			TechCap=2000
			EraLock=0
		sleep(600*Year_Speed)
		SaveYear()
		SaveScalingPower()
