 #!/bin/bash
 if [ -e ./a.sh ]
 then
 			echo the contents of a.sh:
			cat ./a.sh
else

			echo "---file a.sh does not exist in current directory---"
			echo"current files in directory:"
			ls
			echo " "
fi
ps
echo All files in current directory:
pwd
ls -1
sleep 5
~
