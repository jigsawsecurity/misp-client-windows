
  DIALOG CREATE,Jigsaw Security Enterprise HIDS,-1,0,574,180,NOTITLE
REM *** Modified by Dialog Designer on 8/26/2015 - 00:26 ***
  DIALOG ADD,BITMAP,BITMAP1,0,0,0,0,@path(%0)lib\logo.bmp,SLCHIDS
  DIALOG SHOW
  
  
  wait 6
  run @path(%0)checkset.exe,wait
  run @path(%0)smonitor.exe
  wait 1
  exit

 
