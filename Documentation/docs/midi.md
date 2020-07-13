# MIDI converter (Deprecated)

!!! Deprecated!
    The FPGC4 now has an APU, and does not use the TonePlayer anymore, making the current version of this script useless. When APU design has settled, a new version of this script should be made to program audio

The MIDI converter Python script can be used to convert basic MIDI files to notes and timings for the Timer and TonePlayer in the FPGC4. Only one channel is supported and not more than 4 notes should be played at the same time.

Using both tone players at the same time, like when using one to play bass notes while the other plays melody notes, can cause desync problems, since durations are converted to ms, and the script is not perfect yet.