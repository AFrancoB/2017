


(
~rawNoise = FloatArray.fill(44100 * 5.0, {1.0.rand2}); // 5 seconds of noise
~noise = Buffer.loadCollection(s, ~rawNoise);
)

( // spatialisation arrangements
SynthDef(\fallAndDebris, {

	var fall = FreeVerb.ar(
		SinOsc.ar([50,Line.kr(60,50.01,70)],0,0.3) +
		RLPF.ar((
			PlayBuf.ar(1, ~noise,
			BufRateScale.kr(~noise)*
				SinOsc.kr(
				LFNoise2.kr(2,20,40),0,0.01,0.02), loop: 1) * 300).distort.distort*0.2,
		Line.kr(18000,100,50),1,0.5));
	var env = EnvGen.kr(Env([0,1,1,0],[0,80,10]),doneAction:2);

	var debris = Ringz.ar(
		Gendy3.ar(
			freq:LFNoise2.ar(6,9.5,10),
			mul:LFNoise2.kr(13,0.4,0.5)), 13, 0.01, 0.05).distort;
	var debrisEnv = EnvGen.kr(Env([0,1,1,0],[20,80,5]));

	Out.ar([0], fall * env);
	Out.ar([2,4,5,6], debris * debrisEnv)

}).add
)

Synth(\fallAndDebris)


(
SynthDef(\debris, { |out=0, amp=0.1|
	var sig, env;
	sig= Gendy3.ar(freq:LFNoise2.ar(6,9.5,10),mul:LFNoise2.kr(13,0.4,0.5));
	sig = Ringz.ar(sig, 13, 0.01, 0.05).distort;
	env= EnvGen.kr(Env.adsr(0.1,0.1,0.5,0.1),doneAction:2);

	Out.ar(out, sig*env*amp)
}).add
)

////// THIRD LAST
// building up... (this is the "panic" sound. or the sound of that event that cannot be grasped by the mind: the "other" bringing down a building
(
SynthDef(\terror, { |out=0 |
	var sig = BPF.ar(PlayBuf.ar(1,b,XLine.kr(0.00075,0.5,30)),Line.kr(1550,1300,60),LFNoise0.kr(1).range(0.01,0.5),5000).distort.distort*0.1;

	Out.ar(out, sig)

}).add
)

Synth(\terror)

{BPF.ar(PlayBuf.ar(1,b,XLine.kr(0.00075,0.5,30)),Line.kr(1550,1300,60),LFNoise0.kr(1).range(0.01,0.5),5000).distort.distort*0.1}.play

Tdef()


s.meter

// SECOND LAST
Synth(\debris)

//LAST
// pipes breaking gas leaking
{BPF.ar(WhiteNoise.ar(0.5),5000,0.1)}.play





