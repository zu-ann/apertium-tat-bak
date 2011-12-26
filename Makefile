
all: ba-tt tt-ba debug
	apertium-validate-dictionary apertium-tt-ba.tt-ba.dix 
	lt-comp lr apertium-tt-ba.tt-ba.dix tt-ba.autobil.bin
	lt-comp rl apertium-tt-ba.tt-ba.dix ba-tt.autobil.bin
	lt-comp lr apertium-tt-ba.post-tt.dix ba-tt.autopgen.bin
	lt-comp lr apertium-tt-ba.post-ba.dix tt-ba.autopgen.bin
	apertium-validate-transfer apertium-tt-ba.tt-ba.t1x
	apertium-preprocess-transfer apertium-tt-ba.tt-ba.t1x tt-ba.t1x.bin
	apertium-validate-transfer apertium-tt-ba.tt-ba.t2x
	apertium-preprocess-transfer apertium-tt-ba.tt-ba.t2x tt-ba.t2x.bin
	apertium-validate-transfer apertium-tt-ba.ba-tt.t1x
	apertium-preprocess-transfer apertium-tt-ba.ba-tt.t1x ba-tt.t1x.bin
	apertium-validate-transfer apertium-tt-ba.ba-tt.t2x
	apertium-preprocess-transfer apertium-tt-ba.ba-tt.t2x ba-tt.t2x.bin
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

.deps/tt.twol.hfst: apertium-tt-ba.tt.twol
	hfst-twolc apertium-tt-ba.tt.twol -o .deps/tt.twol.hfst

.deps/ba.twol.hfst:
	hfst-twolc apertium-tt-ba.ba.twol -o .deps/ba.twol.hfst

debug: .deps/tt.twol.hfst .deps/ba.twol.hfst
	cat apertium-tt-ba.tt.lexc | grep -v 'Dir/RL' | grep -v 'Use/Circ' > .deps/tt.LR-debug.lexc
	hfst-lexc --format foma .deps/tt.LR-debug.lexc -o .deps/tt.LR-debug.lexc.hfst
	hfst-compose-intersect -1 .deps/tt.LR-debug.lexc.hfst -2 .deps/tt.twol.hfst -o .deps/tt.LR-debug.hfst
	cat apertium-tt-ba.ba.lexc | grep -v 'Dir/RL' | grep -v 'Use/Circ' > .deps/ba.LR-debug.lexc
	hfst-lexc --format foma .deps/ba.LR-debug.lexc -o .deps/ba.LR-debug.lexc.hfst
	hfst-compose-intersect -1 .deps/ba.LR-debug.lexc.hfst -2 .deps/ba.twol.hfst -o .deps/ba.LR-debug.hfst
	
tt-ba: .deps/tt.twol.hfst
	if [ ! -d .deps ]; then mkdir .deps; fi
	cat apertium-tt-ba.tt.lexc | grep -v 'Dir/LR' > .deps/tt.RL.lexc
	cat apertium-tt-ba.tt.lexc | grep -v 'Dir/RL' > .deps/tt.LR.lexc
	hfst-lexc --format foma .deps/tt.RL.lexc -o .deps/tt.RL.lexc.hfst
	hfst-lexc --format foma .deps/tt.LR.lexc -o .deps/tt.LR.lexc.hfst
	hfst-compose-intersect -1 .deps/tt.RL.lexc.hfst -2 .deps/tt.twol.hfst -o .deps/tt.RL.hfst
	hfst-compose-intersect -1 .deps/tt.LR.lexc.hfst -2 .deps/tt.twol.hfst -o .deps/tt.LR.hfst
	hfst-fst2fst -O .deps/tt.RL.hfst -o ba-tt.autogen.hfst
	hfst-invert .deps/tt.LR.hfst | hfst-fst2fst -O -o tt-ba.automorf.hfst

ba-tt: .deps/ba.twol.hfst
	if [ ! -d .deps ]; then mkdir .deps; fi
	cat apertium-tt-ba.ba.lexc | grep -v 'Dir/LR' > .deps/ba.RL.lexc
	cat apertium-tt-ba.ba.lexc | grep -v 'Dir/RL' > .deps/ba.LR.lexc
	hfst-lexc --format foma .deps/ba.RL.lexc -o .deps/ba.RL.lexc.hfst
	hfst-lexc --format foma .deps/ba.LR.lexc -o .deps/ba.LR.lexc.hfst
	hfst-compose-intersect -1 .deps/ba.RL.lexc.hfst -2 .deps/ba.twol.hfst -o .deps/ba.RL.hfst
	hfst-compose-intersect -1 .deps/ba.LR.lexc.hfst -2 .deps/ba.twol.hfst -o .deps/ba.LR.hfst
	hfst-fst2fst -O .deps/ba.RL.hfst -o tt-ba.autogen.hfst
	hfst-invert .deps/ba.LR.hfst | hfst-fst2fst -O -o ba-tt.automorf.hfst

clean:
	rm -rf .deps modes *.hfst *.bin *.mode 
