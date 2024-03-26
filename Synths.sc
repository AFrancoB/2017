//Wavetable Synths for TidalCycles

// thinks to do:
////  add a vibrato: lfo to the sig of every synth but taking into consideration that any sig multiplied by 0 will make the synth be silent


//load wavetable catalogue;
var path = thisProcess.nowExecutingPath.dirname;
var waveShapeCatalogue = path++"/wavetable";
//catalogue taken from here: https://www.adventurekid.se/akrt/waveforms/
// open source and free for distribution
// adapted to SC in the sc mailing list (search for thread)


// test, the polled number should go from 100 to 200
/*(
var val= ~range.(100,200);
{SinOsc.kr(0.1,0,val.multi,val.addi).poll}.play
)*/

~waveArray = Array.new(44);

// this can be automatised so no manual input is necessary
~waveList = ["_aguitar","_altosax","_birds","_bitreduced","_blended","_bw_saw","_bw_sawbright","_bw_sawgap","_bw_sawrounded","_bw_sin","_bw_sq","_bw_sqrounded","_bw_tri","_c604","_cello","_clarinett","_clavinet","_dbass","_distorted","_ebass","_eguitar","_eorgan","_epiano","_flute","_fmsynth","_granular","_hdrawn","_hvoice","_oboe","_oscchip","_overtone","_piano","_pluckalgo","_raw","_sinharm","_snippets","_stereo","_stringbox","_symetric","_theremin","_vgame","_vgamebasic","_violin"];

(~waveList.size+1).do{|i|
	var akwf= "/AKWF", list= ~waveList;

//	(wavsCatalogue++akwf++list[i]++"/*").postln;
	if(i==0,
		{~waveArray.insert(i,SoundFile.collectIntoBuffers(waveShapeCatalogue++akwf++"/*"))},
		{~waveArray.insert(i,SoundFile.collectIntoBuffers(waveShapeCatalogue++akwf++list[i-1]++"/*",s))}
	);

};

~waveShapeList= ["_AKWF"]++~waveList;

~postOscs= ~waveShapeList.collect({|item|  item.postln; });

(
~osciladores = Dictionary.new;

~waveArray.size.do{|i|
	~osciladores.add(~waveShapeList[i].asSymbol ->
		(
			min: ~waveArray[i][0].bufnum,
			max: ~waveArray[i][~waveArray[i].size-1].bufnum)
	);
}
);

/*(// check all the ranges and the oscilators
~osciladores.size;
~waveArray.size.do{|i| ~osciladores.at(~waveShapeList[i].asSymbol).postln; ("synth" + ~waveShapeList[i][1..]).postln}
);*/

//////////
// Synthdefs

"synths loaded!".postln;
(
~waveShapeList.collect({|item|
	var name = item.asString[1..].toLower;
	var max = ~osciladores.at(item.asSymbol).max;
	var min = ~osciladores.at(item.asSymbol).min;

	SynthDef(name, {
		| out, sustain=1, freq=220, speed=1, begin=0, end=1, pan=0.5, accelerate=0, offset, volume=0.1, bufInter= 100, phase=1, wmin=0.1, wmax=0.15, att=0.01, rel=0.99|

		var minS = wmin.linlin(0,1,min,max);
		var maxS = wmax.linlin(0,1,min,max);
		var pitch = freq*speed;

		var env = EnvGen.ar(Env.pairs([[begin,0],[begin+0.0001,1],[end-0.0001,1],[end,0]]), timeScale: sustain, doneAction: Done.freeSelf);
		var env2 = EnvGen.ar(Env.perc(att,rel),timeScale:sustain);
		var sig= VOsc.ar(Line.kr(minS,maxS,sustain*bufInter), pitch,mul: volume);
		OffsetOut.ar(out,DirtPan.ar(sig*env2, ~dirt.numChannels, pan, env));
	}).add;
})
);

/*Synth(\AKWF, [\wmin, 0.55, \wmax, 0.6, \bufInter, 100])



(
// interpolation between waveshapes, 3 freqs at the same time
SynthDef(\wave, {
	| out, sustain=1, freq=440, speed=1, begin=0, end=1, pan=0.5, accelerate, offset, volume=0.1, bufInter= 20, phase=1, wmin=2050, wmax= 2080, dec=0.25, att=0.01, rel=0.99|
	var env = EnvGen.ar(Env.pairs([[0,1],[0.999,1],[1,0]]), timeScale: sustain, doneAction: Done.freeSelf);
	var env2 = EnvGen.ar(Env.perc(att,rel),timeScale:sustain);
	var sig= VOsc.ar(Line.kr(wmin,wmax,sustain*bufInter), freq,mul: volume);
    OffsetOut.ar(out,DirtPan.ar(sig*env2, ~dirt.numChannels, pan, env));
}).add;
);*/