 #!/bin/bash
 echo starting c
 if [ -e ./c.sh ]
 then
            .c.sh
 else
            echo"---file c.sh does not exist in current directory---"
            echo"current files in directory:"
            ls
            echo " "
fi
ps
sleep 5
~
