mob/proc/CapStats(RateOfCap=1)
//	if(BaseMaxKi<SoftStatCap*KiMod*RateOfCap) BaseMaxKi=SoftStatCap*KiMod*RateOfCap				ENERGYUPDATE
	if(StrMod<SoftStatCap*StrMod*RateOfCap) StrMod=SoftStatCap*StrMod*RateOfCap
	if(EndMod<SoftStatCap*EndMod*RateOfCap) EndMod=SoftStatCap*EndMod*RateOfCap
	if(SpdMod<SoftStatCap*SpdMod*RateOfCap) SpdMod=SoftStatCap*SpdMod*RateOfCap
	if(OffMod<SoftStatCap*OffMod*RateOfCap) OffMod=SoftStatCap*OffMod*RateOfCap
	if(DefMod<SoftStatCap*DefMod*RateOfCap) DefMod=SoftStatCap*DefMod*RateOfCap
//	UpdateStats("All")