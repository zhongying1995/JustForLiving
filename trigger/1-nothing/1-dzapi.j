//TESH.scrollpos=9
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
   
endlibrary