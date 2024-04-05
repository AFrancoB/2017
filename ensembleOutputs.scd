(
SynthDef(\floorNILPiraran, { |vol=1, out=0, in=100|
	var in1, in2, in3, in4, in5, in6, in7, in8;
	# in1, in2, in3, in4, in5, in6, in7, in8 = In.ar(in,8);

	Out.ar(out, [in1, in2, in8, in3, in7, in4, in6, in5] )

}).add;

SynthDef(\middleNILPiraran, { |vol=1, out=0, in=108|
	var in1, in2, in3, in4, in5, in6, in7, in8;
	# in1, in2, in3, in4, in5, in6, in7, in8 = In.ar(in,8);

	Out.ar(out, [in1, in2, in8, in3, in7, in4, in6, in5] )

}).add;

SynthDef(\ceilingNILPiraran, { |vol=1, out=0, in=116|
	var in1, in2, in3, in4, in5, in6, in7, in8;
	# in1, in2, in3, in4, in5, in6, in7, in8 = In.ar(in,8);

	Out.ar(out, [in1, in2, in8, in3, in7, in4, in6, in5] )

}).add;

// the speaker output should be 1 (front left), 2 (front right), 3 (back left), 4 (back right)
SynthDef(\quadraPiraran, { |vol=1, out=0, in=100|
	var in1, in2, in3, in4;
	# in1, in2, in3, in4 = In.ar(in,4);

	Out.ar(out, [in1, in2, in4, in3] )

}).add;

// the speaker output should be 1 (front left), 2 (front right), 3 (back left), 4 (back right)
SynthDef(\stereoPiraran, { |vol=1, out=0, in=100|
	var w, x, y, z, decoded;
	# w,x,y,z = BFEncode1.ar(In.ar(in,4),[-0.25pi,0.25pi, 0.75pi, -0.75pi],0,2,1);
	decoded = BFDecode1.ar(w,x,y,z, [-0.25pi,0.25pi]);

	Out.ar(out, decoded*vol )
}).add;
);






///// testing:

// Synth(\piraranQuadra)
// test quadra
//{Out.ar(100, PanAz.ar(4,WhiteNoise.ar(0.1),LFSaw.ar(0.1)))}.play



//// experiments for the NIL
/*(
~nel = [
	// floor speakers (0 to 7)
	[-0.25pi,-0.5pi], [0.25pi,-0.5pi], [-0.375pi,-0.5pi], [0.375pi,-0.5pi],
	[-0.625pi,-0.5pi], [0.625pi,-0.5pi], [-0.75pi,-0.5pi], [0.75pi,-0.5pi],
	// middle row speakers (8 to )
	[0pi,0pi], [0pi,-0.05pi],
	[-0.3pi,0pi], [0.3pi, 0pi], [-0.34pi, 0pi], [0.34pi, 0pi],
	[-0.6pi, 0pi], [0.6pi, 0pi],
	// ceiling speakers
	[-0.25pi,0.5pi], [0.25pi,0.5pi], [-0.375pi,0.5pi], [0.375pi,0.5pi],
	[-0.625pi,0.5pi], [0.625pi,0.5pi], [-0.75pi,0.5pi], [0.75pi,0.5pi]
].flop;

SynthDef(\piraranOutNIL, { |out=0, in=100, vol=1|
	var w,x,y,z, nel, decoded;

	nel = [
	// floor speakers (0 to 7)
	[-0.25pi,-0.5pi], [0.25pi,-0.5pi], [-0.375pi,-0.5pi], [0.375pi,-0.5pi],
	[-0.625pi,-0.5pi], [0.625pi,-0.5pi], [-0.75pi,-0.5pi], [0.75pi,-0.5pi],
	// middle speakers (8 to 15)
	[0pi,0pi], [0pi,-0.05pi],
	[-0.3pi,0pi], [0.3pi, 0pi], [-0.34pi, 0pi], [0.34pi, 0pi],
	[-0.6pi, 0pi], [0.6pi, 0pi],
		// ceiling speakers (16 to 23)
	[-0.25pi,0.5pi], [0.25pi,0.5pi], [-0.375pi,0.5pi], [0.375pi,0.5pi],
	[-0.625pi,0.5pi], [0.625pi,0.5pi], [-0.75pi,0.5pi], [0.75pi,0.5pi]
].flop;

	# w,x,y,z = BFEncode2.ar(Pulse.ar(5,0.5,0.01), SinOsc.ar(0.5), SinOsc.ar(1,pi), 0, 2   );

	decoded = BFDecode1.ar(w,x,y,z, nel[0], nel[1]);
	// decoded = BFDecode1.ar(w,x,y,z, [-0.25pi,0.25pi], [0pi,0pi]);
	// decoded = BFDecode1.ar(w,x,y,z, [-0.25pi,0.25pi, -0.75pi, 0.75pi], [0,0,0,0]);



	Out.ar(out, decoded*vol)
}).add
)*/
