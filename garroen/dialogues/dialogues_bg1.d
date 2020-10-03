//////////////////////////////////////////////
// Post dialogues for BG1                   //
// Makes sure they both go to Feldepost Inn //
//////////////////////////////////////////////


ALTER_TRANS GARRIC 
	BEGIN 3 6 12 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END

ALTER_TRANS GARRIC 
	BEGIN 7 END
	BEGIN 1 END
	BEGIN
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END

ALTER_TRANS GARRIC 
	BEGIN 13 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetDialogue("GARRIJ") LeaveParty()~
		"EPILOGUE" ~GOTO GARRIC_TO_FELDEPOST~
	END

APPEND GARRIC
	IF ~~ BEGIN GARRIC_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END
END

EXTEND_BOTTOM %GARRICK_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO GARRICK_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO GARRICK_AT_FELDEPOST
END

// Shake off all the mods trying to send garrick to other areas
REPLACE_STATE_TRIGGER %GARRICK_POST% 2 ~False()~

ALTER_TRANS %GARRICK_POST%
	BEGIN 3 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) JoinParty()~
	END

APPEND %GARRICK_POST%
	// Replacement for state #2
	IF ~!HappinessLT(Myself,UNHAPPY_ANGRY_BOUNDARY) Global("KickedOut","LOCALS",1)~ THEN BEGIN NEW_STATE_2
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
END

EXTEND_BOTTOM %IMOEN_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO IMOEN_AT_FELDEPOST
END

APPEND %IMOEN_POST%
	IF ~~ BEGIN IMOEN_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",780,580,NE)~ EXIT
	END

	IF ~~ BEGIN IMOEN_AT_FELDEPOST
		SAY @2002 /* ~I'll be right here if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([900.510]) Face(NE)~ EXIT
		IF ~Global("KickedOut","LOCALS",1)~ EXIT
	END
END
