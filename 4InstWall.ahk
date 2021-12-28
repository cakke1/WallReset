#Persistent
#NoEnv
#SingleInstance Force

; US - 1
; Ca - 2
; UK - 3
; Au - 4

global instances = 3
global render_distance = 16
global render_dist = 14
global Sounds = false

SetKeyDelay, 15
SetWinDelay, 55
SetTitleMatchMode, 2

global target_inst = 0
global current_instance = 1

global total_resets = 5900

global resetspath = "C:\Users\kiril\Desktop\__\MC\ahks\_WallReset\resets.txt"

FileRead, total_resets, %resetspath%

CreateWorld()
{
   send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
}

ExitWorld()
{       
	send {Esc}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter} 
    total_reset += 1
}

Sound()
{  
   if (Sounds){
      SoundPlay, reset.wav
   }
}

SwitchScene()
{
    Send {LCtrl Down}
    Send %current_instance%
    Send {LCtrl Up}
}

Projector()
{   
   WinActivate, Fullscreen Projector
   WinWait, Fullscreen Projector
}

GetTargetInst() ; get number of the targeted instance
{
   MouseGetPos, mx, my
   
   if (mx < 960) && (my < 540){
       target_inst = 1
   }
   
   else if (mx >= 960) && (my < 540){
       target_inst = 2
   }
   
   else if (mx < 960) && (my >= 540){
       target_inst = 3
   }
}


PlayTargeted() ; play the instance chosen with the cursor
{     
   Projector()
   KeyWait, Y, D
   GetTargetInst()
   WinActivate, Instance %target_inst%
   WinWait, Instance %target_inst%
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
   ControlSend, ahk_parent, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}, Instance %target_inst%  
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
        PlayTargeted()
    return
    
    RAlt::
        MsgBox, %total_resets%
    return
    
    ^LAlt::
        Reload
    return
}