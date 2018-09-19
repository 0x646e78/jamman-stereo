# jamman-stereo
A quick n dirty bash script to copy wav files onto the Digitech JamMan Stereo pedal as Single play patches.

Files MUST BE 16bit Stereo wav files.

Use:
```bash
./jamman.sh <mntpoint> <patch_number> <filename>
```

Example:
```bash
./jamman /Volumes/JAMMAN 01 some\ cool\ sound.wav
```
WARNING: I'm not validating parameters etc, if you miss type you could mess up your system.
