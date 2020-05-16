# MIDI converter
The MIDI converter Python script can be used to convert basic MIDI files to notes and timings for the Timer and TonePlayer in the FPGC4. Only one channel is supported and not more than 4 notes should be played at the same time.

Using both tone players at the same time, like when using one to play bass notes while the other plays melody notes, can cause desync problems, since durations are converted to ms, and the script is not perfect yet.