//////////////////////////////////////////////
// Post dialogues for BG1                   //
// Makes sure they both go to Feldepost Inn //
//////////////////////////////////////////////


ALTER_TRANS GARRIC 
	BEGIN 3 6 12 END
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~Global("#L_ImoenInPalace","GLOBAL",0)~
		"ACTION" ~~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 3 #0
	IF ~Global("#L_ImoenInPalace","GLOBAL",1)~ THEN REPLY #200552 GOTO GARRIC_TO_TOK
END
EXTEND_TOP GARRIC 6 #0
	IF ~Global("#L_ImoenInPalace","GLOBAL",1)~ THEN REPLY #200556 GOTO GARRIC_TO_TOK
END
EXTEND_TOP GARRIC 12 #0
	IF ~Global("#L_ImoenInPalace","GLOBAL",1)~ THEN REPLY #214735 GOTO GARRIC_TO_TOK
END

ALTER_TRANS GARRIC 
	BEGIN 7 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~Global("#L_ImoenInPalace","GLOBAL",0)~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 7 #1
	IF ~Global("#L_ImoenInPalace","GLOBAL",1)~ THEN REPLY #200557 GOTO GARRIC_TO_TOK
END

ALTER_TRANS GARRIC 
	BEGIN 13 END
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~Global("#L_ImoenInPalace","GLOBAL",0)~
		"ACTION" ~SetDialogue("GARRIJ") LeaveParty()~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 13 #0
	IF ~Global("#L_ImoenInPalace","GLOBAL",1)~ THEN REPLY #214736 DO ~SetDialogue("GARRIJ") LeaveParty()~ GOTO GARRIC_TO_TOK
END

APPEND GARRIC
	IF ~~ BEGIN GARRIC_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END

	IF ~~ BEGIN GARRIC_TO_TOK
		SAY	@2003 // ~I'll be at Three Old Keg's in North Baldur's Gate if you need me in the future.~
		IF ~~ DO ~SetGlobal("#L_GarrickTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%NBaldursGate_ThreeOldKegs_L1%",360,140,SE)~ EXIT
	END
END

EXTEND_BOTTOM %GARRICK_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%") Global("#L_ImoenInPalace","GLOBAL",0)~ GOTO GARRICK_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%") Global("#L_ImoenInPalace","GLOBAL",0)~ GOTO GARRICK_AT_FELDEPOST
	IF ~!AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") Global("#L_ImoenInPalace","GLOBAL",1)~ GOTO GARRICK_TO_TOK
	IF ~AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") Global("#L_ImoenInPalace","GLOBAL",1)~ GOTO GARRICK_AT_TOK
END

// Shake off all the mods trying to send garrick to other areas
REPLACE_STATE_TRIGGER %GARRICK_POST% 2 ~False()~

ALTER_TRANS %GARRICK_POST%
	BEGIN 3 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~
	END

APPEND %GARRICK_POST%
	// Replacement for state #2
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1) GlobalLT("#L_GIRomance","GLOBAL",6)~ THEN BEGIN NEW_GARRICK_2
		SAY #215778 /* ~You're back! And just in time, too. I need material for a few more verses of my tribute to our friendship.~ */
		IF ~~ THEN REPLY #215781 /* ~It would be a pleasure to have your company again. A good bard is always a welcome companion.~ */ GOTO 3
		IF ~~ THEN REPLY #215782 /* ~Sorry, but I really don't want you back just yet.~ */ GOTO 0
	END

	IF ~~ BEGIN GARRICK_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END

	IF ~~ BEGIN GARRICK_AT_FELDEPOST
		SAY @2001 /* ~And this is as good a place as any to perform.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([900.510]) Face(SW)~ EXIT
		IF ~Global("KickedOut","LOCALS",1)~ EXIT
	END

	IF ~~ BEGIN GARRICK_TO_TOK
		SAY	@2003 // ~I'll be at Three Old Keg's in North Baldur's Gate if you need me in the future.~
		IF ~~ DO ~SetGlobal("#L_GarrickTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%NBaldursGate_ThreeOldKegs_L1%",360,140,SE)~ EXIT
	END

	IF ~~ BEGIN GARRICK_AT_TOK
		SAY @2001 /* ~And this is as good a place as any to perform.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([360.140]) Face(SE)~ EXIT
		IF ~Global("KickedOut","LOCALS",1)~ EXIT
	END

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

ALTER_TRANS %IMOEN_POST%
	BEGIN 4 END
	BEGIN 0 END
	BEGIN "ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_ImoenFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ END

EXTEND_BOTTOM %IMOEN_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_AT_FELDEPOST
END

// Shake off all the mods trying to send Imoen to other areas
REPLACE_STATE_TRIGGER %IMOEN_POST% 2 ~False()~

APPEND %IMOEN_POST%
	// Replacement for state #2
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1) GlobalLT("#L_GIRomance","GLOBAL",6)~ THEN BEGIN NEW_IMOEN_2
		SAY #216412 /* ~You old rumjake fool! I knew you'd be back! Let's get back to traveling the good road, eh?~ */
		IF ~~ THEN REPLY #216413 /* ~Sorry, kiddo, but I don't need your company just yet.~ */ GOTO 3
		IF ~~ THEN REPLY #216414 /* ~Sorry to have kept you waiting. Let's get going.~ */ GOTO 4
		%TRANSITIONS_IMOEN_TRAIN%
	END

	IF ~~ BEGIN IMOEN_TO_FELDEPOST
		SAY @2000 /* ~I'll be at Feldepost's Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",780,580,NE)~ EXIT
	END

	IF ~~ BEGIN IMOEN_AT_FELDEPOST
		SAY @2002 /* ~I'll be right here if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([780.580]) Face(NE)~ EXIT
		IF ~Global("KickedOut","LOCALS",1)~ EXIT
	END
	
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1) GlobalGT("#L_GIRomance","GLOBAL",5)~ THEN BEGIN NEW_IMOEN_3
		SAY @2200 // ~Hello <CHARNAME>. It's good to see you again.  Pull up a chair!~ 
		++ @2151 /* ~I'd like you to join me.~ */ GOTO JOIN_OF_COURSE
		+~InPartyAllowDead("GARRICK") GlobalLT("#L_GIRomance","GLOBAL",11)~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO MISS_BARD
		+~InPartyAllowDead("GARRICK") GlobalGT("#L_GIRomance","GLOBAL",10)~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO MISS_GARRICK
		+~!InPartyAllowDead("GARRICK")~+ @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ GOTO HAVE_EVERYTHING
		%TRANSITIONS_IMOEN_TRAIN%
	END
	
	IF ~~ BEGIN MISS_BARD
		SAY @2202 // ~I miss a certain bard, but other than that, I'm fine.~
		++ @2156 /* ~Awww, ok, come along.~ */ DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_ImoenFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
		++ @2157 /* ~I'm sorry, maybe later.~*/ EXIT
	END

	IF ~~ BEGIN MISS_GARRICK
		SAY @2203 // ~I miss my Garrick, but other than that, I'm fine.~
		++ @2156 /* ~Awww, ok, come along.~ */ DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_ImoenFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
		++ @2157 /* ~I'm sorry, maybe later.~*/ EXIT
	END
	
	IF ~~ BEGIN HAVE_EVERYTHING
		SAY @2201 // ~I have absolutely everything I could hope for.~
		IF ~~ THEN EXIT
	END
	
	IF ~~ BEGIN JOIN_OF_COURSE
		SAY @2205 // ~Of course I'll join you.  Any time you need me!~
		IF ~~ THEN DO ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_ImoenFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ EXIT
	END
END

/////////////////////////////////
// Rumors for Garrick's stores //
/////////////////////////////////
BEGIN ~#LGISto1~	// Days 5-10
	IF ~True()~ BEGIN RUMOR1
		SAY @2300 // ~During Garrick's next break, you, he, and Imoen find a table in the corner, order a round of drinks, and catch up on what's been happening.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto1

BEGIN ~#LGISto2~	// Days 11-20
	IF ~True()~ BEGIN RUMOR1
		SAY @2301 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. You notice Garrick and Imoen holding hands throughout the entire conversation.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto2

BEGIN ~#LGISto3~	// Days 21-30
	IF ~True()~ BEGIN RUMOR1
		SAY @2302 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Garrick gives Imoen a tender kiss before returning to the stage.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto3

BEGIN ~#LGISto4~	// Days 31-40
	IF ~GlobalLT("#L_GIRomance","GLOBAL",36)~ BEGIN RUMOR1
		SAY @2302 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Garrick gives Imoen a tender kiss before returning to the stage.~
		IF ~~ THEN EXIT
	END
	
	IF ~GlobalGT("#L_GIRomance","GLOBAL",35)~ THEN BEGIN RUMOR2
		SAY @2303 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Through the entire conversation, ...
		IF ~~ THEN EXIT
	END
// End of new #LGISto4

BEGIN ~#LGISto5~	// Days 41-50
	IF ~True()~ BEGIN RUMOR1
		SAY @2303 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Through the entire conversation, ...
		IF ~~ THEN EXIT
	END
// End of new #LGISto5

BEGIN ~#LGISto6~	// Days 51-60
	IF ~True()~ BEGIN RUMOR1
		SAY @2304 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Garrick and Imoen seem to find it impossible to keep their hands to themselves to the point you suggest they get a room.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto6

BEGIN ~#LGISto7~	// Days 61-75
	IF ~True()~ BEGIN RUMOR1
		SAY @2304 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Garrick and Imoen seem to find it impossible to keep their hands to themselves to the point you suggest they get a room.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto7

BEGIN ~#LGISto8~	// Days 76-100
	IF ~True()~ BEGIN RUMOR1
		SAY @2305 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. ~Imoen can't wait to show you her engagement ring and the ensuing conversation is all about wedding plans.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto8

BEGIN ~#LGISto9~	// Days 100 ->
	IF ~GlobalLT("#L_GIRomance","GLOBAL",126)~ BEGIN RUMOR1
		SAY @2306 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Imoen and Garrick talk excitedly about married life, at times sharing way too much information.~
		IF ~~ THEN EXIT
	END

	IF ~GlobalGT("#L_GIRomance","GLOBAL",125)~ BEGIN RUMOR2
		SAY @2307 // ~After catching up on current events, you fondly reminisce about the past.~
		IF ~~ THEN EXIT
	END
// End of new #LGISto9

