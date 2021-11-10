SHELL:=/junofs/users/valprod2/CI_scripts/muon/condor.back

export MAKE_TARGET=$@
export MAKE_SOURCE=$^
base:=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release
ver:=J21v1r0-Pre0
TUTORIALROOT:=$(base)/$(ver)/offline/Examples/Tutorial
muon:=/junofs/users/wengjun/photon/Muon.exe
.PHONY:all

ith:=$(shell seq 1 10)
all: $(ith:%=save/%/general_singleMu.root)

save/%/general_singleMu.root: 
	../wrap_${ver}  $(muon) -seed $* -o save/$*/gen_$*.txt -n 1 -s juno -v Rock -r Yes -mult 1 -ntrks 1 & (../wrap_${ver} python ${TUTORIALROOT}/share/tut_detsim.py --no-gdml --anamgr-muon  --opticks-anamgr --anamgr-tt --anamgr-normal-hit --evtmax 1 --seed $* --pmtsd-v2 --pmt-hit-type 2 --pmtsd-merge-twindow 1.0 --split-maxhits 300 --output $@  --user-output save/$*/user.root --detoption Acrylic hepevt --exe Muon --file save/$*/gen_$*.txt)
# Delete partial files when the processes are killed.
.DELETE_ON_ERROR:
# Keep intermediate files around
.SECONDARY:
