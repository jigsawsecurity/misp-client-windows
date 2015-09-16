external string
#DEFINE FUNCTION,STRING


TITLE "JIGSAW HIDS CLIENT"
  DIALOG CREATE,Settings Check,-1,0,1,1,NOTITLE
REM *** Modified by Dialog Designer on 8/22/2015 - 00:13 ***
  DIALOG SHOW

  
inifile open,@path(%0)settings\settings.ini
%%key = @iniread(settings,key)
if @null(%%key)
%%key = @input(Please Paste your API Key)
inifile write,settings,key,"Authorization: "%%key
inifile close
end

inifile open,@path(%0)settings\settings.ini
%%mispserverurl = @iniread(settings,mispserverurl)
if @null(%%mispserverurl)
%%mispserverurl = @input(Enter your MISP Server URL)
%%mispserverurl = @string(GetBefore,%%mispserverurl,"/",last,)
inifile write,settings,mispserverurl,%%mispserverurl
inifile close
end


