#!/bin/bash

# Assuming that you have the whole apertium tree in your source dir and you are in tat-bak directory.

# You have to compile apertium-tat and apertium-bak first.

cp ../../languages/apertium-tat/tat.automorf.att.gz apertium-tat-bak.tat-bak.LR.att.gz
cp ../../languages/apertium-tat/tat.autogen.att.gz apertium-tat-bak.bak-tat.RL.att.gz
cp ../../languages/apertium-bak/bak.automorf.att.gz apertium-tat-bak.bak-tat.LR.att.gz
cp ../../languages/apertium-bak/bak.autogen.att.gz apertium-tat-bak.tat-bak.RL.att.gz

DIFF=$(diff ../../languages/apertium-tat/apertium-tat.tat.rlx apertium-tat-bak.tat-bak.rlx)
if [ "$DIFF" != "" ]; then
        cp ../../languages/apertium-tat/apertium-tat.tat.rlx apertium-tat-bak.tat-bak.rlx
fi;

DIFF=$(diff ../../languages/apertium-bak/apertium-bak.bak.rlx apertium-tat-bak.bak-tat.rlx)
if [ "$DIFF" != "" ]; then
        cp ../../languages/apertium-bak/apertium-bak.bak.rlx apertium-tat-bak.bak-tat.rlx
fi;

exit 0


