OK so requirements:
I built this to work on Windows 10, things might go screwy on other systems

1. you have matlab installed and on your system path (You can open a command prompt as administrator and run matlab by entering the command 'matlab' without quotes)
2. you have fireworx installed (and on matlab's path, i.e. you can run fireworx by typing 'fireworx' in matlab)


OK so in the directory that you found this readme there is a shortcut 
Drag_The_Directory_Onto_Me.bat - Shortcut

and a folder ScriptFile

So the way this works is you take a directory full of your data i.e.

SomeDir
	\-DES823B.000
	|-DES823B.001
	|-DES823B.002
	|-DES823B.003
	
And you processes it in fireworx by dragging the folder "SomeDir" onto the bat file "Drag_The_Directory_Onto_Me.bat"

This will run the script in the .bat file and give it the path to the directory "SomeDir" as an argument.  


This is what it does:

First is some code to ask for Admin permissions for the bat script (because otherwsie the script can't call matlab at the end (first 60 lines of the bat))

Then the bat script saves the path to "SomeDir" as a variable, then parses "SomeDir" to look for a file ending in the extension .000 and uses that to get the datafile name (in this case it's 'DES823B')

Then the bat file builds a default fireworx_config file using this directory and datafile name using the components in the ScriptProcessingFiles directory, (basically FilePart1+ directoryPath + filePartTwo + datafileName + filePart3

Once that is done, the bat file opens matlab and orders it to run the script doTheFireworx.m



doTheFireworx.m takes the created fireworx_config file, copies its contents to the fireworx_config file used by fireworx, then runs fireworx.  The resulting analysis
pro.mat
pro_sti_fit.txt
pro_str_fit.txt

are generated by fireworx and placed in "SomeDir"

contact mclayer@colostate.edu for any issues/problems/questions about this.
