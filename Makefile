all:
	if [ ! -d .deps ]; then mkdir .deps; fi
	hfst-lexc --format foma apertium-tt-ba.tt.lexc -o .deps/tt.lexc.hfst
	hfst-twolc apertium-tt-ba.tt.twol -o .deps/tt.twol.hfst
	hfst-compose-intersect -1 .deps/tt.lexc.hfst -2 .deps/tt.twol.hfst -o .deps/tt.gen.hfst
	hfst-invert .deps/tt.gen.hfst -o .deps/tt.mor.hfst
	hfst-fst2fst -O .deps/tt.gen.hfst -o ba-tt.autogen.hfst
	hfst-fst2fst -O .deps/tt.mor.hfst -o tt-ba.automorf.hfst
	hfst-lexc --format foma apertium-tt-ba.ba.lexc -o .deps/ba.lexc.hfst
	hfst-twolc apertium-tt-ba.ba.twol -o .deps/ba.twol.hfst
	hfst-compose-intersect -1 .deps/ba.lexc.hfst -2 .deps/ba.twol.hfst -o .deps/ba.gen.hfst
	hfst-invert .deps/ba.gen.hfst -o .deps/ba.mor.hfst
	hfst-fst2fst -O .deps/ba.gen.hfst -o tt-ba.autogen.hfst
	hfst-fst2fst -O .deps/ba.mor.hfst -o ba-tt.automorf.hfst
	apertium-validate-dictionary apertium-tt-ba.tt-ba.dix 
	lt-comp lr apertium-tt-ba.tt-ba.dix tt-ba.autobil.bin
	lt-comp rl apertium-tt-ba.tt-ba.dix ba-tt.autobil.bin
	apertium-validate-transfer apertium-tt-ba.tt-ba.t1x
	apertium-preprocess-transfer apertium-tt-ba.tt-ba.t1x tt-ba.t1x.bin
	apertium-validate-transfer apertium-tt-ba.ba-tt.t1x
	apertium-preprocess-transfer apertium-tt-ba.ba-tt.t1x ba-tt.t1x.bin
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

clean:
	rm -rf .deps modes *.hfst *.bin *.mode 
