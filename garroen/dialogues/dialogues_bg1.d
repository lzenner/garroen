//////////////////////////////////////////////
// Post dialogues for BG1                   //
// Makes sure they both go to Fieldpost Inn //
//////////////////////////////////////////////

// Imoen seated at 700.545 facing NE
// Will need to get rid of actor at 
EXTEND_BOTTOM %GARRICK_POST% 0
	IF ~Global("KickedOut","LOCALS",0)~ GOTO GARRICK_TO_FIELDPOST
END

APPEND %GARRICK_POST%
	IF ~~ BEGIN GARRICK_TO_FIELDPOST
		SAY @2000 /* ~I'll be at the Fieldpost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobalTimer("#L_GIParkedDay","GLOBAL",ONE_DAY) SetGlobal("#L_GarrickFieldpost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END
END

EXTEND_BOTTOM %IMOEN_POST% 0 1
	IF ~Global("KickedOut","LOCALS",0)~ GOTO IMOEN_TO_FIELDPOST
END

APPEND %IMOEN_POST%
	IF ~~ BEGIN IMOEN_TO_FIELDPOST
		SAY @2000 /* ~I'll be at the Fieldpost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobalTimer("#L_GIParkedDay","GLOBAL",ONE_DAY) SetGlobal("#L_ImoenFieldpost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",780,580,NE)~ EXIT
	END
END
