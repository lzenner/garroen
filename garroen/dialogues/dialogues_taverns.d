///////////////////////////////////////////////////
// Post dialogues for when he's parked in an inn //
///////////////////////////////////////////////////


APPEND %GARRICK_POST%
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1) GlobalGT("#L_GIRomance","GLOBAL",5)~ THEN BEGIN NEW_GARRICK_3
		SAY @2200 // ~Hello <CHARNAME>. It's good to see you again.  Pull up a chair!~ 
		++ @2151 /* ~I'd like you to join me.~ */ GOTO JOIN_OF_COURSE
		+~InPartyAllowDead("IMOEN2") GlobalLT("#L_GIRomance","GLOBAL",11)~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO MISS_ROGUE
		+~InPartyAllowDead("IMOEN2") GlobalGT("#L_GIRomance","GLOBAL",10)~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO MISS_IMOEN
		+~!InPartyAllowDead("IMOEN2")~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO HAVE_EVERYTHING
		+~GlobalLT("#L_GIRomance","GLOBAL",11)~+ @2207 /* ~Can you join Imoen and me for a drink, Garrick?~ */ DO ~StartStore("#LGISto1",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",10) GlobalLT("#L_GIRomance","GLOBAL",21)~+ @2207 /* ~Can you join Imoen and me for a drink, Garrick?~ */ DO ~StartStore("#LGISto2",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",20) GlobalLT("#L_GIRomance","GLOBAL",31)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto3",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",30) GlobalLT("#L_GIRomance","GLOBAL",41)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto4",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",40) GlobalLT("#L_GIRomance","GLOBAL",51)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto5",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",50) GlobalLT("#L_GIRomance","GLOBAL",61)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto6",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",60) GlobalLT("#L_GIRomance","GLOBAL",76)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto7",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",75) GlobalLT("#L_GIRomance","GLOBAL",101)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto8",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",100)~+ @2208	/* ~Can you and Imoen join me for a drink?~ */ DO ~StartStore("#LGISto9",Player1)~ EXIT
		+~GlobalLT("#L_GIRomance","GLOBAL",11)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto1",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",10) GlobalLT("#L_GIRomance","GLOBAL",21)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto2",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",20) GlobalLT("#L_GIRomance","GLOBAL",31)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto3",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",30) GlobalLT("#L_GIRomance","GLOBAL",41)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto4",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",40) GlobalLT("#L_GIRomance","GLOBAL",51)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto5",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",50) GlobalLT("#L_GIRomance","GLOBAL",61)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto6",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",60) GlobalLT("#L_GIRomance","GLOBAL",76)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto7",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",75) GlobalLT("#L_GIRomance","GLOBAL",101)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto8",Player1)~ EXIT
		+~GlobalGT("#L_GIRomance","GLOBAL",100)~+ @2206 /* ~Can you tell me anything about this item I found?~ */ DO ~StartStore("#LGISto9",Player1)~ EXIT
	END
	
	IF ~~ BEGIN MISS_ROGUE
		SAY @2204 // ~I miss a certain roguish grin, but other than that, I'm fine.
		++ @2156 /* ~Awww, ok, come along.~ */ DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
		++ @2157 /* ~I'm sorry, maybe later.~*/ EXIT
	END

	IF ~~ BEGIN MISS_IMOEN
		SAY @2155 // ~I miss my lovely Immy, but besides that, I have everything I need.~
		++ @2156 /* ~Awww, ok, come along.~ */ DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
		++ @2157 /* ~I'm sorry, maybe later.~*/ EXIT
	END
	
	IF ~~ BEGIN HAVE_EVERYTHING
		SAY @2201 // ~I have absolutely everything I could hope for.~
		IF ~~ THEN EXIT
	END
	
	IF ~~ BEGIN JOIN_OF_COURSE
		SAY @2205 // ~Of course I'll join you.  Any time you need me!~
		IF ~~ THEN DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
	END
END
