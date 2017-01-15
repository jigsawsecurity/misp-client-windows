# Jigsaw Security Enterprise MISP Open Source Client

![alt tag](https://ui.slcsecurity.com/img/custom/JSLOGO.png)

The MISP Client for Windows is tested on Windows 7/8 and can be installed on Windows 10 if you do it as the Administrator. However depending on your configuration you may need to install into another location than what is in the installer. We recommend pulling the source to do an install on Windows 10. <P></P>
This version will monitor network connections to IP addresses only and will also check filenames for known bad naming. The open source version does not check hashes or actively stop an attack. The client will notify you of connections if they occur so you can take action. <P></P><P></P>
A commercial version is available through Jigsaw Security Enterprise (www.jigsaw-security.com) for more information. 
<P></P>
<h3>Modules Included in the Open Source Build</h3>
<li>IP monitoring</li>
<li>File name monitoring</li>
<li>Running process checking</li>
<P></P>
Let me know if you have any issues. One note to users is that you MUST ensure that you put in a valid MISP API key and you have to put in the correct URL of the MISP server to be able to pull down the indicators.<P></P>
To verify that the client is pulling the ip and process information look at the ip-src, ip-dst and process file to make sure there is data in the file. 
