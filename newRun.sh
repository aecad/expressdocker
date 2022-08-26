tag=qianyan

echo $ACTIVATION_CODE


echo "~> Run testing container..."
sudo docker run \
    --env=ACTIVATION_CODE=${ACTIVATION_CODE} \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    --privileged \
    --detach=true \
    --tty=true \
    --name=expressvpn-rc \
    -p 7890:7890     -p 7892:7892      -p 7891:7891     -p 9091:9090     -p 1053:1053 \
    -v /home/fish/apps/netw:/apps  \
    expressvpn:${tag} \
    /bin/bash
echo ""


echo "~> Wait expresspvn activation (20s)..."
for i in {1..20}
do
    sleep 1
    echo -n "$i "
done
echo ""

echo ""
echo "~> Check expressvpn status..."
status="$(sudo docker exec -it expressvpn-rc expressvpn status)"
if [[ "$status" == *"Connected to"* ]]
then
    echo "$status" | grep 'Connected to'
else
    echo "!! Set ACTIVATION_CODE env var !!"
    echo "!! Ouput:"
    echo "$status"
    echo "!!"
    exit -1
fi
tput sgr0
echo ""
