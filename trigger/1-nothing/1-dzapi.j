//TESH.scrollpos=17
//TESH.alwaysfold=0
globals
    hashtable Interactive = InitHashtable()
endglobals

library DZAPI

    function dz_set_server_value takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local string key = LoadStr(Interactive, 0, 2)
        local string val = LoadStr(Interactive, 0, 3)
        local boolean b = DzAPI_Map_SaveServerValue(p, key, val)
        call FlushChildHashtable(Interactive, 0)
        call SaveBoolean(Interactive, 0, 0, b)
        set p = null
    endfunction
    
    function dz_get_server_value takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local string key = LoadStr(Interactive, 0, 2)
        local string s = DzAPI_Map_GetServerValue(p, key)
        call FlushChildHashtable(Interactive, 0)
        call SaveStr(Interactive, 0, 0, s)
        set p = null
    endfunction
    
    function dz_is_rpg_robby takes nothing returns nothing
        local boolean b = DzAPI_Map_IsRPGLobby()
        call SaveBoolean(Interactive, 0, 0, b)
    endfunction
    
    function dz_get_game_time takes nothing returns nothing
        local integer i = DzAPI_Map_GetGameStartTime()
        call SaveInteger(Interactive, 0, 0, i)
    endfunction
    
    function dz_get_map_level_rank takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local integer i = DzAPI_Map_GetMapLevelRank(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p = null
    endfunction
    
    function dz_get_map_level takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local integer i = DzAPI_Map_GetMapLevel(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p = null
    endfunction
    
    function dz_get_server_value_error_code takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local integer i = DzAPI_Map_GetServerValueErrorCode(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p = null
    endfunction
    
    function get_guild_name takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local string name = DzAPI_Map_GetGuildName(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveStr(Interactive, 0, 0, name)
        set p = null
    endfunction
    
    function get_guild_role takes nothing returns nothing
        local player p = LoadPlayerHandle(Interactive, 0, 1)
        local integer i = DzAPI_Map_GetGuildRole(p)
        call FlushChildHashtable(Interactive, 0)
        call SaveInteger(Interactive, 0, 0, i)
        set p = null
    endfunction
    
   
endlibrary