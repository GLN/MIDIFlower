public class MIDIFlower
{
    // data
    // ----------------------------------------------------------------- //

    static _MIDIFlower @_flower;

    // public
    // ----------------------------------------------------------------- //

    // Description
    //     Assign an instrument to a MIDI channel. You may assign more than one
    //     instrument to the same channel for multi-timbral performance.
    // Parameter
    //     instrument -- Class inheriting from MIDIFlowerPetal.
    //     channel -- MIDI channel (see MIDI.ck).
    // Return
    //     void
    function static void assign(MIDIFlowerPetal @instrument, int channel)
    {
        _flower._assign(instrument, channel);
    }

    // Description
    //     Log MIDI message to console.
    // Parameter
    //     bool -- Boolean value, i.e. true or false.
    // Return
    //     void
    function static void log(int bool)
    {
        bool => _flower._log;
    }
}

private class _MIDIFlower
{
    // data + accessor
    // ----------------------------------------------------------------- //

    MidiIn _input;
    MIDIFlowerPetal _instruments[MIDI.CHANNEL_COUNT][0];
    int _log;

    function MidiIn input()
    {
        return _input;
    }

    function MIDIFlowerPetal[][] instruments()
    {
        return _instruments;
    }

    // private
    // ----------------------------------------------------------------- //

    // Description
    //     Assign an instrument to a MIDI channel. You may assign more than one
    //     instrument to the same channel for multi-timbral performance.
    // Parameter
    //     instrument -- Class inheriting from MIDIFlowerPetal.
    //     channel -- MIDI channel (see MIDI.ck).
    // Return
    //     void
    function void _assign(MIDIFlowerPetal @instrument, int channel)
    {
        if (instrument != null) {
            if (channel > -1 && channel < MIDI.CHANNEL_COUNT) {
                this.instruments()[channel] << instrument;
            } else {
                <<< "MIDIFlower: invalid channel", channel >>>;
            }
        } else {
            <<< "MIDIFlower: cannot assign null">>>;
        }
    }

    // Description
    //     Return the MIDI channel of a MIDI status byte.
    // Parameter
    //     statusByte -- MIDI status byte.
    // Return
    //     MIDI channel.
    function int _channel(int statusByte)
    {
        return statusByte % MIDI.CHANNEL_COUNT;
    }

    // Description
    //     Open a MIDI port and listen on it.
    // Parameter
    //     port -- Port your MIDI device is on. See:
    //         miniAudicle > Menu > Window > Device Browser > Source: MIDI
    //     for your MIDI device's port number.
    // Return
    //     void
    function void _init(int port)
    {
        if (this.input().open(port)) {
            <<< "opening MIDI port", port, "--", this.input().name() >>>;
            this._listen();
        } else {
            me.exit();
        }
    }

    // Description
    //     Listen for a MIDI message from a MIDI device.
    //     If log is true, print MIDI message to console.
    // Parameter
    //     void
    // Return
    //     void
    function void _listen()
    {
        MidiMsg message;

        while (true) {
            this.input() => now;
            while (this.input().recv(message)) {
                if (this._log) {
                    <<< message.data1, message.data2, message.data3 >>>;
                }
                this._validate(message);
            }
        }
    }

    // Description
    //     Route a MIDI message to the instrument(s) on a MIDI channel.
    // Parameter
    //     message -- ChucK MidiMsg object.
    // Return
    //     void
    function void _route(MidiMsg @message)
    {
        this._channel(message.data1) => int channel;
        this._status(message.data1) => int status;

        for (int i; i < this.instruments()[channel].size(); i++) {
            this.instruments()[channel][i] @=> MIDIFlowerPetal @instrument;
            if (status == MIDI.NOTE_OFF) {
                instrument.noteOff(message.data2, message.data3);
            } else if (status == MIDI.NOTE_ON) {
                spork ~ instrument.noteOn(message.data2, message.data3);
            } else if (status == MIDI.KEY_PRESSURE) {
                instrument.keyPressure(message.data2, message.data3);
            } else if (status == MIDI.CONTROL_CHANGE) {
                instrument.controlChange(message.data2, message.data3);
            } else if (status == MIDI.PROGRAM_CHANGE) {
                instrument.programChange(message.data2);
            } else if (status == MIDI.CHANNEL_PRESSURE) {
                instrument.channelPressure(message.data2);
            } else if (status == MIDI.PITCH_BEND) {
                instrument.pitchBend(message.data2, message.data3);
            } else if (status == MIDI.SYSTEM) {
                instrument.system(message);
            } else {
                <<< "MIDIFlower: invalid status byte", message.data1 >>>;
            }
        }
    }

    // Description
    //     Return the MIDI status of a MIDI status byte as if it were on MIDI
    //     channel 1.
    // Parameter
    //     statusByte -- MIDI status byte.
    // Return
    //     MIDI status (on MIDI channel 1).
    function int _status(int statusByte)
    {
        return statusByte - this._channel(statusByte);
    }

    // Description
    //     Validate a MIDI message. Specifically, ensure that the destination
    //     MIDI channel is not empty.
    // Parameter
    //     message -- ChucK MidiMsg object.
    // Return
    //     void
    function void _validate(MidiMsg @message)
    {
        this._channel(message.data1) => int channel;
        this._status(message.data1) => int status;

        if (this.instruments()[channel].size() > 0) {
            this._route(message);
        } else {
            if (status != MIDI.NOTE_OFF) {
                <<< "MIDIFlower: no instrument on channel", channel + 1 >>>;
            }
        }
    }
}

new _MIDIFlower @=> MIDIFlower._flower;
MIDIFlower._flower._init(Device.PORT);
