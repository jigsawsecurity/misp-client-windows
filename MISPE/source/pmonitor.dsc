EXTERNAL VDSIPP.DLL,APIKEY
#DEFINE COMMAND, INTERNET
#DEFINE FUNCTION, INTERNET

external string
#DEFINE FUNCTION,STRING

Title "Jigsaw Security HIDS Process Checking"

%%logfile = @path(%0)logs\@datetime(mm-dd-yyyy hhnnss)"-processmonitor.log"
list create,5
list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Starting Process Protection Module"

INIFILE OPEN,@path(%0)settings\settings.ini
%%version = @iniread(settings,version)
%%key = @iniread(settings,key)
%%hostname = @iniread(settings,hostname)
%%syslogserver = @iniread(settings,syslogserver)
%%mispserverurl = @iniread(settings,mispserverurl)
%%popupalert = @iniread(settings,popupalert)
INIFILE CLOSE

file delete,@path(%0)badfiles.txt

  %%url = %%mispserverurl"/attributes/text/download/filename"
  INTERNET HTTP,CREATE,1
  INTERNET HTTP,HEADER,1,%%key
  INTERNET HTTP,THREADS,1,OFF
  INTERNET HTTP,PROTOCOL,1,1
  INTERNET HTTP,USERAGENT,1,"Jigsaw Security HIDS Client File Protection Module"
  list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Downloading Filename Threats from "%%mispserverurl
  INTERNET HTTP,DOWNLOAD,1,%%url,@path(%0)badfiles.txt
  INTERNET HTTP,DESTROY,1

timer START,1,CTDOWN,00-00:00:15
  
  
:Evloop
  wait event
  goto @event()


  
:timer1ctdown
timer stop,1  
list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Checking for Malicious Files on Endpoint"
gosub writelogs
file delete,@path(%0)cache\files.txt
wait 3
runh cmd.exe /C dir /b C:\ /s >> @path(%0)cache\files.txt,wait
gosub checkfiles

timer START,1,CTDOWN,00-00:00:15
goto evloop

:writelogs
list savefile,5,%%logfile
exit

:checkfiles
INIFILE OPEN,@path(%0)settings\settings.ini
%%popupalert = @iniread(settings,popupalert)
INIFILE CLOSE
list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Checking Files for Threats"
list create,2
list loadfile,2,@path(%0)badfiles.txt
%%now = 0
%%total = @count(2)
REPEAT
%%ioc = @next(2)
%%iocx = @chr(92)%%ioc
if @string(FileOps, HoldsString,@path(%0)cache\files.txt,,%%iocx,,,)
#Exclude Files Here
if @equal(%%ioc,cmd.exe)
goto nothreat
end
if @equal(%%ioc,setup.exe)
goto nothreat
end
if @equal(%%ioc,desktop.ini)
goto nothreat
end
if @equal(%%ioc,updater.exe)
goto nothreat
end
#End of Excluded Filenames
list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Possible Threatening File Detected "%%ioc
list add,5,@datetime(dd-mmm-yyyy hh:nn:ss am/pm)": Consider submittimg to our sandbox for evaluation"
list savefile,5,%%logfile
end
:nothreat
%%now = @succ(%%now)
UNTIL @equal(%%now,%%total)
list close,2

list savefile,5,%%logfile
timer START,1,CTDOWN,0-00:00:15
exit

