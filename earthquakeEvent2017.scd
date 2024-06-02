// earthquake event
var nel = [
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

SynthDef(\fallAndDebrisNIL, { | vol=1, out=0|
	var w,x,y,z, decoded;

	// #w,x,y,z = BFEncode2.ar(WhiteNoise.ar(0.5),0.2,1,0,1,0);
	#w,x,y,z = In.ar(300,4);

	decoded = BFDecode1.ar(w,x,y,z, nel[0], nel[1],0, (-0.5).dbamp);

	Out.ar(out, decoded*vol)
}).add;



SynthDef(\fallAndDebrisStereo, { | vol=1, out=0|
	var w,x,y,z, decoded;

	// #w,x,y,z = BFEncode2.ar(WhiteNoise.ar(0.5),0.2,1,0,1,0);
	#w,x,y,z = Compander.ar(In.ar(300,4),In.ar(300,4),0.5);

	decoded = BFDecode1.ar(w,x,y,z,[1.75pi,0.25pi]);

	Out.ar(out, decoded*vol)
}).add;

SynthDef(\fallAndDebrisSurround, { | vol=1, out=0|
	var w,x,y,z, out1, out2, out3, out4, out5;

	// #w,x,y,z = BFEncode2.ar(WhiteNoise.ar(0.5),0.2,1,0,1,0);
	#w,x,y,z = Compander.ar(In.ar(300,4),In.ar(300,4),0.5);

	#out1,out2,out3,out4,out5 = BFDecode1.ar(w,x,y,z,[1.75pi,0.25pi,1pi, 1.25pi, 0.75pi],0,0,(-3).dbamp);

	Out.ar(out  , out1*vol);
	Out.ar(out+1, out2*vol);
	Out.ar(out+2, out3*vol);
	Out.ar(out+4, out4*vol);
	Out.ar(out+5, out5*vol);
}).add;

SynthDef(\fallAndDebrisQuad, { | vol=1|
	var w,x,y,z, decoded;

	// #w,x,y,z = BFEncode2.ar(WhiteNoise.ar(0.5),0.2,1,0,1,0);
	#w,x,y,z = Compander.ar(In.ar(300,4),WhiteNoise.ar(0.5),0.5);

	decoded = BFDecode1.ar(w,x,y,z,[1.75pi,0.25pi, 1.25pi, 0.5pi],0,0,(-3).dbamp);

	Out.ar(0, decoded*vol)
}).add;

SynthDef(\impact, { | out=300, vol= 1, len=1.5|

	var envImpact1 = EnvGen.kr(Env([0,1,0.1,0],[0.0015,len,1.8]));
	var sigImpact1 = PinkNoise.ar(0.2)* envImpact1;
	var env = EnvGen.kr(Env([0,1,0.1,0],[0.001, len,2.8]),doneAction:2); // main env
	var sigImpact2 = BrownNoise.ar(0.25)* env;

	var sig1 = BFEncode1.ar(sigImpact1, LFSaw.kr(0.01),0,2,6);
	var sig2 = BFEncode1.ar(sigImpact2, LFSaw.kr(0.015),0,2,6);
	var sig3 = BFEncode1.ar(sigImpact1, LFSaw.kr(0.08),0,2,6);

	Out.ar(out, (sig1+sig2+sig3)*vol)


}).add;

SynthDef(\glass, {
	|freq=1200, amp=1, decRing=0.1, rel=0.3, out=300, which=0, elev=0, r=0, v=0|
	var sig, envSig, env, parciales, granulation, sigG, sigOut;
	parciales = Array.fill(25,{|i| i+rrand(-0.55,0.55)});
	sig = Mix(Ringz.ar(WhiteNoise.ar(0.01),freq*parciales*EnvGen.kr(Env([1,1.001],[0.1])),decRing));
	sig = CombC.ar(sig,1,LFNoise2.ar(0.001,0.01,0.025));
	envSig = EnvGen.kr(Env.perc(0.0001,rel));
	env = EnvGen.kr(Env([0,1,1,0],[0.001,rel*1.1,0.001]),doneAction:2);

	granulation= PitchShift.ar(sig*envSig,0.4,1.2,0.3,0.12)*10;
	sigG= Convolution.ar(granulation, WhiteNoise.ar(0.5), 512/8, 0.1);

	sigOut = BFEncode1.ar(SelectX.ar(which, [sigG*amp*(-6).dbamp, sig*envSig*amp]),r + LFSaw.kr(0.1),elev,2,1);

	Out.ar(out, sigOut )
}).add;

SynthDef(\panic, { | vol=1, out=300 |
	var env = EnvGen.kr(Env([0,1,1,0],[0.001,37,0.001]),doneAction:2);
	var sig = BPF.ar(
		PlayBuf.ar(1,~noiseGenBuffer,
			XLine.kr(0.00075,0.5,30)),
		Line.kr(1550,1300,60),
		LFNoise0.kr(1).range(0.01,0.5),5000).distort.distort*0.1;
	var yP1 = EnvGen.kr(Env([0,1.1,0.5,0.8,0.3,0.2,0.6,0.1,0.3,0],[7,7,7,7,2,2,1,2,2]));
	var xP1 = EnvGen.kr(Env([0,1.1,-1.5,0.8,-1.3,0,0.6,-0.7,0.5,0,-0.8,0],[7,7,7,4,3,2,2,2,1,1,1]));
	var elev1 = EnvGen.kr(Env([-0.5pi,0.25pi,-0.1pi,-0.25pi,0.5pi,-0.5pi],[5,5,5,15,7]));
	var sig1 = BFEncode2.ar( BPF.ar(sig, 350, 1, 2), xP1,yP1,elev1, (-9).dbamp, 1);
	var yP2 = EnvGen.kr(Env([0,1.1,0.5,0.8,0.1,-0.3,0.3,-0.2,0],[7,7,7,7,3,3,1,2]));
	var xP2 = EnvGen.kr(Env([0,-1.1,-1.5,0.8,-1.3,-0.9,0],[7,7,7,7,7,2]));
	var elev2 = EnvGen.kr(Env([-0.5pi,0.25pi,-0.1pi,-0.25pi,0.5pi,-0.5pi],[5,5,5,15,7]));
	var sig2 = BFEncode2.ar( BPF.ar(sig, 750, 1, 2), xP2,yP2,elev2, (-9).dbamp, 1);
	var yP3 = EnvGen.kr(Env([0,1.1,0.5,0.8,0.8,0.9,0],[7,7,7,7,5,4]));
	var xP3 = EnvGen.kr(Env([0,-1.1,-1.5,0.8,-1.3,-0.9,0],[7,7,7,7,7,2]));
	var elev3 = EnvGen.kr(Env([-0.5pi,0.25pi,-0.1pi,-0.25pi,0.5pi,-0.5pi],[5,5,5,15,7]));
	var sig3 = BFEncode2.ar( BPF.ar(sig, 1350, 1, 2), xP3,yP3,elev3, (-9).dbamp, 1);

	var yP4 = EnvGen.kr(Env([0,1.5,-1.5,1.8,-0.8,-1.2,0],[7,7,7,7,5,4]));
	var xP4 = EnvGen.kr(Env([0,-1.1,-1.5,0.8,-1.3,-0.4,0],[7,7,7,7,7,2]));
	var sig4 = BFEncode2.ar( RLPF.ar(sig, Line.kr(400,30,37), 1, 2), xP4,yP4, 0, (-12).dbamp, 1);
	var yP5 = EnvGen.kr(Env([0,1.5,-1.5,1.8,-0.8,-1.2,0],[7,7,7,7,5,4]));
	var xP5 = EnvGen.kr(Env([0,-1.1,-1.5,0.8,-1.3,-0.3,0],[7,7,7,7,7,2]));
	var sig5 = BFEncode2.ar( RHPF.ar(sig, Line.kr(2400,7500,37), 1, 2), xP5,yP5, 0, (-12).dbamp, 1);


	Out.ar(out, (sig1+sig2+sig3+sig4+sig5)*env);
}).add;

SynthDef(\fall, { | vol=1, out=300 |
	var sig = Mix(FreeVerb.ar(
		SinOsc.ar([50,Line.kr(60,50.01,30)],0,1) +
		RLPF.ar((PlayBuf.ar(1, ~noiseGenBuffer, BufRateScale.kr(~noiseGenBuffer)*
			SinOsc.kr(LFNoise2.kr(2,20,40),0,0.01,0.02), loop: 1) * 300).distort.distort*0.1, Line.kr(18000,10,30),1)));
	var env = EnvGen.kr(Env([0,0.25,0.25,0],[0.001,25,10]),doneAction:2);

	var sigOut = BFEncode2.ar(sig*env,Line.kr(-1pi,0pi,30),Line.kr(0pi,-1pi,30),Line.kr(0.5pi,-0.5pi,30),4);

	Out.ar(out, sigOut*vol)
}).add;

SynthDef(\debris, { | vol=1, out=300, xp=0, yp=0 |
	var sig = Ringz.ar(
		Gendy3.ar(
			freq:LFNoise2.ar(6,9.5,10),
			mul:LFNoise2.kr(13,0.4,0.5)), 13, 0.01, 0.075).distort;
	var env = EnvGen.kr(Env([0,1,1,0],[20,90,40]),doneAction:2);
	var sigOut = BFEncode2.ar(sig*env, xp + SinOsc.kr(0.1,0,0.1pi), yp + SinOsc.kr(0.15,0,0.1pi),-0.3,1);

	Out.ar(out, GVerb.ar(Compander.ar(sigOut, sigOut, 0.25, mul:0.3))*vol)
}).add;

Tdef(\glass1, {

	60.do{ |iter|
		var radio = iter.linlin(0,59,-0.2,0.2);
		Synth(\glass, [\freq, rrand(4500,7000), \which, rrand(0,0.5),
			\decRing, rrand(0.05,1.5),\rel, rrand(0.1,0.8),
			\amp, iter.linexp(0,59, (-4.5).dbamp, (-20).dbamp),
			\elev, iter.linlin(0,59, 0.5pi, -0.5pi),
			\r, radio + rrand(0,0.1)]);
		[0.01,0.07,0.05,0.005].choose.wait;
	};
});
Tdef(\glass2, {

	40.do{ |iter|
		var radio = iter.linlin(0,39,-0.2,0.2);
		Synth(\glass, [\freq, rrand(3500,5500), \which, rrand(0,0.5),
			\decRing, rrand(0.02,1.6),\rel, rrand(0.08,1.2),
			\amp, iter.linexp(0,39, (-9).dbamp, (-24).dbamp),
			\elev, iter.linlin(0,39, 0.5, -0.5),
			\r, radio + rrand(0,0.1)]);

		[0.01,0.07,0.1,0.15].choose.wait;
	};
});
Tdef(\glass3, {

	30.do{ |iter|
		var radio = iter.linlin(0,29,-0.2,0.2);
		Synth(\glass, [\freq, rrand(2000,4500), \which, rrand(0,0.5),
			\decRing, rrand(0.02,2),\rel, rrand(0.1,1.5),
			\amp, iter.linexp(0,29, (-12).dbamp, (-24).dbamp),
			\elev, iter.linlin(0,29, 0.5, -0.5),
			\r, radio + rrand(0,0.2)]);

		[0.2,0.08,0.1,0.15].choose.wait;
	};
});
Tdef(\glass4, {

	20.do{ |iter|
		var radio = iter.linlin(0,19,-0.2,0.2);
		Synth(\glass, [\freq, rrand(1000,2500), \which, rrand(0,0.5),
			\decRing, rrand(0.02,3),\rel, rrand(0.5,2.5),
			\amp, iter.linexp(0,19, (-12).dbamp, (-24).dbamp),
			\elev, iter.linlin(0,19, 0.5, -0.5),
			\r, radio + rrand(0,2)]);

		[0.2,0.8,0.1,0.35].choose.wait;
	};
	0.2.wait;
	1.do{
		Synth(\glass, [\freq, rrand(1000,2500), \which, rrand(0,0.5),
			\decRing, rrand(0.02,3),\rel, 25,
			\amp, (-18).dbamp, \r, rrand(0,2)]);

	}
});

Tdef(\earthquakeEvent, {
	1.do{
		// Synth(\fallAndDebrisQuad);
		Synth(\panic);
		37.wait;
	};
	3.do{ |n|
		n.postln;
		{Out.ar(300,SinOsc.ar([50,50.5],0,0.3)*Line.kr(0.85,0,4,doneAction:2))}.play;
		Synth(\impact, [\vol, (-4).dbamp, \len, 1.5*(n+1)]);
		Tdef(\glass1).play;
		0.1.wait;
		Tdef(\glass2).play;
		0.4.wait;
		Tdef(\glass3).play;
		2.wait;
		Tdef(\glass4).play;
		[1,1.5,2].choose.wait;
	};
	1.do{
		Synth(\fall);
		3.wait;
		~debris1 = Synth(\debris, [\xp, -2pi, \yp, -0.5pi]);
		~debris2 = Synth(\debris, [\xp, -3pi, \yp, 0.3pi]);
		~debris3 = Synth(\debris, [\xp, 1pi, \yp, -1.5pi]);
		~debris4 = Synth(\debris, [\xp, 1.3pi, \yp, 1.5pi]);
		~debris5 = Synth(\debris, [\xp, -1.5pi, \yp, -0.75pi]);
		~debris6 = Synth(\debris, [\xp, -0.2pi, \yp, -0.25pi]);
		~debris7 = Synth(\debris, [\xp, 3pi, \yp, 1.5pi]);

	};

});