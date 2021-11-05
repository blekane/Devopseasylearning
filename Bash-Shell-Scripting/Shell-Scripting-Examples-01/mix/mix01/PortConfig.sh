#!/bin/bash





#De




usage()
{ 

echo -e "\nThis script takes 2 arguments ( port number and protocol)\n"
echo   "    EXAMPLE: $0 80 tcp  "
exit 1
}


##Check number of Arguments provided


    [[ $# -ne 2 ]] && usage 



##Check if the protocol provided is tcp or udp


  [[ $2 != tcp ]] && [[ $2 != udp ]] && echo -e "\nPlease provide a valid protocol(udp/tcp)\n" ; exit 99



## Check if the port entered was a digit


  
