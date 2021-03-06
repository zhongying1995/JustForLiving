globals
//globals from Base:
constant boolean LIBRARY_Base=true
//endglobals from Base
//globals from DZAPI:
constant boolean LIBRARY_DZAPI=true
//endglobals from DZAPI
//globals from DzAPI:
constant boolean LIBRARY_DzAPI=true
//endglobals from DzAPI
    // Generated
rect gg_rct_BirthPoint_1= null
rect gg_rct_BirthPoint_2= null
rect gg_rct_BirthPoint_3= null
rect gg_rct_BirthPoint_4= null
rect gg_rct_BirthPoint_5= null
rect gg_rct_Battlefield= null
rect gg_rct_Sea_0= null
rect gg_rct_Sea_1= null
rect gg_rct_Sea_2= null
rect gg_rct_Sea_3= null
rect gg_rct_Sea_4= null
rect gg_rct_Sea_5= null
rect gg_rct_Sea_6= null
rect gg_rct_Sea_7= null
rect gg_rct_Sea_8= null
rect gg_rct_Sea_9= null
rect gg_rct_Sea_10= null
rect gg_rct_Sea_11= null
rect gg_rct_Sea_12= null
rect gg_rct_Sea_13= null
rect gg_rct_Sea_14= null
rect gg_rct_Sea_15= null
rect gg_rct_Sea_16= null
rect gg_rct_Sea_17= null
rect gg_rct_Sea_18= null
rect gg_rct_Sea_19= null
rect gg_rct_Sea_20= null
rect gg_rct_Sea_21= null
rect gg_rct_Sea_22= null
rect gg_rct_Sea_23= null
rect gg_rct_Sea_24= null
rect gg_rct_Sea_25= null
rect gg_rct_Sea_26= null
rect gg_rct_Sea_27= null
rect gg_rct_Sea_28= null
rect gg_rct_Sea_29= null
rect gg_rct_Sea_30= null
rect gg_rct_Sea_31= null
rect gg_rct_Sea_32= null
rect gg_rct_Sea_33= null
rect gg_rct_Sea_34= null
rect gg_rct_Sea_35= null
rect gg_rct_Sea_36= null
rect gg_rct_Sea_37= null
rect gg_rct_Sea_38= null
rect gg_rct_Sea_39= null
rect gg_rct_Sea_40= null
rect gg_rct_Sea_41= null
rect gg_rct_Sea_42= null
rect gg_rct_Sea_43= null
rect gg_rct_Sea_44= null
rect gg_rct_Sea_45= null
rect gg_rct_BossScorpion= null
rect gg_rct_BossTortoise= null
rect gg_rct_BossAbyss_0= null
rect gg_rct_BossAbyss_1= null
rect gg_rct_RewardGold= null
rect gg_rct_DefaultFog= null
rect gg_rct_ChooseHero= null
rect gg_rct_BirthPoint_6= null
rect gg_rct_BirthPoint_7= null
rect gg_rct_Creep_frog_01= null
rect gg_rct_Creep_frog_02= null
rect gg_rct_Creep_frog_03= null
rect gg_rct_Creep_frog_04= null
rect gg_rct_God_tree= null
rect gg_rct_Field_1= null
rect gg_rct_Field_2= null
rect gg_rct_Field_3= null
rect gg_rct_Field_4= null
rect gg_rct_Field_5= null
rect gg_rct_Field_6= null
rect gg_rct_Field_7= null
rect gg_rct_Field_8= null
rect gg_rct_Garden_1= null
rect gg_rct_Garden_2= null
rect gg_rct_Garden_3= null
rect gg_rct_Garden_4= null
rect gg_rct_Garden_5= null
rect gg_rct_Garden_6= null
rect gg_rct_Farm= null
rect gg_rct_Mountain_god= null
rect gg_rct_Dragon_1= null
rect gg_rct_Dragon_2= null
rect gg_rct_Dragon_3= null
rect gg_rct_Dragon_4= null
rect gg_rct_Dragon_5= null
trigger gg_trg_dzapi= null
hashtable Interactive= InitHashtable()

trigger l__library_init

//JASSHelper struct globals:

endglobals
	native DzAPI_Map_SaveServerValue takes player whichPlayer, string key, string value returns boolean
    native DzAPI_Map_GetServerValue takes player whichPlayer, string key returns string
    native DzAPI_Map_Ladder_SetStat takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_IsRPGLadder takes nothing returns boolean
    native DzAPI_Map_GetGameStartTime takes nothing returns integer
    native DzAPI_Map_Stat_SetStat takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_GetMatchType takes nothing returns integer
    native DzAPI_Map_Ladder_SetPlayerStat takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetServerValueErrorCode takes player whichPlayer returns integer
    native DzAPI_Map_GetLadderLevel takes player whichPlayer returns integer
	native DzAPI_Map_IsRedVIP takes player whichPlayer returns boolean
	native DzAPI_Map_IsBlueVIP takes player whichPlayer returns boolean
	native DzAPI_Map_GetLadderRank takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevelRank takes player whichPlayer returns integer
	native DzAPI_Map_GetGuildName takes player whichPlayer returns string
	native DzAPI_Map_GetGuildRole takes player whichPlayer returns integer
	native DzAPI_Map_IsRPGLobby takes nothing returns boolean
	native DzAPI_Map_GetMapLevel takes player whichPlayer returns integer
	native DzAPI_Map_MissionComplete takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetActivityData takes nothing returns string
	native DzAPI_Map_GetMapConfig takes string key returns string
	native DzAPI_Map_HasMallItem takes player whichPlayer, string key returns boolean


//library Base:
    
    function Base___Init takes nothing returns nothing
        call Cheat("exec-lua:lua.base")
    endfunction
    

//library Base ends
//library DZAPI:
    function dz_set_server_value takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local string key= LoadStr(Interactive, 0, 2)
        local string val= LoadStr(Interactive, 0, 3)
        local boolean b= DzAPI_Map_SaveServerValue(p, key, val)
        call FlushChildHashtable(Interactive, 0)
        call SaveBoolean(Interactive, 0, 0, b)
        set p=null
    endfunction
    
    function dz_get_server_value takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local string key= LoadStr(Interactive, 0, 2)
        local string s= DzAPI_Map_GetServerValue(p, key)
        call FlushChildHashtable(Interactive, 0)
        call SaveStr(Interactive, 0, 0, s)
        set p=null
    endfunction
    
    function dz_is_rpg_robby takes nothing returns nothing
        local boolean b= DzAPI_Map_IsRPGLobby()
        call SaveBoolean(Interactive, 0, 0, b)
    endfunction
    
    function dz_get_game_time takes nothing returns nothing
        local integer i= DzAPI_Map_GetGameStartTime()
        call SaveInteger(Interactive, 0, 0, i)
    endfunction
    
    function dz_get_map_level_rank takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local integer i= DzAPI_Map_GetMapLevelRank(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p=null
    endfunction
    
    function dz_get_map_level takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local integer i= DzAPI_Map_GetMapLevel(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p=null
    endfunction
    
    function dz_get_server_value_error_code takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local integer i= DzAPI_Map_GetServerValueErrorCode(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p=null
    endfunction
    
    function get_guild_name takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local string name= DzAPI_Map_GetGuildName(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveStr(Interactive, 0, 0, name)
        set p=null
    endfunction
    
    function get_guild_role takes nothing returns nothing
        local player p= LoadPlayerHandle(Interactive, 0, 1)
        local integer i= DzAPI_Map_GetGuildRole(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p=null
    endfunction
    
   

//library DZAPI ends
//library DzAPI:






















 function GetPlayerServerValueSuccess takes player whichPlayer returns boolean
		if ( DzAPI_Map_GetServerValueErrorCode(whichPlayer) == 0 ) then
			return true
		else
			return false
		endif
	endfunction
  function DzAPI_Map_StoreInteger takes player whichPlayer,string key,integer value returns nothing
        set key="I" + key
        call DzAPI_Map_SaveServerValue(whichPlayer, key, I2S(value))
        set key=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_GetStoredInteger takes player whichPlayer,string key returns integer
        local integer value
        set key="I" + key
        set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
        set key=null
        set whichPlayer=null
        return value
    endfunction
    function DzAPI_Map_StoreReal takes player whichPlayer,string key,real value returns nothing
        set key="R" + key
        call DzAPI_Map_SaveServerValue(whichPlayer, key, R2S(value))
        set key=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_GetStoredReal takes player whichPlayer,string key returns real
        local real value
        set key="R" + key
        set value=S2R(DzAPI_Map_GetServerValue(whichPlayer, key))
        set key=null
        set whichPlayer=null
        return value
    endfunction
    function DzAPI_Map_StoreBoolean takes player whichPlayer,string key,boolean value returns nothing
        set key="B" + key
        if ( value ) then
            call DzAPI_Map_SaveServerValue(whichPlayer, key, "1")
        else
            call DzAPI_Map_SaveServerValue(whichPlayer, key, "0")
        endif
        set key=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_GetStoredBoolean takes player whichPlayer,string key returns boolean
        local boolean value
        set key="B" + key
        set key=DzAPI_Map_GetServerValue(whichPlayer, key)
        if ( key == "1" ) then
            set value=true
        else
            set value=false
        endif
        set key=null
        set whichPlayer=null
        return value
    endfunction
    function DzAPI_Map_StoreString takes player whichPlayer,string key,string value returns nothing
        set key="S" + key
        call DzAPI_Map_SaveServerValue(whichPlayer, key, value)
        set key=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_GetStoredString takes player whichPlayer,string key returns string
        return DzAPI_Map_GetServerValue(whichPlayer, "S" + key)
    endfunction
 function DzAPI_Map_GetStoredUnitType takes player whichPlayer,string key returns integer
        local integer value
        set key="I" + key
        set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
        set key=null
        set whichPlayer=null
        return value
    endfunction
 function DzAPI_Map_GetStoredAbilityId takes player whichPlayer,string key returns integer
        local integer value
        set key="I" + key
        set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
        set key=null
        set whichPlayer=null
        return value
    endfunction
    function DzAPI_Map_FlushStoredMission takes player whichPlayer,string key returns nothing
        call DzAPI_Map_SaveServerValue(whichPlayer, key, null)
        set key=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_Ladder_SubmitIntegerData takes player whichPlayer,string key,integer value returns nothing
        call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
    endfunction
    function DzAPI_Map_Stat_SubmitUnitIdData takes player whichPlayer,string key,integer value returns nothing
        if ( value == 0 ) then
            //call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
        else
            call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
        endif
    endfunction
    function DzAPI_Map_Stat_SubmitUnitData takes player whichPlayer,string key,unit value returns nothing
        call DzAPI_Map_Stat_SubmitUnitIdData(whichPlayer , key , GetUnitTypeId(value))
    endfunction
    function DzAPI_Map_Ladder_SubmitAblityIdData takes player whichPlayer,string key,integer value returns nothing
        if ( value == 0 ) then
            //call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
        else
            call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
        endif
    endfunction
    function DzAPI_Map_Ladder_SubmitItemIdData takes player whichPlayer,string key,integer value returns nothing
        local string S
        if ( value == 0 ) then
            set S="0"
        else
            set S=I2S(value)
            call DzAPI_Map_Ladder_SetStat(whichPlayer, key, S)
        endif
        //call DzAPI_Map_Ladder_SetStat(whichPlayer,key,S)
        set S=null
        set whichPlayer=null
    endfunction
    function DzAPI_Map_Ladder_SubmitItemData takes player whichPlayer,string key,item value returns nothing
        call DzAPI_Map_Ladder_SubmitItemIdData(whichPlayer , key , GetItemTypeId(value))
    endfunction
    function DzAPI_Map_Ladder_SubmitBooleanData takes player whichPlayer,string key,boolean value returns nothing
        if ( value ) then
            call DzAPI_Map_Ladder_SetStat(whichPlayer, key, "1")
        else
            call DzAPI_Map_Ladder_SetStat(whichPlayer, key, "0")
        endif
    endfunction
    function DzAPI_Map_Ladder_SubmitTitle takes player whichPlayer,string value returns nothing
        call DzAPI_Map_Ladder_SetStat(whichPlayer, value, "1")
    endfunction
 function DzAPI_Map_Ladder_SubmitPlayerRank takes player whichPlayer,integer value returns nothing
        call DzAPI_Map_Ladder_SetPlayerStat(whichPlayer, "RankIndex", I2S(value))
    endfunction
 function DzAPI_Map_Ladder_SubmitPlayerExtraExp takes player whichPlayer,integer value returns nothing
        call DzAPI_Map_Ladder_SetStat(whichPlayer, "ExtraExp", I2S(value))
	endfunction

//library DzAPI ends
//===========================================================================
// 
// 活下去
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Thu Dec 13 23:03:08 2018
//   Map Author: 未知
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
endfunction
//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************
//===========================================================================
function CreateUnitsForPlayer10 takes nothing returns nothing
    local player p= Player(10)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'h404', - 4979.1, 786.4, 297.947)
    set u=CreateUnit(p, 'h404', - 4662.6, 843.7, 286.170)
    set u=CreateUnit(p, 'h404', - 4626.3, 1385.9, 108.526)
    set u=CreateUnit(p, 'h404', - 4211.7, 1129.2, 53.571)
    set u=CreateUnit(p, 'h404', - 4565.8, 539.1, 228.358)
    set u=CreateUnit(p, 'h405', - 5042.7, 1132.5, 330.830)
    set u=CreateUnit(p, 'h406', - 4175.4, 3253.1, 329.856)
    set u=CreateUnit(p, 'h406', - 3618.2, 3763.0, 300.903)
    set u=CreateUnit(p, 'h406', - 3629.2, 4508.7, 260.180)
    set u=CreateUnit(p, 'h406', - 4295.8, 4148.8, 271.744)
    set u=CreateUnit(p, 'h406', - 4640.2, 3507.9, 35.371)
    set u=CreateUnit(p, 'h406', - 5237.1, 4015.5, 323.102)
    set u=CreateUnit(p, 'h406', - 4672.8, 4929.2, 300.387)
    set u=CreateUnit(p, 'h407', - 4909.4, 4488.1, 309.852)
    set u=CreateUnit(p, 'h40F', - 712.8, 4953.0, 268.789)
    set u=CreateUnit(p, 'h40E', - 1099.7, 4535.0, 5.823)
    set u=CreateUnit(p, 'h40E', - 354.3, 4586.6, 235.071)
    set u=CreateUnit(p, 'h40E', - 670.0, 4193.6, 255.198)
    set u=CreateUnit(p, 'h40E', - 1071.3, 3700.2, 100.880)
    set u=CreateUnit(p, 'h40E', - 292.2, 3696.8, 32.444)
    set u=CreateUnit(p, 'h409', 4715.1, 4420.1, 233.732)
    set u=CreateUnit(p, 'h408', 3260.4, 4004.4, 29.148)
    set u=CreateUnit(p, 'h408', 3586.3, 3708.8, 132.895)
    set u=CreateUnit(p, 'h408', 4144.5, 3239.1, 45.012)
    set u=CreateUnit(p, 'h408', 4496.9, 2809.9, 130.708)
    set u=CreateUnit(p, 'h408', 3893.9, 4432.2, 345.553)
    set u=CreateUnit(p, 'h408', 4227.7, 4128.8, 250.298)
    set u=CreateUnit(p, 'h408', 4614.7, 3753.7, 173.721)
    set u=CreateUnit(p, 'h402', 4621.7, - 1834.0, 202.550)
    set u=CreateUnit(p, 'h402', 4724.1, - 2145.6, 217.035)
    set u=CreateUnit(p, 'h402', 4900.9, - 2479.0, 201.644)
    set u=CreateUnit(p, 'h403', 5154.6, - 1988.4, 217.236)
    set u=CreateUnit(p, 'h40B', - 1805.9, - 5081.0, 193.882)
    set u=CreateUnit(p, 'h40A', - 2184.7, - 4714.3, 81.027)
    set u=CreateUnit(p, 'h40A', - 2182.0, - 5466.5, 65.920)
    set u=CreateUnit(p, 'h40A', - 2421.0, - 5125.8, 299.914)
    set u=CreateUnit(p, 'h40A', - 2754.2, - 4769.0, 357.473)
    set u=CreateUnit(p, 'h40A', - 2781.3, - 5452.4, 320.272)
    set u=CreateUnit(p, 'h40A', - 3206.8, - 4826.0, 18.216)
    set u=CreateUnit(p, 'h40A', - 3257.0, - 5404.5, 170.315)
    set u=CreateUnit(p, 'h40A', - 3761.5, - 5099.5, 191.871)
    set u=CreateUnit(p, 'h40D', 30.9, - 5151.6, 343.330)
    set u=CreateUnit(p, 'h40C', 433.7, - 4802.4, 123.578)
    set u=CreateUnit(p, 'h40C', 386.6, - 5453.8, 197.167)
    set u=CreateUnit(p, 'h40C', 731.2, - 5104.7, 180.895)
    set u=CreateUnit(p, 'h40C', 1087.8, - 4793.7, 78.390)
    set u=CreateUnit(p, 'h40C', 1037.6, - 5454.3, 221.129)
    set u=CreateUnit(p, 'h40C', 1558.6, - 4805.7, 204.385)
    set u=CreateUnit(p, 'h40C', 1489.2, - 5489.6, 160.966)
    set u=CreateUnit(p, 'h40C', 1825.3, - 5073.9, 146.683)
    set u=CreateUnit(p, 'h404', - 4518.1, 1084.2, 53.571)
endfunction
//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'h201', 64.0, 1088.0, 270.000)
    set u=CreateUnit(p, 'h202', 320.0, 1088.0, 270.000)
    set u=CreateUnit(p, 'h200', 576.0, 1088.0, 270.000)
    set u=CreateUnit(p, 'h203', 832.0, 1088.0, 270.000)
    set u=CreateUnit(p, 'h204', 64.0, - 640.0, 270.000)
    set u=CreateUnit(p, 'h205', 320.0, - 640.0, 270.000)
    set u=CreateUnit(p, 'h206', 896.0, - 640.0, 270.000)
endfunction
//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction
//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer10()
endfunction
//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateUnitsForPlayer10() // INLINED!!
endfunction
//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************
function CreateRegions takes nothing returns nothing
    local weathereffect we
    set gg_rct_BirthPoint_1=Rect(0.0, - 2560.0, 704.0, - 1856.0)
    set gg_rct_BirthPoint_2=Rect(2112.0, - 64.0, 2816.0, 640.0)
    set gg_rct_BirthPoint_3=Rect(- 2144.0, 1440.0, - 1440.0, 2144.0)
    set gg_rct_BirthPoint_4=Rect(- 3232.0, - 1344.0, - 2528.0, - 640.0)
    set gg_rct_BirthPoint_5=Rect(- 1344.0, - 96.0, - 640.0, 608.0)
    set gg_rct_Battlefield=Rect(- 3488.0, - 3840.0, 3488.0, 2944.0)
    set gg_rct_Sea_0=Rect(- 3008.0, 2112.0, 2304.0, 5376.0)
    set gg_rct_Sea_1=Rect(2688.0, - 2752.0, 5632.0, 1920.0)
    set gg_rct_Sea_2=Rect(4896.0, - 3872.0, 5632.0, - 2656.0)
    set gg_rct_Sea_3=Rect(3136.0, - 4064.0, 4000.0, - 2720.0)
    set gg_rct_Sea_4=Rect(3936.0, - 3264.0, 5024.0, - 2688.0)
    set gg_rct_Sea_5=Rect(1856.0, - 896.0, 2720.0, 1440.0)
    set gg_rct_Sea_6=Rect(1536.0, - 768.0, 1984.0, 1120.0)
    set gg_rct_Sea_7=Rect(- 160.0, - 896.0, 1056.0, 1440.0)
    set gg_rct_Sea_8=Rect(992.0, - 32.0, 1632.0, 544.0)
    set gg_rct_Sea_9=Rect(- 704.0, 32.0, - 64.0, 608.0)
    set gg_rct_Sea_10=Rect(- 1312.0, - 800.0, - 672.0, 1312.0)
    set gg_rct_Sea_11=Rect(- 2176.0, - 2304.0, - 1344.0, - 160.0)
    set gg_rct_Sea_12=Rect(- 1696.0, - 928.0, - 864.0, 1440.0)
    set gg_rct_Sea_13=Rect(- 2240.0, 384.0, - 1376.0, 2464.0)
    set gg_rct_Sea_14=Rect(- 1472.0, 1920.0, - 608.0, 2272.0)
    set gg_rct_Sea_15=Rect(- 160.0, 1888.0, 1056.0, 2272.0)
    set gg_rct_Sea_16=Rect(1472.0, 1920.0, 4128.0, 2240.0)
    set gg_rct_Sea_17=Rect(2208.0, 2208.0, 3680.0, 2624.0)
    set gg_rct_Sea_18=Rect(2112.0, 2592.0, 3136.0, 3072.0)
    set gg_rct_Sea_19=Rect(2080.0, 3008.0, 2976.0, 3296.0)
    set gg_rct_Sea_20=Rect(2176.0, 3296.0, 2720.0, 3584.0)
    set gg_rct_Sea_21=Rect(2496.0, - 2816.0, 2848.0, - 800.0)
    set gg_rct_Sea_22=Rect(1696.0, - 1728.0, 2816.0, - 1376.0)
    set gg_rct_Sea_23=Rect(1536.0, - 2816.0, 2080.0, - 1568.0)
    set gg_rct_Sea_24=Rect(- 160.0, - 2720.0, 1024.0, - 1504.0)
    set gg_rct_Sea_25=Rect(992.0, - 2816.0, 1600.0, - 2176.0)
    set gg_rct_Sea_26=Rect(- 1376.0, - 2304.0, 32.0, - 2016.0)
    set gg_rct_Sea_27=Rect(- 576.0, - 2816.0, 512.0, - 2176.0)
    set gg_rct_Sea_28=Rect(- 1408.0, - 2048.0, - 1152.0, - 1376.0)
    set gg_rct_Sea_29=Rect(- 2208.0, - 3392.0, - 1856.0, - 2784.0)
    set gg_rct_Sea_30=Rect(96.0, - 4064.0, 3200.0, - 3296.0)
    set gg_rct_Sea_31=Rect(- 1344.0, - 3904.0, 256.0, - 3424.0)
    set gg_rct_Sea_32=Rect(2336.0, - 6048.0, 3072.0, - 4032.0)
    set gg_rct_Sea_33=Rect(- 416.0, - 4160.0, 128.0, - 3872.0)
    set gg_rct_Sea_34=Rect(- 3552.0, - 4096.0, - 1152.0, - 3712.0)
    set gg_rct_Sea_35=Rect(- 3552.0, - 3744.0, - 1920.0, - 3424.0)
    set gg_rct_Sea_36=Rect(- 3936.0, - 1600.0, - 2112.0, - 512.0)
    set gg_rct_Sea_37=Rect(- 5664.0, 1920.0, - 3456.0, 2816.0)
    set gg_rct_Sea_38=Rect(- 5664.0, - 1184.0, - 3392.0, 128.0)
    set gg_rct_Sea_39=Rect(- 3680.0, - 672.0, - 3072.0, 2752.0)
    set gg_rct_Sea_40=Rect(- 3296.0, 1280.0, - 2656.0, 2816.0)
    set gg_rct_Sea_41=Rect(- 3296.0, 416.0, - 2752.0, 1344.0)
    set gg_rct_Sea_42=Rect(- 4000.0, - 4096.0, - 2752.0, - 1504.0)
    set gg_rct_Sea_43=Rect(- 5664.0, - 4128.0, - 3872.0, - 2848.0)
    set gg_rct_Sea_44=Rect(- 5696.0, - 5856.0, - 4384.0, - 4032.0)
    set gg_rct_Sea_45=Rect(- 5664.0, - 2560.0, - 4192.0, - 1376.0)
    set gg_rct_BossScorpion=Rect(- 5248.0, 768.0, - 4992.0, 992.0)
    set gg_rct_BossTortoise=Rect(4992.0, - 2144.0, 5248.0, - 1920.0)
    set gg_rct_BossAbyss_0=Rect(4448.0, 4320.0, 4672.0, 4576.0)
    set gg_rct_BossAbyss_1=Rect(4768.0, 4064.0, 4992.0, 4320.0)
    set gg_rct_RewardGold=Rect(5184.0, - 320.0, 5504.0, 96.0)
    set gg_rct_DefaultFog=Rect(- 1824.0, - 2336.0, 3168.0, 2688.0)
    set gg_rct_ChooseHero=Rect(3488.0, - 864.0, 5632.0, 800.0)
    set gg_rct_BirthPoint_6=Rect(- 4768.0, - 1024.0, - 4064.0, - 320.0)
    set gg_rct_BirthPoint_7=Rect(2720.0, 2304.0, 3424.0, 3008.0)
    set gg_rct_Creep_frog_01=Rect(3872.0, - 736.0, 5536.0, 608.0)
    set gg_rct_Creep_frog_02=Rect(2752.0, 1152.0, 5344.0, 1888.0)
    set gg_rct_Creep_frog_03=Rect(2080.0, - 1088.0, 3296.0, 1120.0)
    set gg_rct_Creep_frog_04=Rect(2624.0, - 3520.0, 4096.0, - 1056.0)
    set gg_rct_God_tree=Rect(8192.0, - 512.0, 8704.0, 0.0)
    set gg_rct_Field_1=Rect(6816.0, 0.0, 8192.0, 1312.0)
    set gg_rct_Field_2=Rect(8704.0, 0.0, 9952.0, 1312.0)
    set gg_rct_Field_3=Rect(6816.0, - 1824.0, 8192.0, - 512.0)
    set gg_rct_Field_4=Rect(8704.0, - 1824.0, 9952.0, - 512.0)
    set gg_rct_Field_5=Rect(6784.0, - 5760.0, 7520.0, - 4096.0)
    set gg_rct_Field_6=Rect(9376.0, - 5760.0, 9952.0, - 4096.0)
    set gg_rct_Field_7=Rect(9344.0, 3680.0, 9952.0, 5280.0)
    set gg_rct_Field_8=Rect(6816.0, 3712.0, 7552.0, 5312.0)
    set gg_rct_Garden_1=Rect(7776.0, 3968.0, 9120.0, 5344.0)
    set gg_rct_Garden_2=Rect(6784.0, 1600.0, 7968.0, 2976.0)
    set gg_rct_Garden_3=Rect(8768.0, 1600.0, 9952.0, 2976.0)
    set gg_rct_Garden_4=Rect(6816.0, - 3520.0, 8000.0, - 2144.0)
    set gg_rct_Garden_5=Rect(8768.0, - 3520.0, 9952.0, - 2144.0)
    set gg_rct_Garden_6=Rect(7776.0, - 5888.0, 9120.0, - 4448.0)
    set gg_rct_Farm=Rect(6592.0, - 6016.0, 10016.0, 5632.0)
    set gg_rct_Mountain_god=Rect(- 5664.0, - 2528.0, - 4512.0, - 1440.0)
    set gg_rct_Dragon_1=Rect(3488.0, - 5984.0, 5664.0, - 4256.0)
    set gg_rct_Dragon_2=Rect(4096.0, - 4288.0, 4896.0, - 3360.0)
    set gg_rct_Dragon_3=Rect(3648.0, - 5440.0, 4000.0, - 5088.0)
    set gg_rct_Dragon_4=Rect(4384.0, - 5760.0, 4736.0, - 5408.0)
    set gg_rct_Dragon_5=Rect(5120.0, - 5440.0, 5472.0, - 5088.0)
endfunction
//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//TESH.scrollpos=0
//TESH.alwaysfold=0
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: dzapi
//===========================================================================
//TESH.scrollpos=17
//TESH.alwaysfold=0
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_dzapi()
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)
    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)
    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call ForcePlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)
    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call ForcePlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)
    // Player 6
    call SetPlayerStartLocation(Player(6), 6)
    call ForcePlayerStartLocation(Player(6), 6)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_COMPUTER)
    // Player 10
    call SetPlayerStartLocation(Player(10), 7)
    call ForcePlayerStartLocation(Player(10), 7)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
    // Player 11
    call SetPlayerStartLocation(Player(11), 8)
    call ForcePlayerStartLocation(Player(11), 8)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_010
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerTeam(Player(6), 0)
    call SetPlayerTeam(Player(10), 0)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(6), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(6), true)
    // Force: TRIGSTR_011
    call SetPlayerTeam(Player(11), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 5)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(1, 5)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(2, 5)
    call SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(3, 5)
    call SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(4, 5)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(5, 5)
    call SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(6, 6)
    call SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(7, 7)
    call SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 6, 6, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 5632.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 5888.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 9984.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 5376.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 5632.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 5376.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 9984.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 5888.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateRegions()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("Base___Init")

    call InitGlobals()
    call InitCustomTriggers()
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("活下去")
    call SetMapDescription("听说你想单通？不存在的")
    call SetPlayers(9)
    call SetTeams(9)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 256.0, 256.0)
    call DefineStartLocation(1, 256.0, 256.0)
    call DefineStartLocation(2, 256.0, 256.0)
    call DefineStartLocation(3, 256.0, 256.0)
    call DefineStartLocation(4, 256.0, 256.0)
    call DefineStartLocation(5, 256.0, 256.0)
    call DefineStartLocation(6, 256.0, 256.0)
    call DefineStartLocation(7, 256.0, 256.0)
    call DefineStartLocation(8, 256.0, 256.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

