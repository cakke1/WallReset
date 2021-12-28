#Persistent
#NoEnv
#SingleInstance Force

global instances = 6
global render_distance = 16
global render_dist = 14
global Sounds = false

SetKeyDelay, 20
SetWinDelay, 100

global target_inst = 0
global current_instance = 1

global total_resets = 6104

global resetspath = "C:\Users\kiril\Desktop\__\MC\ahks\_WallReset\resets.txt"

FileRead, total_resets, %resetspath%

CreateWorld()
{
   send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
}

ExitWorld()
{   
	send {Esc}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter} 
    total_resets += 1 
}

Sound()
{  
   if (Sounds){
      SoundPlay, reset.wav
   }
}

SwitchScene()
{

}

Projector()
{   
   WinActivate, Fullscreen Projector
   WinWait, Fullscreen Projector
}

GetTargetInst() ; get number of the targeted instance
{
   MouseGetPos, mx, my
   
   if (mx < 640) && (my < 540){
       target_inst = 1
   }
   
   else if (mx >= 640) && (mx < 1280) && (my < 540){
       target_inst = 2
   }
   
   else if (mx >= 960) && (my < 540){
       target_inst = 3
   }
   
   else if (mx < 640) && (my >= 540){
       target_inst = 4
   }
   
   else if (mx >= 640) && (mx < 1280) && (my >= 540){
       target_inst = 5
   }
   
   else if (mx >= 960) && (my >= 540){
       target_inst = 6
   }
}


PlayTargeted() ; play the instance chosen with the cursor
{     
   Projector()
   KeyWait, Y, D
   GetTargetInst()
   WinActivate, Minecraft %target_inst%
   Sound()
   current_instance = target_inst
   total_resets += 1
   FileDelete, %resetspath%
   FileAppend, %total_resets%, %resetspath%
}

ResetTargeted() ; reset the instance chosen with the cursor
{   
   Projector()
   KeyWait, U, D
   GetTargetInst()
   current_instance = target_inst
   ControlSend, ahk_parent, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}, Minecraft %target_inst%  
   Sound()
   total_resets += 1
   FileDelete, %resetspath%
   FileAppend, %total_resets%, %resetspath%
}

{  
    H::
      Projector()
    return

    Y::
        PlayTargeted()
    return
    
    U::
        ResetTargeted()
    return
    
    J::
        ExitWorld()
        Projector()
    
    ^+LAlt::
        MsgBox, %total_resets%
    
    ^LAlt::
        Reload
    return
}