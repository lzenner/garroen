////////////////////////////////////////////////
// Garricks new SoD pre-joining dialogue file //
// The 15 stands for BG1.5 i.e., SoD          //
////////////////////////////////////////////////
BEGIN ~#LGar15S~
	IF ~Global("BD_Spoken_Garrick","GLOBAL",0)~ BEGIN GARRICK_3KEG_1
		SAY @2110 /* ~Greetings <CHARNAME>.  How are you this fine <DAYNIGHT>?~ */
		++ @2111 /* ~I could be better.  Imoen and I were attacked.  She lies comatose in the palace as we speak.~ */ GOTO GARRICK_3KEG_2
	END

	IF ~~ BEGIN GARRICK_3KEG_2
		SAY @2112 /* ~Imoen is hurt?!  NO!!  Imoen!  I'm coming!~ */
		IF ~~ DO ~SetGlobal("BD_Spoken_Garrick","GLOBAL",1) EscapeAreaObjectMove("BD0103","TranBD0040",167,417,E)~ EXIT
	END
// End of new #LGar15S

///////////////////////////////////////////////////////////
// Fix Corwin's references to where Garrick can be found //
///////////////////////////////////////////////////////////
REPLACE_SAY BDSCHAEL 39 @2113 // ~There's a pair of ne'er-do-wells named Safana and Coran. They're at the Elfsong Tavern.~ */
REPLACE_SAY BDSCHAEL 63 @2114 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
ALTER_TRANS BDSCHAEL
	BEGIN 63 END
	BEGIN 0 1 END
	BEGIN
		"TRIGGER" ~False()~
	END
EXTEND_TOP BDSCHAEL 39 #0 BEGIN
	IF ~~ THEN REPLY @2115 /* ~Ok, well, let's keep moving.~ */ GOTO 61
END