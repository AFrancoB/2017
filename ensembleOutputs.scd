(
SynthDef(\cosmos ++ ("Stereo"), { |vol=1, makeUp= 2,
	thresh= 0.025118864315096, sBelow=1, sAbove=0.25,
	lim=0.1, // lim is -20db
	out=0, in=100, gate=1|
	var floor;
	var env;
	var mid, md1, md2, md3, md4, md5, md6, md7, md8;
	var ceil, cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8;
	var b = 16;

	env = EnvGen.kr(Env.adsr(0.01,0.001,1,2),gate,doneAction:2);

	// Compander.ar(in: 0.0, control: 0.0, thresh: 0.5, slopeBelow: 1.0, slopeAbove: 1.0, clampTime: 0.01, relaxTime: 0.1, mul: 1.0, add: 0.0)
	floor = In.ar(in,8)*vol;
	floor = Compander.ar(floor,floor, thresh, sBelow, sAbove);
	floor = Limiter.ar(floor,lim,0.015);
	floor = FreeVerb.ar(floor)*makeUp*env;

	mid = RHPF.ar(DelayL.ar(floor,0.2,0.1), LFSaw.kr(0.05).range(500,2000),1, (1).dbamp);
	# md1, md2, md3, md4, md5, md6, md7, md8 = mid;

	ceil = RHPF.ar(DelayL.ar(floor,0.2,0.05), LFSaw.kr(0.05).range(100,2500),1, (1.5).dbamp);
	ceil = FreeVerb.ar(ceil, 0.7, 0.8, 0.4);
	# cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8 = ceil;


	Out.ar(out, Pan2.ar(md1,  0)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md2,  0)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md4,  0.45)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md6, -0.45)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md8,  0.85)*(-3).dbamp);
	Out.ar(out, Pan2.ar(md7, -0.85)*(-3).dbamp);
	Out.ar(out, Pan2.ar(md5,  0.65)*(-4.5).dbamp);
	Out.ar(out, Pan2.ar(md3, -0.65)*(-4.5).dbamp);

	Out.ar(out, Pan2.ar(cl1, -0.5)*(0).dbamp); // front left
	Out.ar(out, Pan2.ar(cl2,  0.5)*(0).dbamp); // front right
	Out.ar(out, Pan2.ar(cl8, -0.75)*(-1.5).dbamp); // left front
	Out.ar(out, Pan2.ar(cl3,  0.75)*(-1.5).dbamp); // left right
	Out.ar(out, Pan2.ar(cl7, -1)*(-3).dbamp); // left back
	Out.ar(out, Pan2.ar(cl4,  1)*(-3).dbamp); // right back
	Out.ar(out, Pan2.ar(cl6, -0.35)*(-4.5).dbamp); // back left
	Out.ar(out, Pan2.ar(cl5,  0.35)*(-4.5).dbamp); // back right
}).add;

SynthDef(\cosmos, { |vol=1, makeUp= 2,
	thresh= 0.025118864315096, sBelow=1, sAbove=0.25,
	lim=0.1, // lim is -20db
	out=0, in=100, gate = 1|
	var floor;
	var env;
	var mid, md1, md2, md3, md4, md5, md6, md7, md8;
	var ceil, cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8;
	var b = 16;


	env = EnvGen.kr(Env.adsr(0.01,0.001,1,2),gate,doneAction:2);

	// Compander.ar(in: 0.0, control: 0.0, thresh: 0.5, slopeBelow: 1.0, slopeAbove: 1.0, clampTime: 0.01, relaxTime: 0.1, mul: 1.0, add: 0.0)
	floor = In.ar(in,8)*vol;
	floor = Compander.ar(floor,floor, thresh, sBelow, sAbove);
	floor = Limiter.ar(floor,lim,0.015);
	floor = FreeVerb.ar(floor)*makeUp*env;

	mid = BPF.ar(DelayL.ar(floor,0.4,0.2), LFSaw.kr(0.05).range(500,2000),1, (1).dbamp);
	# md1, md2, md3, md4, md5, md6, md7, md8 = mid;

	ceil = BPF.ar(DelayL.ar(floor,0.4,0.3), LFSaw.kr(0.05).range(100,2500),1, (3).dbamp);
	ceil = FreeVerb.ar(ceil, 0.7, 0.8, 0.4, (1.5).dbamp);
	# cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8 = ceil;

	//// mid
	Out.ar(out+ 8, md1);
	Out.ar(out+ 9, md2);
	Out.ar(out+11, md3);
	Out.ar(out+13, md4);
	Out.ar(out+15, md5);
	Out.ar(out+14, md6);
	Out.ar(out+12, md7);
	Out.ar(out+10, md8);

	//// ceil
	Out.ar(out+b+0, cl1);
	Out.ar(out+b+1, cl2);
	Out.ar(out+b+3, cl3);
	Out.ar(out+b+5, cl4);
	Out.ar(out+b+7, cl5);
	Out.ar(out+b+6, cl6);
	Out.ar(out+b+4, cl7);
	Out.ar(out+b+2, cl8);
}).add;

SynthDef(\nilTimekNot, { |vol=1, makeUp= 2,
	thresh= 0.025118864315096, sBelow=1, sAbove=0.25,
	lim=0.1, // lim is -20db
	out=0, in=100|
	var floor, flr1, flr2, flr3, flr4, flr5, flr6, flr7, flr8;
	var mid, md1, md2, md3, md4, md5, md6, md7, md8;
	var ceil, cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8;
	var b = 16;

	// Compander.ar(in: 0.0, control: 0.0, thresh: 0.5, slopeBelow: 1.0, slopeAbove: 1.0, clampTime: 0.01, relaxTime: 0.1, mul: 1.0, add: 0.0)
	floor = In.ar(in,8)*vol;
	floor = Compander.ar(floor,floor, thresh, sBelow, sAbove);
	floor = Limiter.ar(floor,lim,0.015);
	floor = FreeVerb.ar(floor)*makeUp;
	# flr1, flr2, flr3, flr4, flr5, flr6, flr7, flr8 = floor;

	mid = In.ar(in+8, 8)*vol;
	mid = Compander.ar(mid,mid, thresh, sBelow, sAbove);
	mid = Limiter.ar(mid,lim,0.015);
	mid = FreeVerb.ar(mid)*makeUp;
	# md1, md2, md3, md4, md5, md6, md7, md8 = mid;

	ceil = In.ar(in+16, 8)*vol;
	ceil = Compander.ar(ceil,ceil, thresh, sBelow, sAbove);
	ceil = Limiter.ar(ceil,lim,0.015);
	ceil = FreeVerb.ar(ceil)*makeUp;
	# cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8 = ceil;

	//// floor
	Out.ar(out  , flr1);
	Out.ar(out+1, flr2);
	Out.ar(out+3, flr3);
	Out.ar(out+5, flr4);
	Out.ar(out+7, flr5);
	Out.ar(out+6, flr6);
	Out.ar(out+4, flr7);
	Out.ar(out+2, flr8);

	//// mid
	Out.ar(out+ 8, md1);
	Out.ar(out+ 9, md2);
	Out.ar(out+11, md3);
	Out.ar(out+13, md4);
	Out.ar(out+15, md5);
	Out.ar(out+14, md6);
	Out.ar(out+12, md7);
	Out.ar(out+10, md8);

	//// ceil
	Out.ar(out+b+0, cl1);
	Out.ar(out+b+1, cl2);
	Out.ar(out+b+3, cl3);
	Out.ar(out+b+5, cl4);
	Out.ar(out+b+7, cl5);
	Out.ar(out+b+6, cl6);
	Out.ar(out+b+4, cl7);
	Out.ar(out+b+2, cl8);

}).add;



/// comentar codigo
SynthDef(\nilTimekNotToStereo, { |vol=1, makeUp= 2,
	thresh= 0.025118864315096, sBelow=1, sAbove=0.25,
	lim=0.1, // lim is -20db
	out=0, in=100|
	var floor, flr1, flr2, flr3, flr4, flr5, flr6, flr7, flr8;
	var mid, md1, md2, md3, md4, md5, md6, md7, md8;
	var ceil, cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8;

	// Compander.ar(in: 0.0, control: 0.0, thresh: 0.5, slopeBelow: 1.0, slopeAbove: 1.0, clampTime: 0.01, relaxTime: 0.1, mul: 1.0, add: 0.0)
	floor = In.ar(in,8)*vol;
	floor = Compander.ar(floor,floor, thresh, sBelow, sAbove);
	floor = Limiter.ar(floor,lim,0.015);
	floor = FreeVerb.ar(floor)*makeUp;
	# flr1, flr2, flr3, flr4, flr5, flr6, flr7, flr8 = floor;

	mid = In.ar(in+8, 8)*vol;
	mid = Compander.ar(mid,mid, thresh, sBelow, sAbove);
	mid = Limiter.ar(mid,lim,0.015);
	mid = FreeVerb.ar(mid)*makeUp;
	# md1, md2, md3, md4, md5, md6, md7, md8 = mid;

	ceil = In.ar(in+16, 8)*vol;
	ceil = Compander.ar(ceil,ceil, thresh, sBelow, sAbove);
	ceil = Limiter.ar(ceil,lim,0.015);
	ceil = FreeVerb.ar(ceil)*makeUp;
	# cl1, cl2, cl3, cl4, cl5, cl6, cl7, cl8 = ceil;

	//// reformulate with Pan2!!
	Out.ar(out, Pan2.ar(flr1, -0.5)*(0).dbamp); // front left
	Out.ar(out, Pan2.ar(flr2,  0.5)*(0).dbamp); // front right
	Out.ar(out, Pan2.ar(flr8, -0.75)*(-1.5).dbamp); // left front
	Out.ar(out, Pan2.ar(flr3,  0.75)*(-1.5).dbamp); // left right
	Out.ar(out, Pan2.ar(flr7, -1)*(-3).dbamp); // left back
	Out.ar(out, Pan2.ar(flr4,  1)*(-3).dbamp); // right back
	Out.ar(out, Pan2.ar(flr6, -0.35)*(-4.5).dbamp); // back left
	Out.ar(out, Pan2.ar(flr5,  0.35)*(-4.5).dbamp); // back right

	Out.ar(out, Pan2.ar(md1,  0)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md2,  0)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md4,  0.45)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md6, -0.45)*(-1.5).dbamp);
	Out.ar(out, Pan2.ar(md8,  0.85)*(-3).dbamp);
	Out.ar(out, Pan2.ar(md7, -0.85)*(-3).dbamp);
	Out.ar(out, Pan2.ar(md5,  0.65)*(-4.5).dbamp);
	Out.ar(out, Pan2.ar(md3, -0.65)*(-4.5).dbamp);

	Out.ar(out, Pan2.ar(cl1, -0.5)*(0).dbamp); // front left
	Out.ar(out, Pan2.ar(cl2,  0.5)*(0).dbamp); // front right
	Out.ar(out, Pan2.ar(cl8, -0.75)*(-1.5).dbamp); // left front
	Out.ar(out, Pan2.ar(cl3,  0.75)*(-1.5).dbamp); // left right
	Out.ar(out, Pan2.ar(cl7, -1)*(-3).dbamp); // left back
	Out.ar(out, Pan2.ar(cl4,  1)*(-3).dbamp); // right back
	Out.ar(out, Pan2.ar(cl6, -0.35)*(-4.5).dbamp); // back left
	Out.ar(out, Pan2.ar(cl5,  0.35)*(-4.5).dbamp); // back right

}).add;


// the speaker output should be 1 (front left), 2 (front right), 3 (back left), 4 (back right)
SynthDef(\quadraPiraran, { |vol=1, out=0, in=100|
	var in1, in2, in3, in4;
	# in1, in2, in3, in4 = FreeVerb.ar(In.ar(in,4));

	// Out.ar(out, [in1, in2, in4, in3] )
	Out.ar(out, [in1, in2, in3, in4] )

}).add;

SynthDef(\surroundPiraran, { |vol=1, out=0, in=100|
	var in1, in2, in3, in4;
	# in1, in2, in3, in4 = FreeVerb.ar(In.ar(in,4));

	Out.ar(out  , in1 );
	Out.ar(out+1, in2 );
	Out.ar(out+2, LPF.ar([in4 + in3]*(-9).dbamp,800) );
	Out.ar(out+4, in4 );
	Out.ar(out+5, in3 );

}).add;

// the speaker output should be 1 (front left), 2 (front right), 3 (back left), 4 (back right)
SynthDef(\quadToStereoPiraran, { |vol=1, out=0, in=100|
	var in1, in2, in3, in4;
	# in1,in2,in3,in4 = FreeVerb.ar(In.ar(in,4))*vol;

	Out.ar(out, [in1,in2]*(-1).dbamp);
	Out.ar(out, [in3,in4]*(-3).dbamp);

}).add;

// SynthDef(\hexaToStereoPiraran, { |vol=1, out=0, in=100|
// 	var in1, in2, in3, in4, in5, in6;
// 	# in1,in2,in3,in4,in5,in6 = In.ar(in,6);
//
// 	Out.ar(0, [in1,in2]*(-6).dbamp);
// 	Out.ar(0, [in3,in4]*(-12).dbamp);
//
// }).add;
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
