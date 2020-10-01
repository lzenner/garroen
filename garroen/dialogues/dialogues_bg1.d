//////////////////////////////////////////////
// Post dialogues for BG1                   //
// Makes sure they both go to Feldepost Inn //
//////////////////////////////////////////////

EXTEND_BOTTOM %GARRICK_POST% 0 1
	IF ~!AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO GARRICK_TO_FELDEPOST
	IF ~AreaCheck("%Beregost_FeldepostsInn_L1%")~ GOTO GARRICK_AT_FELDEPOST
END

ALTER_TRANS %GARRICK_POST%
	BEGIN 3 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("KickedOut","LOCALS",0) SetGlobal("#L_GarrickFeldepost","GLOBAL",0) JoinParty()~
	END

APPEND %GARRICK_POST%
	IF ~~ BEGIN GARRICK_TO_FELDEPOST
		SAY @2000 /* ~I'll be at the Feldepost Inn in Beregost if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
		IF ~Global("T1M2LetterTimer","GLOBAL",0)~ DO ~SetGlobalTimer("T1M2LetterTimer","GLOBAL",TWO_DAYS) SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",900,510,SW)~ EXIT
	END


	IF ~~ BEGIN GARRICK_AT_FELDEPOST
		SAY @2001 /* ~And this is as good a place as any to perform.~ */
		IF ~~ DO ~SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([900.510]) Face(SW)~ EXIT
		IF ~Global("T1M2LetterTimer","GLOBAL",0)~ DO ~SetGlobalTimer("T1M2LetterTimer","GLOBAL",TWO_DAYS) SetGlobal("#L_GarrickFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([900.510]) Face(SW)~ EXIT
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
		IF ~Global("T1M2LetterTimer","GLOBAL",0)~ DO ~SetGlobalTimer("T1M2LetterTimer","GLOBAL",TWO_DAYS) SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) EscapeAreaMove("%Beregost_FeldepostsInn_L1%",780,580,NE)~ EXIT
	END

	IF ~~ BEGIN IMOEN_AT_FELDEPOST
		SAY @2002 /* ~I'll be right here if you need me in the future.~ */
		IF ~~ DO ~SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([900.510]) Face(NE)~ EXIT
		IF ~Global("T1M2LetterTimer","GLOBAL",0)~ DO ~SetGlobalTimer("T1M2LetterTimer","GLOBAL",TWO_DAYS) SetGlobal("#L_ImoenFeldepost","GLOBAL",1) SetGlobal("KickedOut","LOCALS",1) ChangeAIScript("",DEFAULT) MoveToPoint([780.580]) Face(NE)~ EXIT
		IF ~Global("KickedOut","LOCALS",1)~ EXIT
	END
END
