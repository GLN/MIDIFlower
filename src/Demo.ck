class Demo extends MIDIFlowerPetal
{
    // Respond to a MIDI Note On message.
    function void noteOn(int key, int velocity)
    {
        // connect
        SinOsc s => dac;
        // configure
        Std.mtof(key) => s.freq;
        velocity / 127.0 => s.gain;
        // we're implementing noteOn(), so we must include this line
        this.events()[key] => now;
        // disconnect
        s =< dac;
    }
}

// instantiate instrument
Demo d;
// assign instrument to MIDI channel
MIDIFlower.assign(d, MIDI.CHANNEL_1);
// log MIDI messages to console
MIDIFlower.log(true);
