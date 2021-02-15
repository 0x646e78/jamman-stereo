#!/usr/bin/env bash

# jamman.sh by dnx

help() {
	printf '\n jamman.sh\n'
	printf ' A quick n dirty bash script to copy wav files onto the'
	printf ' Digitech JamMan Stereo pedal.\n'
	printf '\n Files MUST BE 44.1khz 16bit Stereo wav files.\n'
	printf '\n Usage:\n'
	printf '  ./jamman.sh <mntpoint> <patch_number> <filename>\n'
	printf ' Example:\n'
	printf '  ./jamman /Volumes/JAMMAN 01 filename.wav\n\n'
	exit 1
}	

if [ $# -ne 3 ]; then
  help
fi

# Check sdcard
if ! [ -d "${1}/JamManStereo" ]; then
  echo "No JamMan mount found at ${1}"
  echo "Check the path and if correct ensure there is a JamManStereo folder"
  exit 1
fi

# Check patch number is valid
if ! ((${2} >= 1 && ${2} <= 99)); then
  echo "Patch number ${2} is invalid. Must be a value from 1 to 99"
  exit 1
fi

# Check source file exists
if ! [ -f "${3}" ]; then
  echo "Source not found at ${3}"
  exit 1
fi

loopdir="${1}/JamManStereo/Patch${2}"

# TODO: `tCheck source file is valid format

overwrite=y
if [ -d "${loopdir}" ]; then
  echo ""
  read -p "Patch${2} already exists. Overwrite? [y/n]: " overwrite

  if ! [[ $overwrite == 'y' ]]; then
    echo "Exiting"
    exit 1
  fi
  rm -r ${loopdir}
fi


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

echo "Created ${3} as Patch${2} on JamMan sdcard"

#find ${loopdir} -regex .*xml -exec touch -t 198001011212 {} \;
