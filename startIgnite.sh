echo "before Ignite start"
dir=$(pwd -P)
echo $dir
echo $(ls -alrt)
echo "------------------------"
echo "0"
echo $(ls -alrt /poc/gridgain/gridgain-enterprise-fabric-8.4.4)
echo "0.1"
echo "----------------------"
filename="/poc/gridgain/gridgain-enterprise-fabric-8.4.4/bin/ignite.sh"
echo "1"
echo $filename
chmod 777 $filename
echo "2"
sh $filename

echo $(ls -alrt /poc/gridgain/gridgain-enterprise-fabric-8.4.4/bin/)
sh $filename
echo "After Ignite start"
