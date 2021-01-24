////////////////////////////////////////////////
// Garricks new SoD pre-joining dialogue file //
// The 15 stands for BG1.5 i.e., SoD          //
////////////////////////////////////////////////
BEGIN ~#LGar15S~
	IF ~Global("BD_Spoken_Garrick","GLOBAL",0) AreaCheck("BD0106") GlobalLT("BD_Plot","GLOBAL",54)~ BEGIN GARRICK_3KEG_1
		SAY @2110 /* ~Greetings <CHARNAME>.  How are you this fine <DAYNIGHT>?~ */
		++ @2111 /* ~I could be better.  Imoen and I were attacked.  She lies comatose in the palace as we speak.~ */ GOTO GARRICK_3KEG_2
	END

	IF ~~ BEGIN GARRICK_3KEG_2
		SAY @2112 /* ~Imoen is hurt?!  NO!!  Imoen!  I'm coming!~ */
		IF ~~ DO ~SetGlobal("BD_Spoken_Garrick","GLOBAL",1) EscapeAreaObjectMove("BD0103","TranBD0040",167,417,E)~ EXIT
	END

	IF ~AreaCheck("BD0103") Global("#L_GIBedside","MYAREA",1)~ BEGIN GARRICK_BEDSIDE_1
		SAY @2119 /* ~Oh, hello again <CHARNAME>.~ */
		IF ~OR(2) Global("#L_AICastHeal","GLOBAL",1) Global("#L_AICastSlowPoison","GLOBAL",1)~ GOTO GARRICK_BEDSIDE_1.2A
		IF ~Global("#L_AICastHeal","GLOBAL",0) Global("#L_AICastSlowPoison","GLOBAL",0)~ GOTO GARRICK_BEDSIDE_1.2B
	END

	IF ~~ BEGIN GARRICK_BEDSIDE_1.2A
		SAY @2114 /* ~I hear you probably saved her life.  I can't begin to thank you.~ */
		++ @2116 /* ~She looks so much better.  I'm sure she'll be up and around in now time.~ */ + GARRICK_BEDSIDE_1.3
	END

	IF ~~ BEGIN GARRICK_BEDSIDE_1.2B
		SAY @2115 /* ~Fenster is doing all he can do, but she's still out.~ */
		++ @2116 /* ~She looks so much better.  I'm sure she'll be up and around in now time.~ */ + GARRICK_BEDSIDE_1.3
	END

	IF ~~ BEGIN GARRICK_BEDSIDE_1.3
		SAY @2117 /* ~I won't leave her side until she is.~ */
		IF ~~ THEN DO ~StartCutSceneMode() SetGlobal("#L_GIBedside","MYAREA",2) Face(E) SmallWait(5) DisplayStringHead("GARRICK",@2118) Wait(3) EndCutSceneMode()~ EXIT
		// @2118 = ~Garrick goes back to focusing on Imoen, caressing her hand and whispering encouragement.~
	END

	IF ~AreaCheck("BD0103") Global("#L_GIBedside","MYAREA",2)~ BEGIN GARRICK_BEDSIDE_2
		SAY @2119 /* ~Oh, hello again <CHARNAME>.~ */
		IF ~~ GOTO GARRICK_BEDSIDE_2.2
	END

	IF ~~ BEGIN GARRICK_BEDSIDE_2.2
		SAY @2120 /* ~I really can't talk now.  I'm sorry.~ */
		IF ~~ THEN DO ~StartCutSceneMode() SetGlobal("#L_GIBedside","MYAREA",2) Face(E) SmallWait(5) DisplayStringHead("GARRICK",@2118) Wait(3) EndCutSceneMode()~ EXIT
		// @2118 = ~Garrick goes back to focusing on Imoen, caressing her hand and whispering encouragement.~
	END

	IF ~AreaCheck("BD0106") Global("BD_Plot","GLOBAL",54) Global("#L_GarrickRecuit","MYAREA",0)~ BEGIN GARRICK_RECRUIT_1
		SAY @2121 /* ~Did you hear the news, <CHARNAME>?  Imoen is up and doing SO much better!~ */
		++ @2122 /* ~I did hear.  And that's why I'm back to talk to you.  I want you to join me in bringing Caelar to justice for what she has done.  Will you join me against the crusade?~ */ + GARRICK_RECRUIT_1.2
	END

	IF ~~ BEGIN GARRICK_RECRUIT_1.2
		SAY @2123 /* ~I'd love to, <CHARNAME>, but Imoen needs me.  I just can't bring myself to leave her at this time.~ */
		++ @2124 /* ~I can't get you to change your mind?~ */ + GARRICK_RECRUIT_1.3
	END

	IF ~~ BEGIN GARRICK_RECRUIT_1.3
		SAY @2125 /* ~I'm afraid not.  I'd not even be here at the Three Old Kegs if she hadn't insisted.  But this is as far from her side as I'll go.~ */
		IF ~~ THEN DO ~SetGlobal("#L_GarrickRecuit","MYAREA",1)~ EXIT
	END

	IF ~AreaCheck("BD0106") Global("BD_Plot","GLOBAL",54) Global("#L_GarrickRecuit","MYAREA",1)~ BEGIN GARRICK_RECRUIT_2
		SAY @2119 /* ~Oh, hello again <CHARNAME>.~ */
		++ @2124 /* ~I can't get you to change your mind?~ */ + GARRICK_RECRUIT_1.3
	END
// End of new #LGar15S

///////////////////////////////////////////////////////////
// Fix Corwin's references to where Garrick can be found //
///////////////////////////////////////////////////////////
REPLACE_SAY BDSCHAEL 39 @2130 // ~There's a pair of ne'er-do-wells named Safana and Coran. They're at the Elfsong Tavern.~ */
REPLACE_SAY BDSCHAEL 63 @2131 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 93 @2131 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 109 @2131 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
REPLACE_SAY BDSCHAEL 123 @2131 // ~Garrick. He performs on a regular basis at the Three Old Kegs tavern.~
ALTER_TRANS BDSCHAEL
	BEGIN 63 93 109 123 END
	BEGIN 0 1 END
	BEGIN
		"TRIGGER" ~False()~
	END
EXTEND_TOP BDSCHAEL 63 #0
	IF ~~ THEN REPLY @2132 /* ~Ok, well, let's keep moving.~ */ GOTO 61
END
EXTEND_TOP BDSCHAEL 93 #0
	IF ~~ THEN REPLY @2132 /* ~Ok, well, let's keep moving.~ */ GOTO 95
END
EXTEND_TOP BDSCHAEL 109 #0
	IF ~~ THEN REPLY @2132 /* ~Ok, well, let's keep moving.~ */ GOTO 100
END
EXTEND_TOP BDSCHAEL 123 #0
	IF ~~ THEN REPLY @2132 /* ~Ok, well, let's keep moving.~ */ GOTO 118
END
REPLACE_SAY BDSCHAEL 54 @2133 // ~The Three Old Kegs isn't far from here. There's a bard and a pair of Rashemi travelers staying there. Duke Eltan thought you might speak with them.~
REPLACE_SAY BDSCHAEL 56 @2134 // ~The Grand Dukes thought you might want to talk with a bard named Garrick, a ranger named Minsc or a magician named Dynaheir. They're in the Three Old Kegs.~
REPLACE_SAY BDSCHAEL 59 @2135 // ~A bard named Garrick and a pair of Rashemi adventurers named Minsc and Dynaheir. They're staying at the Three Old Kegs, over on the west side of the street.~
REPLACE_SAY BDSCHAEL 66 @2136 // ~We aren't far from the Elfsong Tavern. A couple people you might want to speak with—Safana and Coran—have been seen there recently. Or if you'd like to get some supplies for the journey to Dragonspear, we can go to Sorcerous Sundries.~
REPLACE_SAY BDSCHAEL 68 @2137 // ~If you need gear, I should be able to get us into Sorcerous Sundries ahead of the rest of the line. You can also visit the Elfsong Tavern. A couple adventurers who might prove useful are staying there.~
REPLACE_SAY BDSCHAEL 70 @2138 // ~The ne'er-do-wells Safana and Coran. Waste of time, if you ask me. I wouldn't trust either one of them with half a rusted copper, much less my life. Let's go.~
ALTER_TRANS BDSCHAEL
	BEGIN 99 END
	BEGIN 2 END
	BEGIN
		"REPLY" ~@2139~ // ~You mentioned something about a bard at the Three Old Kegs tavern, didn't you?~
	END
REPLACE_SAY BDSCHAEL 115 @2140 // ~You tell me. We are to acquire equipment and allies for the trip north. There's a bard and a couple of Rashemi adventurers we can talk to at the Three Old Kegs, the thieves at the Elfsong Tavern, or a monk at the Iron Throne Building. Or we could just return to the palace.~
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
REPLACE_SAY BDSCHAEL 203 @2141 // ~Safana and Coran, a pair of unsavory characters staying upstairs Belt thinks might be of use. Why he'd think that, I don't know, but it's not my place to argue with a Grand Duke.~
ALTER_TRANS BDSCHAEL
	BEGIN 204 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~Global("BD_Spoken_Safana","GLOBAL",1)~
		"REPLY" ~@2142~ // ~I believe so. Coran was unable to join me. I spoke to Safana upstairs.~
	END
ALTER_TRANS BDSCHAEL
	BEGIN 204 END
	BEGIN 2 END
	BEGIN
		"TRIGGER" ~False()~
	END
REPLACE_SAY BDSCHAEL 277 @2143 // ~The bard Garrick, the witch Dynaheir and her bodyguard Minsc are staying at the Three Old Kegs...~
REPLACE_SAY BDSCHAEL 279 @2144 // ~You tell me. We are to acquire equipment and allies for the trip north. There's a bard and a couple of Rashemi adventurers we can talk to at the Three Old Kegs, the thieves at the Elfsong Tavern. Or we could just return to the palace.~
REPLACE_SAY BDSCHAEL 280 @2145 // ~You tell me. We are to acquire equipment and allies for the trip north. There's the thieves at the Elfsong Tavern, or a monk at the Iron Throne Building. Or we could just return to the palace.~
ALTER_TRANS BDSCHAEL
	BEGIN 280 END
	BEGIN 3 END
	BEGIN
		"TRIGGER" ~False()~
	END
REPLACE_SAY BDSCHAEL 281 @2146 // ~You tell me. We are to acquire equipment and allies for the trip north. There's the thieves at the Elfsong Tavern. Or we could just return to the palace.~
ALTER_TRANS BDSCHAEL
	BEGIN 281 END
	BEGIN 2 END
	BEGIN
		"TRIGGER" ~False()~
	END

/////////////////////////////////////////////////
// Have Garrick join the group when Imoen does //
// If Imoen Forever was installed first        //
/////////////////////////////////////////////////
%JOIN_WITH_IMOEN%

//////////////////////////////////////
// Garrick's SoD post dialogue file //
//////////////////////////////////////
REPLACE_STATE_TRIGGER BDGARRIC 6 ~False()~
REPLACE_STATE_TRIGGER BDGARRIC 11 ~False()~
REPLACE_STATE_TRIGGER BDGARRIC 36 ~False()~
REPLACE_STATE_TRIGGER BDGARRIC 44 ~False()~
APPEND BDGARRIC
	IF ~True()~ THEN BEGIN GARRICK_JOIN_1
		SAY @2150 /* ~Hello again, <CHARNAME>!  How may I be of service?~ */
		++ @2151 /* ~I'd like you to join me.~ */ GOTO GARRICK_JOIN_1.2A
		+ ~InParty("IMOEN2")~ + @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ + GARRICK_JOIN_1.2B
		+ ~!InParty("IMOEN2")~ + @2153 /* ~I'm just seeing how you're getting along.  Do you have everything you need?~ */ + GARRICK_JOIN_1.2C
	END

	IF ~~ THEN BEGIN GARRICK_JOIN_1.2A
		SAY @2152 /* ~Excellent!~ */
		IF ~~ THEN DO ~SetDialogue("BDGARRIJ") JoinParty()~ EXIT
	END

	IF ~~ THEN BEGIN GARRICK_JOIN_1.2B
		SAY @2155 /* ~I miss my lovely Immy, but besides that, I have everything I need.~ */
		++ @2156 /* ~Awww, ok, come along.~ */ + GARRICK_JOIN_1.2A
		++ @2157 /* ~I'm sorry, maybe later.~ */ EXIT
	END

	IF ~~ THEN BEGIN GARRICK_JOIN_1.2C
		SAY @2154 /* ~I have my lovely Immy, so I have everything I need.~ */
		IF ~~ THEN EXIT
	END
END

///////////////////////////////////////////////////////////////////
// Have Thaird set the area flag indicating it's ok to rest here //
// It's how I'll be able to tell that we're at 'an inn'          //
///////////////////////////////////////////////////////////////////
ALTER_TRANS BDTHAIRD
	BEGIN 2 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~RemoveAreaFlag(NOREST) SetGlobalTimer("#L_GIAtInn","MYAREA",ONE_HOUR) StartStore("bdthaird",LastTalkedToBy(Myself))~
	END

/////////////////////////////////////////
// Don't let Rayphus leave the area    //
// We need him to get Garrick in place //
/////////////////////////////////////////
ALTER_TRANS BDRAYPHU
	BEGIN 18 21 END
	BEGIN 0 END
	BEGIN 
		"ACTION" ~~
		"EPILOGUE" ~EXIT~ 
	END

////////////////////////////////////////
// Garricks's SoD party dialogue file //
////////////////////////////////////////
APPEND BDGARRIJ
END

/////////////////////////////////////
// Imoen's SoD party dialogue file //
/////////////////////////////////////
APPEND BDIMOEN
END
