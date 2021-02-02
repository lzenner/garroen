///////////////////////////
// SITUATIONAL DIALOGUES //
///////////////////////////
APPEND ~%IMOEN_JOINED%~
	IF WEIGHT #-99 ~Global("#L_GIPine","GLOBAL",1)~ BEGIN PINE_1
		SAY @2404 // ~*sighs heavily*~
		IF ~RandomNum(8,1)~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
		IF ~RandomNum(8,2)~ THEN GOTO PINE_2
		IF ~RandomNum(8,3)~ THEN GOTO PINE_3
		IF ~RandomNum(8,4)~ THEN GOTO PINE_4
		IF ~RandomNum(8,5)~ THEN GOTO PINE_5
		IF ~RandomNum(8,6)~ THEN GOTO PINE_6
		IF ~RandomNum(8,7)~ THEN GOTO PINE_7
		IF ~RandomNum(8,8)~ THEN GOTO PINE_8
	END

	IF ~~ BEGIN PINE_2
		SAY @2400 // ~I wonder what Garrick is doing.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END
	
	IF ~~ BEGIN PINE_3
		SAY @2402 // ~Do you think Garrick thinks of me?~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_4
		SAY @2407 // ~I hope Garrick is ok all alone.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END
	
	IF ~~ BEGIN PINE_5
		SAY @2409 // ~I miss Garrick.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_6
		SAY @2411 // ~Garrick has this funny little way he...uh...never mind.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_7
		SAY @2413 // ~I don't suppose we could visit Garrick any time soon?~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_8
		SAY @2415 // ~I think Garrick would make a great addition to the group.  We should go get him.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END
	
	IF ~~ BEGIN NICE_SPOT
		SAY @2501 // ~We should stop and rest, just for a little while.  <CHARNAME> can we stop for a little while and ... uh ... relax?~
		++ @2502 /* ~I guess. Sure. Everyone, set up camp. We're resting here.~ */ DO ~SetGlobalTimer("#L_GISpotTimer","GLOBAL",ONE_DAY) RestParty()~ EXIT
		++ @2503 /* ~Imoen, now is not the time. Sorry.~ */ EXIT
	END
END

APPEND ~%GARRICK_JOINED%~
	IF WEIGHT #-99 ~Global("#L_GIPine","GLOBAL",1)~ BEGIN PINE_1
		SAY @2404 // ~*sighs heavily*~
		IF ~RandomNum(8,1)~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
		IF ~RandomNum(8,2)~ THEN GOTO PINE_2
		IF ~RandomNum(8,3)~ THEN GOTO PINE_3
		IF ~RandomNum(8,4)~ THEN GOTO PINE_4
		IF ~RandomNum(8,5)~ THEN GOTO PINE_5
		IF ~RandomNum(8,6)~ THEN GOTO PINE_6
		IF ~RandomNum(8,7)~ THEN GOTO PINE_7
		IF ~RandomNum(8,8)~ THEN GOTO PINE_8
	END
	
	IF ~~ BEGIN PINE_2
		SAY @2401 // ~I wonder what Imoen is doing.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END
	
	IF ~~ BEGIN PINE_3
		SAY @2403 // ~Do you think Imoen thinks of me?~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_4
		SAY @2408 // ~I hope Immy is ok all alone.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END
	
	IF ~~ BEGIN PINE_5
		SAY @2410 // ~I miss my Immy.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_6
		SAY @2412 // ~Immy has this funny little way she...uh...never mind.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_7
		SAY @2414 // ~I don't suppose we could visit Imoen any time soon?~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF ~~ BEGIN PINE_8
		SAY @2416 // ~I think Imoen would make a great addition to the group.  We should go get her.~
		IF ~~ THEN DO ~SetGlobal("#L_GIPine","GLOBAL",0) SetGlobal("#L_GIPineTimer","GLOBAL",0)~ EXIT
	END

	IF WEIGHT #-98 ~Global("#L_GISpot","MYAREA",1)~ BEGIN NICE_SPOT
		SAY @2500 // ~Oh Immy, isn't this a lovely spot.~
		IF ~~ THEN DO ~SetGlobal("#L_GISpot","MYAREA",2)~ EXTERN %IMOEN_JOINED% NICE_SPOT
	END	
END
