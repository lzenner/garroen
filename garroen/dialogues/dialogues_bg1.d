///////////////////////
// Dialogues for BG1 //
///////////////////////

// Make sure they go to the correct inn
ALTER_TRANS GARRIC 
	BEGIN 3 6 12 END
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~GlobalLT("Chapter","GLOBAL",5)~
		"ACTION" ~~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 3 #0
	IF ~GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ THEN REPLY #200552 GOTO GARRIC_TO_TOK
END
EXTEND_TOP GARRIC 6 #0
	IF ~GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ THEN REPLY #200556 GOTO GARRIC_TO_TOK
END
EXTEND_TOP GARRIC 12 #0
	IF ~GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ THEN REPLY #214735 GOTO GARRIC_TO_TOK
END

ALTER_TRANS GARRIC 
	BEGIN 7 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~GlobalLT("Chapter","GLOBAL",5)~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 7 #1
	IF ~GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ THEN REPLY #200557 GOTO GARRIC_TO_TOK
END

ALTER_TRANS GARRIC 
	BEGIN 13 END
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~GlobalLT("Chapter","GLOBAL",5)~
		"ACTION" ~~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END
EXTEND_TOP GARRIC 13 #0
	IF ~GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ THEN REPLY #214736 GOTO GARRIC_TO_TOK
END

APPEND GARRIC
	IF ~~ BEGIN GARRIC_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) SetDialogue("%GARRICK_POST%") ChangeAIScript("",DEFAULT) LeaveParty() EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END

	IF ~~ BEGIN GARRIC_TO_TOK
		SAY	@2003 // ~I'll be at Three Old Keg's in North Baldur's Gate if you need me in the future.~
		IF ~~ DO ~SetGlobal("#L_GarrickTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) SetDialogue("%GARRICK_POST%") ChangeAIScript("",DEFAULT) LeaveParty() EscapeAreaMove("%NBaldursGate_ThreeOldKegs_L1%",360,140,SE)~ EXIT
	END
END

EXTEND_BOTTOM %GARRICK_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%") GlobalLT("Chapter","GLOBAL",5)~ GOTO GARRICK_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%") GlobalLT("Chapter","GLOBAL",5)~ GOTO GARRICK_AT_FELDEPOST
	IF ~!AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ GOTO GARRICK_TO_TOK
	IF ~AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ GOTO GARRICK_AT_TOK
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
		SAY #%GARRICK_SAY_YOURE_BACK% /* ~You're back! And just in time, too. I need material for a few more verses of my tribute to our friendship.~ */
		IF ~~ THEN REPLY #%GARRICK_REPLY_WELCOME% /* ~It would be a pleasure to have your company again. A good bard is always a welcome companion.~ */ GOTO 3
		IF ~~ THEN REPLY #%GARRICK_REPLY_SORRY% /* ~Sorry, but I really don't want you back just yet.~ */ GOTO 0
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
	
	// He uses the tavern post dialogue in BG1 (added separately)
END

ALTER_TRANS %IMOEN_POST%
	BEGIN 4 END
	BEGIN 0 END
	BEGIN "ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_ImoenFeldepost","GLOBAL",0) SetGlobal("#L_GIAtInn","GLOBAL",0) JoinParty()~ END

EXTEND_BOTTOM %IMOEN_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%") GlobalLT("Chapter","GLOBAL",5)~ GOTO IMOEN_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%") GlobalLT("Chapter","GLOBAL",5)~ GOTO IMOEN_AT_FELDEPOST
	IF ~!AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ GOTO IMOEN_TO_TOK
	IF ~AreaCheck("%NBaldursGate_ThreeOldKegs_L1%") GlobalGT("Chapter","GLOBAL",4) Global("EndOfBG1","GLOBAL",0)~ GOTO IMOEN_AT_TOK
END

// Shake off all the mods trying to send Imoen to other areas
REPLACE_STATE_TRIGGER %IMOEN_POST% 2 ~False()~

APPEND %IMOEN_POST%
	// Replacement for state #2
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1) GlobalLT("#L_GIRomance","GLOBAL",6)~ THEN BEGIN NEW_IMOEN_2
		SAY #%IMOEN_SAY_YOURE_BACK% /* ~You old rumjake fool! I knew you'd be back! Let's get back to traveling the good road, eh?~ */
		IF ~~ THEN REPLY #%IMOEN_REPLY_SORRY% /* ~Sorry, kiddo, but I don't need your company just yet.~ */ GOTO 3
		IF ~~ THEN REPLY #%IMOEN_REPLY_WELCOME% /* ~Sorry to have kept you waiting. Let's get going.~ */ GOTO 4
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
	
	IF ~~ BEGIN IMOEN_TO_TOK
		SAY	@2003 // ~I'll be at Three Old Keg's in North Baldur's Gate if you need me in the future.~
		IF ~~ DO ~SetGlobal("#L_ImoenTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%NBaldursGate_ThreeOldKegs_L1%",365,215,N)~ EXIT
	END

	IF ~~ BEGIN IMOEN_AT_TOK
		SAY @2002 /* ~I'll be right here if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenTOK_BG1","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([365.215]) Face(N)~ EXIT
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

	// Off to the wedding
	IF WEIGHT #-98 ~GlobalGT("#L_GIAwayForWedding","GLOBAL",0) GlobalGT("Chapter","GLOBAL",4)~ BEGIN COME_ALONG_POND_1
		SAY @2084 // ~Come along, <CHARNAME>.  You don't think we'd hold the ceremony without you, do ya?~
		IF ~~ THEN DO ~StartCutSceneMode() StartCutSceneEx("#LGIWeda",TRUE)~ EXIT
	END

	IF WEIGHT #-97 ~GlobalGT("#L_GIAwayForWedding","GLOBAL",0) GlobalLT("Chapter","GLOBAL",5)~ BEGIN COME_ALONG_POND_2
		SAY @2084 // ~Come along, <CHARNAME>.  You don't think we'd hold the ceremony without you, do ya?~
		++ @2085 /* ~But Baldur's Gate is closed?  How will we get to the Lady's House?~ */ GOTO SNEAK_IN
	END
	
	IF ~~ BEGIN SNEAK_IN
		SAY @2086 // ~Don't be daft!  How ya think?  We'll sneak in.  I hired a smuggler to guide us.  Friends in low places and all that.~
		IF ~~ THEN DO ~StartCutSceneMode() StartCutSceneEx("#LGIWeda",TRUE)~ EXIT
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
		SAY @2305 // ~During Garrick's next break, the three of you find a quiet table to share a drink and chat. Imoen can't wait to show you her engagement ring and the ensuing conversation is all about wedding plans.~
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

////////////////////////////////
// SHOAL THE NEREID ENCOUNTER //
////////////////////////////////
APPEND SHOAL
	IF WEIGHT #-1 ~NumTimesTalkedTo(0) IsGabber("GARRICK") IsValidForPartyDialogue("GARRICK") IsValidForPartyDialogue("%IMOEN_DV%") GlobalGT("#L_GIRomance","GLOBAL",10)~ BEGIN SHOAL_1
		SAY #201974 /* ~Please to help me, will you? I am alone on this desolate dry-land and who knows what lurks in these woods.~ */
		IF ~~ THEN REPLY @2600 /* ~Accompany us and we will make certain you are safe!~ */ GOTO SHOAL_2
	END
	
	IF ~~ BEGIN SHOAL_2
		SAY #201976 /* ~Wonderful! Perhaps a kiss to show my appreciation?~ */
		IF ~~ THEN EXTERN %IMOEN_JOINED% SHOAL_KISS
	END
END

APPEND %IMOEN_JOINED%
	IF ~~ BEGIN SHOAL_KISS
		SAY @2601 // ~Keep your lips to yourself, you watery tart!~
		IF ~~ THEN EXTERN SHOAL 3
	END
END

///////////////////////////
// FELDEPOST'S BARTENDER //
///////////////////////////
APPEND BART5
	IF WEIGHT #-99 ~OR(2) Global("#L_GarrickTOK_BG1","GLOBAL",1) Global("#L_GarrickTOK_SoD","GLOBAL",1) OR(2) Global("#L_ImoenTOK_BG1","GLOBAL",1) Global("#L_ImoenInPalace","GLOBAL",1) Global("#L_GIMovedMsg","MYAREA",0)~ THEN BEGIN THEY_MOVED
		SAY @2650 // ~Your young friend, Imoen, told me to let you know they've up and moved to Baldur's Gate. I guess Garrick got himself a permanent gig at Three Old Kegs.  We'll miss him 'round here.~
		IF ~~ THEN DO ~SetGlobal("#L_GIMovedMsg","MYAREA",1)~ EXIT
	END

	IF WEIGHT #-98 ~OR(2) Global("#L_ImoenTOK_BG1","GLOBAL",1) Global("#L_ImoenInPalace","GLOBAL",1) Global("#L_GIMovedMsg","MYAREA",0)~ THEN BEGIN SHE_MOVED
		SAY @2651 // ~Your young friend, Imoen, told me to let you know she's up and moved to Baldur's Gate. She mentioned Three Old Kegs...maybe I should warn the Flaming Fist 'bout her.~
		IF ~~ THEN DO ~SetGlobal("#L_GIMovedMsg","MYAREA",1)~ EXIT
	END

	IF WEIGHT #-97 ~OR(2) Global("#L_GarrickTOK_BG1","GLOBAL",1) Global("#L_GarrickTOK_SoD","GLOBAL",1) Global("#L_GIMovedMsg","MYAREA",0)~ THEN BEGIN HE_MOVED
		SAY @2652 // ~Business sure has been off since that young bard, Garrick, up and moved to Baldur's Gate. I guess he got himself a permanent gig at Three Old Kegs.  We'll miss him 'round here.~
		IF ~~ THEN DO ~SetGlobal("#L_GIMovedMsg","MYAREA",1)~ EXIT
	END
END


//////////////////////////////////////////////////////////////
// Mendelas calls cut scene that needs to evaluate triggers //
//////////////////////////////////////////////////////////////
ALTER_TRANS MENDA2
	BEGIN 3 END
	BEGIN 0 END
	BEGIN "ACTION" ~ClearAllActions() StartCutSceneMode() StartCutSceneEx("ISLON",TRUE)~ END
