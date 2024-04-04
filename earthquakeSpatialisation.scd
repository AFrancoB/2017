// this synthdefs transform a station position to a position in the NIL or in a stereo field


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


/*SynthDef(\stationPositionToNIL, {
	|out=0, amp=0.1, angle=0, dist=0, maxd=100, mind=1, in=200|
	var in1, in2, in3, in4, in5, in6, in7, in8;
	var out1,out2,out3,out4,out5,out6,out7,out8;
	var pos = (angle/360)*2;
	var lev = dist.linexp(mind,maxd,0.5,1);
	var w1,x1,y1,z1,w2,x2,y2,z2,w3,x3,y3,z3,w4,x4,y4,z4;
	var w5,x5,y5,z5,w6,x6,y6,z6,w7,x7,y7,z7,w8,x8,y8,z8;

	#in1,in2,in3,in4,in5,in6,in7,in8 =
	PanAz.ar(8,In.ar(in),pos,lev)*amp;
	// PanAz.ar(8,Saw.ar(1),LFSaw.ar(0.1)); // test with this

	// the panaz circle has translated cardinal points into abstract audio channels: 0 is north-northwest, 1 is north-northeast, 2 is east-northeast, 3 is east-southeast, 4 is south-southeast, 5 is south-southwest, 6 is west-southwest and 7 is west-northwest.
	// these abstract audio channels have to be modified so they respond to the following scheme:
	// (pos val 0) noroeste (in1 / in8) -> backright / rightback
	// (0.5) noroeste (in3 / in2) -> leftback / backleft
	// (1) sureste (in4 / in5) -> leftfront / frontleft
	// (1.5) suroeste (in7 / in6) -> rightfront / frontright
	/*
	noroeste: 4 leftback, 5 backleft    315 deg
	noreste:  7 rightback ,  6 backright    45 deg
	sureste:  1 frontleft  ,  8 leftfront   135 deg
	suroeste: 2 frontright, 3 rightfront  225 deg*/

	// this gets the degrees of a octophonic ring with a rotation of 1/16 of a circle and considering the weirdo Ambisonic coding/decoding parameter that goes from -0.5pi to 0.5pi
	//Array.series(8, 0,45).collect({ |item|  (item/360) -0.5 }).collect({|item| item + (1/16) }); get degree angles

	// encode a circular octophonic ring
	// frontleft
	#w1, x1, y1, z1 = BFEncode1.ar(in5, (-0.0625pi), (-0.15pi), 2);
	// frontright
	#w2, x2, y2, z2 = BFEncode1.ar(in6, (0.0625pi), (-0.15pi), 2);
	// leftfront
	#w3, x3, y3, z3 = BFEncode1.ar(in4, (-0.1875pi), (-0.15pi), 2);
	// rightfront
	#w4, x4, y4, z4 = BFEncode1.ar(in7, (0.1875pi), (-0.15pi), 2);
	// leftback
	#w5, x5, y5, z5 = BFEncode1.ar(in3, (-0.3125pi), (-0.15pi), 2);
	// rightback
	#w6, x6, y6, z6 = BFEncode1.ar(in8, (0.3125pi), (-0.15pi), 2);
	// backleft
	#w7, x7, y7, z7 = BFEncode1.ar(in2, (-0.4375pi), (-0.15pi), 2);
	// backright
	#w8, x8, y8, z8 = BFEncode1.ar(in1, (0.4375pi), (-0.15pi), 2);

    // B-format decode to NIL
    out1 = BFDecode1.ar1(w1, x1, y1, z1, nel, [-0.25pi],10,4);
    out2 = BFDecode1.ar1(w2, x2, y2, z2, nel, [-0.25pi],10,4);
    out3 = BFDecode1.ar1(w3, x3, y3, z3, nel, [-0.25pi],10,3.5);
    out4 = BFDecode1.ar1(w4, x4, y4, z4, nel, [-0.25pi],10,3.5);
    out5 = BFDecode1.ar1(w5, x5, y5, z5, nel, [-0.25pi],10,2.5);
    out6 = BFDecode1.ar1(w6, x6, y6, z6, nel, [-0.25pi],10,2.5);
    out7 = BFDecode1.ar1(w7, x7, y7, z7, nel, [-0.25pi],10,3);
    out8 = BFDecode1.ar1(w8, x8, y8, z8, nel, [-0.25pi],10,3);

	// Out.ar(out, out1 + out2 + out3 + out4 + out5 + out6 + out7 + out8)
	Out.ar(out, [in1, in2, in8, in3, in7, in4, in5, in6])


}).add;*/

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

(
/*~initStationNIL = {
	| space, minDist, maxDist, in |
	var name = space.name;
	var angle = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToNIL,
			[\out,0, \amp,1, \angle,angle, \dist,dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)]
};

~initStationsNIL = { | spaces |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationNIL.(item, min, max, (200+(iter)) )})
};*/

~initStationStereo = {
	| space, minDist, maxDist, in |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToStereo,
			[\out,0, \amp,(-18).dbamp, \angle, ang, \dist, dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)]
};

~initStationsStereo = { | spaces |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationStereo.(item, min, max, (200+(iter)) )})
};

~initStationQuad = {
	| space, minDist, maxDist, in |
	var name = space.name;
	var ang = angle.(space);
	var dist = space.distance;

	[name,
	 Synth(\stationPositionToQuad,
			[\out,0, \amp,(-3).dbamp, \angle, ang, \dist, dist, \maxd,maxDist, \mind,minDist, \in,in]
			,addAction: \addToTail)]
};

~initStationsQuad = { | spaces |
	var min = minMaxDist.( spaces).min;
	var max = minMaxDist.( spaces).max;

	spaces.collect({|item,iter| ~initStationQuad.(item, min, max, (200+(iter)) )})
};
);

"spatialisation loaded!".postln;