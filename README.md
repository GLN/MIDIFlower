MIDIFlower
==========

Overview
--------

MIDIFlower is a lightweight MIDI input framework for the [ChucK](http://chuck.stanford.edu/) music programming language. Written in ChucK, MIDIFlower listens for and routes incoming MIDI data to your ChucK instruments.

If you're using a MIDI controller with ChucK, MIDIFlower is for you.

Usage
-----

Using MIDIFlower is simple:

- set your device port;
- create an instrument class;
- assign your instrument to a MIDI channel.

In detail, and assuming use of [miniAudicle](http://chuck.stanford.edu/release/):

- Set your MIDI device's port number in `Device.ck` (see miniAudicle's Device Browser for this number).
- Create a class and inherit from `MIDIFlowerPetal`.
- Implement the MIDI messages you wish to respond to by overriding the corresponding methods in `MIDIFlowerPetal.ck`. There are eight different MIDI messages and they're all optional.
- Instantiate your instrument and `MIDIFlower.assign();` it to one of 16 MIDI channels. You may assign more than one instrument to the same channel for multi-timbral performance.
- Add Shred: `initialize.ck`.
- Add Shred: `YourClass.ck`.
- Play your ChucK instrument with your MIDI device!

Documentation
-------------

The source code is completely documented, and `Demo.ck` is a basic implementation.

Troubleshooting
---------------

- Ensure that your MIDI device is transmitting on the proper MIDI channel.
- Use `MIDIFlower.log(true);` to see if MIDIFlower is receiving MIDI data.

License
-------

MIDIFlower is available under the [BSD 2-Clause License](https://opensource.org/licenses/BSD-2-Clause).

Copyright
---------

© [Gregory Lee Newsome](http://gregoryleenewsome.ca/) 2016
