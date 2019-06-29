#!/usr/bin/env bash

# A quick n dirty bash script to copy wav files onto the            #
# Digitech JamMan Stereo pedal.                                     #
# Files MUST BE 16bit Stereo wav files.                             #
#                                                                   #
# Use it as such:                                                   #
#   ./jamman.sh <mntpoint> <patch_number> <filename>                #
# Example:                                                          #
#   ./jamman /Volumes/JAMMAN 01 filename.wav                        #
#                                                                   #
# WARNING: I'm not validating parameters etc, if you miss type you  #
# could mess up your system.                                        #

loopdir="${1}/JamManStereo/Patch${2}"

rm -r ${loopdir}

mkdir -p ${loopdir}/PhraseA
cp "$3" $loopdir/PhraseA/phrase.wav

cat << EOF >> ${loopdir}/patch.xml
<?xml version="1.0" encoding="UTF-8" ?>
<JamManPatch xmlns="http://schemas.digitech.com/JamMan/Patch" device="JamManStereo" version="1">
    <PatchName></PatchName>
    <RhythmType>StudioKickAndHighHat</RhythmType>
    <StopMode>StopInstantly</StopMode>
    <SettingsVersion>1</SettingsVersion>
    <ID>4e3dba34-1dd2-11b2-a61d-ab7f0ce30475</ID>
    <Metadata />
</JamManPatch>
EOF

cat << EOF >> ${loopdir}/PhraseA/phrase.xml
<?xml version="1.0" encoding="UTF-8" ?>
<JamManPhrase xmlns="http://schemas.digitech.com/JamMan/Phrase" version="1">
    <BeatsPerMinute>100.4174575806</BeatsPerMinute>
    <BeatsPerMeasure>4</BeatsPerMeasure>
    <BpmValidated>0</BpmValidated>
    <IsLoop>0</IsLoop>
    <IsReversed>0</IsReversed>
    <SettingsVersion>1</SettingsVersion>
    <AudioVersion>1</AudioVersion>
    <ID>4e41ffea-1dd2-11b2-a61d-f9570276ec9e</ID>
    <Metadata />
</JamManPhrase>
EOF

#find ${loopdir} -regex .*xml -exec touch -t 198001011212 {} \;
