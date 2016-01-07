public class MIDI
{
    // channel
    static int CHANNEL_1;
    static int CHANNEL_2;
    static int CHANNEL_3;
    static int CHANNEL_4;
    static int CHANNEL_5;
    static int CHANNEL_6;
    static int CHANNEL_7;
    static int CHANNEL_8;
    static int CHANNEL_9;
    static int CHANNEL_10;
    static int CHANNEL_11;
    static int CHANNEL_12;
    static int CHANNEL_13;
    static int CHANNEL_14;
    static int CHANNEL_15;
    static int CHANNEL_16;

    // count
    static int CHANNEL_COUNT;
    static int KEY_COUNT;

    // status
    static int NOTE_OFF;
    static int NOTE_ON;
    static int KEY_PRESSURE;
    static int CONTROL_CHANGE;
    static int PROGRAM_CHANGE;
    static int CHANNEL_PRESSURE;
    static int PITCH_BEND;
    static int SYSTEM;
}

// channel
  0 => MIDI.CHANNEL_1;
  1 => MIDI.CHANNEL_2;
  2 => MIDI.CHANNEL_3;
  3 => MIDI.CHANNEL_4;
  4 => MIDI.CHANNEL_5;
  5 => MIDI.CHANNEL_6;
  6 => MIDI.CHANNEL_7;
  7 => MIDI.CHANNEL_8;
  8 => MIDI.CHANNEL_9;
  9 => MIDI.CHANNEL_10;
 10 => MIDI.CHANNEL_11;
 11 => MIDI.CHANNEL_12;
 12 => MIDI.CHANNEL_13;
 13 => MIDI.CHANNEL_14;
 14 => MIDI.CHANNEL_15;
 15 => MIDI.CHANNEL_16;

// count
 16 => MIDI.CHANNEL_COUNT;
128 => MIDI.KEY_COUNT;

// status (channel 1)
128 => MIDI.NOTE_OFF;
144 => MIDI.NOTE_ON;
160 => MIDI.KEY_PRESSURE;
176 => MIDI.CONTROL_CHANGE;
192 => MIDI.PROGRAM_CHANGE;
208 => MIDI.CHANNEL_PRESSURE;
224 => MIDI.PITCH_BEND;
240 => MIDI.SYSTEM;
