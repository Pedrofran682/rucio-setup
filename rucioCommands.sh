RED='\033[0;31m'
NC='\033[0m'

echo "Setup ATLAS env. You must execute this command"
echo -e "${RED}setupATLAS${NC}"
echo 
echo


echo "Init rucio"
echo "voms-proxy-init -voms atlas"
echo "lsetup 'rucio -w"
echo 
echo


echo "Filter OAD dataset"
echo rucio list-dids "mc21_13p6TeV.601189.PhPy8EG_AZNLO_Zee*" --filter type=dataset,datatype=AOD

echo
echo

echo "List files from a dataset"
echo rucio list-files "mc21_13p6TeV.601189.PhPy8EG_AZNLO_Zee.recon.AOD.e8453_e8455_s3873_s3874_r14136"

echo
echo

echo "Get physical location storage of a file"
echo rucio list-dataset-replicas  data15_13TeV:data15_13TeV.00276329.physics_Main.merge.AOD.f620_m1480

echo
echo


echo "Download a file from a dataset"
echo rucio download data23_13p6TeV:data23_13p6TeV.00450445.physics_Main.merge.AOD.f1342_m2167._lb0110._0001.1

echo
echo

echo "Get a random file from the dataset"
echo rucio download --nrandom 1 "data23_13p6TeV:data23_13p6TeV.00450445.physics_Main.merge.AOD.f1342_m2167"

