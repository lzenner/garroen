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
REPLACE_SAY BDSCHAEL 39 @2120 // ~There's a pair of ne'er-do-wells named Safana and Coran. They're at the Elfsong Tavern.~ */
REPLACE_SAY BDSCHAEL 63 @2121 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 93 @2121 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 109 @2121 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 123 @2121 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
ALTER_TRANS BDSCHAEL
	BEGIN 63 93 109 123 END
	BEGIN 0 1 END
	BEGIN
		"TRIGGER" ~False()~
	END
EXTEND_TOP BDSCHAEL 63 #0
	IF ~~ THEN REPLY @2122 /* ~Ok, well, let's keep moving.~ */ GOTO 61
END
EXTEND_TOP BDSCHAEL 93 #0
	IF ~~ THEN REPLY @2122 /* ~Ok, well, let's keep moving.~ */ GOTO 95
END
EXTEND_TOP BDSCHAEL 109 #0
	IF ~~ THEN REPLY @2122 /* ~Ok, well, let's keep moving.~ */ GOTO 100
END
EXTEND_TOP BDSCHAEL 123 #0
	IF ~~ THEN REPLY @2122 /* ~Ok, well, let's keep moving.~ */ GOTO 118
END
REPLACE_SAY BDSCHAEL 54 @2123 // ~The Three Old Kegs isn't far from here. There's a bard and a pair of Rashemi travelers staying there. Duke Eltan thought you might speak with them.~
REPLACE_SAY BDSCHAEL 56 @2124 // ~The Grand Dukes thought you might want to talk with a bard named Garrick, a ranger named Minsc or a magician named Dynaheir. They're in the Three Old Kegs.~
REPLACE_SAY BDSCHAEL 59 @2125 // ~A bard named Garrick and a pair of Rashemi adventurers named Minsc and Dynaheir. They're staying at the Three Old Kegs, over on the west side of the street.~
REPLACE_SAY BDSCHAEL 66 @2126 // ~We aren't far from the Elfsong Tavern. A couple people you might want to speak with—Safana and Coran—have been seen there recently. Or if you'd like to get some supplies for the journey to Dragonspear, we can go to Sorcerous Sundries.~
REPLACE_SAY BDSCHAEL 68 @2127 // ~If you need gear, I should be able to get us into Sorcerous Sundries ahead of the rest of the line. You can also visit the Elfsong Tavern. A couple adventurers who might prove useful are staying there.~
REPLACE_SAY BDSCHAEL 70 @2128 // ~The ne'er-do-wells Safana and Coran. Waste of time, if you ask me. I wouldn't trust either one of them with half a rusted copper, much less my life. Let's go.~
ALTER_TRANS BDSCHAEL
	BEGIN 99 END
	BEGIN 2 END
	BEGIN
		"REPLY" ~@2129~ // ~You mentioned something about a bard at the Three Old Kegs tavern, didn't you?~
	END
REPLACE_SAY BDSCHAEL 115 @2130 // ~You tell me. We are to acquire equipment and allies for the trip north. There's a bard and a couple of Rashemi adventurers we can talk to at the Three Old Kegs, the thieves at the Elfsong Tavern, or a monk at the Iron Throne Building. Or we could just return to the palace.~
ALTER_TRANS BDSCHAEL
	BEGIN 199 END
	BEGIN 1 END
	BEGIN
		"ACTION" ~~
		"EPILOGUE" "GOTO 203"
	END
ALTER_TRANS BDSCHAEL
	BEGIN 200 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~False()~
	END
REPLACE_SAY BDSCHAEL 203 @2131 // ~Safana and Coran, a pair of unsavory characters staying upstairs Belt thinks might be of use. Why he'd think that, I don't know, but it's not my place to argue with a Grand Duke.~
ALTER_TRANS BDSCHAEL
	BEGIN 204 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~Global("BD_Spoken_Safana","GLOBAL",1)~
		"REPLY" ~@2132~ // ~I believe so. Coran was unable to join me. I spoke to Safana upstairs.~
	END
ALTER_TRANS BDSCHAEL
	BEGIN 204 END
	BEGIN 2 END
	BEGIN
		"TRIGGER" ~False()~
	END
REPLACE_SAY BDSCHAEL 277 @2133 // ~The bard Garrick, the witch Dynaheir and her bodyguard Minsc are staying at the Three Old Kegs...~
REPLACE_SAY BDSCHAEL 279 @2134 // ~You tell me. We are to acquire equipment and allies for the trip north. There's a bard and a couple of Rashemi adventurers we can talk to at the Three Old Kegs, the thieves at the Elfsong Tavern. Or we could just return to the palace.~
REPLACE_SAY BDSCHAEL 280 @2135 // ~You tell me. We are to acquire equipment and allies for the trip north. There's the thieves at the Elfsong Tavern, or a monk at the Iron Throne Building. Or we could just return to the palace.~
ALTER_TRANS BDSCHAEL
	BEGIN 280 END
	BEGIN 3 END
	BEGIN
		"TRIGGER" ~False()~
	END
REPLACE_SAY BDSCHAEL 281 @2136 // ~You tell me. We are to acquire equipment and allies for the trip north. There's the thieves at the Elfsong Tavern. Or we could just return to the palace.~
ALTER_TRANS BDSCHAEL
	BEGIN 281 END
	BEGIN 2 END
	BEGIN
		"TRIGGER" ~False()~
	END
