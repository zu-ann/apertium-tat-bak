#TMPDIR=/tmp

if [[ $1 = "ba-tt" ]]; then

hfst-fst2strings ../.deps/ba.LR-debug.hfst | sort -u |  sed 's/:/%/g' | cut -f1 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../apertium-tt-ba.ba-tt.t1x  ../ba-tt.t1x.bin  ../ba-tt.autobil.bin |
        apertium-transfer -n ../apertium-tt-ba.ba-tt.t2x  ../ba-tt.t2x.bin  | tee $TMPDIR/tmp_testvoc2.txt |
        hfst-proc -d ../ba-tt.autogen.hfst > $TMPDIR/tmp_testvoc3.txt
paste -d _ $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'

elif [[ $1 = "tt-ba" ]]; then

hfst-fst2strings ../.deps/tt.LR-debug.hfst | sort -u | sed 's/:/%/g' | cut -f1 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../apertium-tt-ba.tt-ba.t1x  ../tt-ba.t1x.bin  ../tt-ba.autobil.bin | 
        apertium-transfer -n ../apertium-tt-ba.tt-ba.t2x  ../tt-ba.t2x.bin | tee $TMPDIR/tmp_testvoc2.txt |
        hfst-proc -d ../tt-ba.autogen.hfst > $TMPDIR/tmp_testvoc3.txt
paste -d _ $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'


else
	echo "sh inconsistency.sh <direction>";
fi
