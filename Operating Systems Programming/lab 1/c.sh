 #!/bin/bash
 echo starting d
 if [ -e./d.sh ]
 then
            ./d.sh
 else
            echo"---file c.sh does not exist in current directory---"
            echo"current files in directory:"
            ls
            echo " "
fi
ps
sleep 5
~
