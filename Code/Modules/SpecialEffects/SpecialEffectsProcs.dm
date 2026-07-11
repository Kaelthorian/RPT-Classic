proc/
	AlphaMask(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionIcon			=input("Icon?") as null|icon
		var/SelectionRenderSource	=input("RenderSource?") as num
		var/SelectionFlags			=input("Flags?") as num

		E.filters	+= filter(type="alpha" , x=SelectionX , y=SelectionY , render_source=SelectionRenderSource , flags=SelectionFlags , icon=SelectionIcon)

	AngularBlur(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num

		E.filters	+= filter(type="angular_blur" , x=SelectionX , y=SelectionY , size=SelectionSize)

	Bloom(mob/E)
		var/SelectionThreshold		=input("Threshold?") as num
		var/SelectionSize			=input("Size?") as num
		var/SelectionOffset			=input("Offset?") as num
		var/SelectionAlpha			=input("Aplha?") as num

		E.filters	+= filter(type="bloom" , threshold=SelectionThreshold , size=SelectionSize , offset=SelectionOffset , alpha=SelectionAlpha)

	ColorMatrix(mob/E)
		var/SelectionR				=input("R?") as num
		var/SelectionG				=input("G?") as num
		var/SelectionB				=input("B?") as num
//		var/SelectionSpace			=input("Size?") as num

		E.filters	+= filter(type="color", color=rgb(SelectionR,SelectionG,SelectionB))

	DisplacementMap(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
//		var/SelectionIcon			=input("Icon?") in list("AlphaMask")
		var/SelectionRenderSource	=input("RenderSource?") as num
		var/SelectionSize			=input("Size?") as num

		E.filters	+= filter(type="displace" , x=SelectionX , y=SelectionY , size=SelectionSize , render_source=SelectionRenderSource)

	DropShadow(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num
		var/SelectionOffset			=input("Offset?") as num
		var/SelectionR				=input("R?") as num
		var/SelectionG				=input("G?") as num
		var/SelectionB				=input("B?") as num

		E.filters	+= filter(type="drop_shadow" , x=SelectionX , y=SelectionY , size=SelectionSize , offset=SelectionOffset , color=rgb(SelectionR,SelectionG,SelectionB))

	GaussianBlur(mob/E)
		var/SelectionSize			=input("Size?") as num

		E.filters	+= filter(type="blur" , size=SelectionSize)

	Layering(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
//		var/SelectionIcon			=input("Icon?") in list("AlphaMask")
		var/SelectionRenderSource	=input("RenderSource?") as num
		var/SelectionFlags			=input("Flags?") as num
		var/SelectionR				=input("R?") as num
		var/SelectionG				=input("G?") as num
		var/SelectionB				=input("B?") as num
		var/SelectionTransform		=input("Transform?") as num
		var/SelectionBlendMode		=input("BlendMode?") as num

		E.filters	+= filter(type="layer" , x=SelectionX , y=SelectionY , render_source=SelectionRenderSource , flags=SelectionFlags , color=rgb(SelectionR,SelectionG,SelectionB) , transform=SelectionTransform , blend_mode=SelectionBlendMode)

	MotionBlur(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num

		E.filters	+= filter(type="motion_blur" , x=SelectionX , y=SelectionY)

	OutLine(mob/E)
		var/SelectionSize			=input("Size?") as num
		var/SelectionR				=input("R?") as num
		var/SelectionG				=input("G?") as num
		var/SelectionB				=input("B?") as num
		var/SelectionFlags			=input("Flags?") as num

		E.filters	+= filter(type="outline" , size=SelectionSize , color=rgb(SelectionR,SelectionG,SelectionB) , flags=SelectionFlags)

	RadianBlur(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num

		E.filters	+= filter(type="radial_blur" , x=SelectionX , y=SelectionY , size=SelectionSize)

	Rays(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num
		var/SelectionR				=input("R?") as num
		var/SelectionG				=input("G?") as num
		var/SelectionB				=input("B?") as num
		var/SelectionOffset			=input("Offset?") as num
		var/SelectionDensity		=input("Density?") as num
		var/SelectionThreshold		=input("Threshold?") as num
		var/SelectionFactor			=input("Factor?") as num
		var/SelectionFlag			=input("FILTER_OVERLAY | FILTER_UNDERLAY ?") as text

		E.filters	+= filter(type="rays" , x=SelectionX , y=SelectionY , size=SelectionSize , color=rgb(SelectionR,SelectionG,SelectionB) , offset=SelectionOffset , density=SelectionDensity ,threshold=SelectionThreshold , factor=SelectionFactor , flags=SelectionFlag )

	Ripple(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num
		var/SelectionRepeat			=input("Repeat?") as num
		var/SelectionRadius			=input("Radius?") as num
		var/SelectionFallOff		=input("FallOff?") as num
		var/SelectionFlag			=input("Flags?") as text

		E.filters	+= filter(type="ripple" , x=SelectionX , y=SelectionY , size=SelectionSize , repeat=SelectionRepeat , radius=SelectionRadius , falloff=SelectionFallOff , flag=SelectionFlag)

	Wave(mob/E)
		var/SelectionX				=input("X?") as num
		var/SelectionY				=input("Y?") as num
		var/SelectionSize			=input("Size?") as num
		var/SelectionOffset			=input("Offset?") as num
		var/SelectionFlag			=input("Flags?") as text

		E.filters	+= filter(type="wave", x=SelectionX , y=SelectionY , size=SelectionSize , offset=SelectionOffset , flag=SelectionFlag)


proc/
	ShakeEffect(mob/EF,var/Duration)
		var/duration=Duration
		while(duration)
			duration-=1
			EF.pixel_x+=rand(-5,5)
			EF.pixel_y+=rand(-5,5)
			if(!duration)
				EF.pixel_x=0
				EF.pixel_y=0
			sleep(1)

	MassShakeEffect(mob/EF,var/Duration)
		var/duration=Duration
		while(duration)
			duration-=1
			for(var/mob/player/M in view(EF)) if(M.client)
				EF.pixel_x+=rand(-5,5)
				EF.pixel_y+=rand(-5,5)
				if(!duration)
					EF.pixel_x=0
					EF.pixel_y=0
			sleep(1)

	ScreenShakeEffect(var/Amount,var/OffSet,mob/EF)
		while(Amount)
			Amount--
			EF.client.pixel_x=rand(-OffSet,OffSet)
			EF.client.pixel_y=rand(-OffSet,OffSet)
			sleep(1)

	HitEffect(mob/EF,mob/EF2)
		ImpactDust(EF,EF.dir)
//		FightingDirt(EF)
		ScreenShakeEffect(1,10,EF2)

	PushingEffect(mob/EF,mob/EF2)
		ImpactDust(EF,EF.dir)
		KBHole2(EF,get_dir(EF2,EF))
		ScreenShakeEffect(1,10,EF2)















