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
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1)~ THEN BEGIN NEW_GARRICK_2
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
END

ALTER_TRANS %IMOEN_POST%
	BEGIN 4 END
	BEGIN 0 END
	BEGIN "ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GIAtInn","GLOBAL",0) ActionOverride("imoen",JoinParty())~ END

EXTEND_BOTTOM %IMOEN_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_AT_FELDEPOST
END

// Shake off all the mods trying to send Imoen to other areas
REPLACE_STATE_TRIGGER %IMOEN_POST% 2 ~False()~

APPEND %IMOEN_POST%
	// Replacement for state #2
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1)~ THEN BEGIN NEW_IMOEN_2
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
END

