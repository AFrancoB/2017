// this synthdefs transform a station position to a position in the NIL or in a stereo field
var nelArr = [
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

var angle = { | space |
	var angle = space.angle;

	if(angle.isNegative, {360 + angle}, {angle})
};

var minMaxDist = {| spaces |
	var distances = spaces.collect {|item|  item.distance.asFloat   };
	(min: distances.minItem, max: distances.maxItem) };


var left = { |degree| (degree/360)*(-1)*pi };
var right = { |degree| (degree/360)*pi };

var nel = [left.(35), right.(35), left.(65), right.(65), left.(90), right.(90), left.(125), right.(125)];


SynthDef(\stationPositionToNIL, {
	|out=0, amp=0.5, angle=0, dist=0, maxd=100, mind=1, in=200|
	// var angleIn = 271; // testing
	// var inTest = WhiteNoise.ar(0.1);
	var di = dist.linlin(mind,maxd,0,4);
	var lev = amp;
	var radians = angle * (pi / 180);
	var yP = di * radians.cos;
	var xP = di * radians.sin;
	var w, x, y, z;
	var inSig = In.ar(in);
	var sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8;
	var sig;

/*	#w, x, y, z = BFEncode2.ar(inSig, xP*(-1), yP*(-1), 0, lev, 0);
    //decode for 4 channels
	sig = BFDecode1.ar1(w, x, y, z, nelArr[0], nelArr[1],20,20);*/

	#sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8 = PanAz.ar(8,inSig,radians);


	Out.ar(out+0, sig1);
	Out.ar(out+1, sig2);
	Out.ar(out+2, sig8);
	Out.ar(out+3, sig3);
	Out.ar(out+4, sig7);
	Out.ar(out+5, sig4);
	Out.ar(out+6, sig6);
	Out.ar(out+7, sig5);

	// Out.ar(out, sig)
}).add;

SynthDef(\stationPositionToStereo, {
	|out=0, amp=0.5, angle=0, dist=0, maxd=100, mind=1, in=200|
	// var angleIn = 271; // testing
	// var inTest = WhiteNoise.ar(0.1);
	var di = dist.linlin(mind,maxd,0,4);
	var lev = amp;
	var radians = angle * (pi / 180);
	var yP = di * radians.cos;
	var xP = di * radians.sin;
	var w, x, y, z;
	var inSig = In.ar(in);
	var sig;

	#w, x, y, z = BFEncode2.ar(inSig, xP*(-1), yP*(-1), 0, lev, 0);
    //decode for 4 channels
	sig = BFDecode1.ar(w, x, y, z, [1.75pi, 0.25pi], 0);

	Out.ar(out, sig)
}).add;

SynthDef(\stationPositionToQuad, {
	|out=0, amp=0.1, angle=0, dist=0, maxd=100, mind=1, in=200|
	// var angleIn = 271; // testing
	// var inTest = WhiteNoise.ar(0.1);
	var di = dist.linlin(mind,maxd,0,4);
	var lev = amp;
	var radians = angle * (pi / 180);
	var yP = di * radians.cos;
	var xP = di * radians.sin;
	var w, x, y, z;
	var inSig = In.ar(in);
	var sig;

	#w, x, y, z = BFEncode2.ar(inSig, xP, yP, 0, lev, 0);
    //decode for 4 channels
	sig = BFDecode1.ar(w, x, y, z, [1.75pi, 0.25pi, 0.75pi, 1.25pi], 0);

	Out.ar(out, sig)
}).add;


SynthDef(\stationPositionToSurround, {
	|out=0, amp=0.1, angle=0, dist=0, maxd=100, mind=1, in=200|
	// var angleIn = 271; // testing
	// var inTest = WhiteNoise.ar(0.1);
	var di = dist.linlin(mind,maxd,0,4);
	var lev = amp;
	var radians = angle * (pi / 180);
	var yP = di * radians.cos;
	var xP = di * radians.sin;
	var w, x, y, z;
	var inSig = In.ar(in);
	var sig1, sig2, sig3, sig4, sig5;

	#w, x, y, z = BFEncode2.ar(inSig, xP, yP, 0, lev, 0);
    //decode for 4 channels
	#sig1,sig2,sig3,sig4,sig5 = BFDecode1.ar(w, x, y, z, [1.75pi, 0.25pi, 1pi, 1.25pi, 0.75pi], 0);

	Out.ar(out  , sig1);
	Out.ar(out+1, sig2);
	Out.ar(out+2, sig3);
	Out.ar(out+4, sig4);
	Out.ar(out+5, sig5);
}).add;

(
~initStationNIL = {
	| space, minDist, maxDist, in, mainOut |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToNIL,
			[\out,mainOut, \amp,0.25, \angle,ang, \dist,dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)];

};

~initStationsNIL = { | spaces, mainOut |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationNIL.(item, min, max, (200+(iter)), mainOut )})
};

~initStationStereo = {
	| space, minDist, maxDist, in, mainOut |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToStereo,
			[\out,mainOut, \amp,(-3).dbamp, \angle, ang, \dist, dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)]
};

~initStationsStereo = { | spaces, mainOut |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationStereo.(item, min, max, (200+(iter)), mainOut )})
};

~initStationQuad = {
	| space, minDist, maxDist, in |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToQuad,
			[\out,0, \amp,(-4.5).dbamp, \angle, ang, \dist, dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)]
};

~initStationsQuad = { | spaces |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationQuad.(item, min, max, (200+(iter)) )})
};

~initStationSurround = {
	| space, minDist, maxDist, in |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToSurround,
			[\out,0, \amp,(-4.5).dbamp, \angle, ang, \dist, dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)];

};

~initStationsSurround = { | spaces |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationSurround.(item, min, max, (200+(iter)) )})
};
);

"spatialisation loaded!".postln;