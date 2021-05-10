 #!/bin/bash
 echo starting b
 if [ -e ./b.sh ]
 then
        .b.sh
 else
        echo"---file b.sh does not exist in current directory---"
        echo"current files in directory:"
        ls
        echo " "
fi
ps
sleep 5
~
