
if [ -f setup.sh ]; then
  . setup.sh;
else
  echo "ERROR: setup.sh is missing!";
  exit 1;
fi

cmvn_dir=exp/cmvn

path=feat
options="--use-energy=false"

echo "Acoustic features will be extracted in the following directory : "
echo "  $path"

mkdir -p $path
mkdir -p $cmvn_dir

echo "Extracting train set"
target=train
log=$path/$target.extract.log
compute-mfcc-feats --verbose=2 $options scp:material/$target.wav.scp ark,t,scp:$path/$target.13.ark,$path/$target.13.scp 2> $log
# TODO: 
#	1. use add-deltas to add delta features to original mfcc feature set
#	2. use compute-cmvn-stats & apply-cmvn to compute cmvn statistics and apply cmvn with global means and variatnces to previous 39-dim mfcc feature set
add-deltas --delta-order=2 ark:$path/$target.13.ark ark,t:$path/$target.13.delta.ark
compute-cmvn-stats ark:$path/$target.13.delta.ark ark:- | apply-cmvn ark:- ark:$path/$target.13.delta.ark ark:$path/$target.39.cmvn.ark 2> $log

echo "Extracting dev set"
target=dev
log=$path/$target.extract.log
compute-mfcc-feats --verbose=2 $options scp:material/$target.wav.scp ark,t,scp:$path/$target.13.ark,$path/$target.13.scp 2> $log
# TODO: 
#	1. use add-deltas to add delta features to original mfcc feature set
#	2. use compute-cmvn-stats & apply-cmvn to compute cmvn statistics and apply cmvn with global means and variatnces to previous 39-dim mfcc feature set
add-deltas --delta-order=2 ark:$path/$target.13.ark ark,t:$path/$target.13.delta.ark
compute-cmvn-stats ark:$path/$target.13.delta.ark ark:- | apply-cmvn ark:- ark:$path/$target.13.delta.ark ark:$path/$target.39.cmvn.ark 2> $log

echo "Extracting test set"
target=test
log=$path/$target.extract.log
compute-mfcc-feats --verbose=2 $options scp:material/$target.wav.scp ark,t,scp:$path/$target.13.ark,$path/$target.13.scp 2> $log
# TODO: 
#	1. use add-deltas to add delta features to original mfcc feature set
#	2. use compute-cmvn-stats & apply-cmvn to compute cmvn statistics and apply cmvn with global means and variatnces to previous 39-dim mfcc feature set
add-deltas --delta-order=2 ark:$path/$target.13.ark ark,t:$path/$target.13.delta.ark
compute-cmvn-stats ark:$path/$target.13.delta.ark ark:- | apply-cmvn ark:- ark:$path/$target.13.delta.ark ark:$path/$target.39.cmvn.ark 2> $log

#

sec=$SECONDS

echo ""
echo "Execution time for whole script = `utility/timer.pl $sec`"
echo ""

