// to do:

// 1. make the three channel event list per station:
// (station: string, band: int, [(v: float, ns: float, ew: float)]) [DONE]

// 2. collect all stations with all bands ::[[event]] [DONE]

// 3. get a scheduler that can play the 4 bands simultaneously {DONE}

// 4. Downsample from 100 per second to 10 per second {DONE}

// 5. Describe the three channel event in terms of sound (continuous or discrete approach) [DONE]

// 6. Play all stations and all bands at the same time. [DONE]

//// at last, now adapt to the 30 audio channels from spatialisation
/////// also: each station should have a different set of waveshapes. Adapt the collect below to achieve that
///////// add a fade in and fade out to continuum. Probably I only need the first five minutes... so make a partition of the data from the first five mintues to the last five. This sonification uses the first five, the last six maybe should be percusive attacks elongated as a base for the performance
(
~stations = ~initStationsNIL.(~coordinates);
~dataToSonify.collect({|station, iter|
	station.collect({|band|
		var d = band.data; var stat = band.station; var b = band.band;
		~continuum.(d, 200 + (iter*3), ~findMax.(d), b, stat)
	})

})
)

s.meter

(
// hardcoded
~stations = ~initStationsStereo.(~coordinates);
~continuum.( ~dataToSonify[0][3].data, 200, ~findMax.(~dataToSonify[0][3].data), ~dataToSonify[0][3].band, ~dataToSonify[0][3].station);
~continuum.( ~dataToSonify[0][2].data, 200, ~findMax.(~dataToSonify[0][2].data), ~dataToSonify[0][2].band, ~dataToSonify[0][2].station);
~continuum.( ~dataToSonify[0][1].data, 200, ~findMax.(~dataToSonify[0][1].data), ~dataToSonify[0][1].band, ~dataToSonify[0][1].station);
~continuum.( ~dataToSonify[0][0].data, 200, ~findMax.(~dataToSonify[0][0].data), ~dataToSonify[0][0].band, ~dataToSonify[0][0].station);
~continuum.( ~dataToSonify[1][3].data, 200, ~findMax.(~dataToSonify[1][3].data), ~dataToSonify[1][3].band, ~dataToSonify[1][3].station);
~continuum.( ~dataToSonify[1][2].data, 200, ~findMax.(~dataToSonify[1][2].data), ~dataToSonify[1][2].band, ~dataToSonify[1][2].station);
~continuum.( ~dataToSonify[1][1].data, 200, ~findMax.(~dataToSonify[1][1].data), ~dataToSonify[1][1].band, ~dataToSonify[1][1].station);
~continuum.( ~dataToSonify[1][0].data, 200, ~findMax.(~dataToSonify[1][0].data), ~dataToSonify[1][0].band, ~dataToSonify[1][3].station);
~continuum.( ~dataToSonify[2][3].data, 200, ~findMax.(~dataToSonify[2][3].data), ~dataToSonify[2][3].band, ~dataToSonify[2][3].station);
~continuum.( ~dataToSonify[2][2].data, 200, ~findMax.(~dataToSonify[2][2].data), ~dataToSonify[2][2].band, ~dataToSonify[2][2].station);
~continuum.( ~dataToSonify[2][1].data, 200, ~findMax.(~dataToSonify[2][1].data), ~dataToSonify[2][1].band, ~dataToSonify[2][1].station);
~continuum.( ~dataToSonify[2][0].data, 200, ~findMax.(~dataToSonify[2][0].data), ~dataToSonify[2][0].band, ~dataToSonify[2][0].station);
~continuum.( ~dataToSonify[3][3].data, 200, ~findMax.(~dataToSonify[3][3].data), ~dataToSonify[3][3].band, ~dataToSonify[3][3].station);
~continuum.( ~dataToSonify[3][2].data, 200, ~findMax.(~dataToSonify[3][2].data), ~dataToSonify[3][2].band, ~dataToSonify[3][2].station);
~continuum.( ~dataToSonify[3][1].data, 200, ~findMax.(~dataToSonify[3][1].data), ~dataToSonify[3][1].band, ~dataToSonify[3][1].station);
~continuum.( ~dataToSonify[3][0].data, 200, ~findMax.(~dataToSonify[3][0].data), ~dataToSonify[3][0].band, ~dataToSonify[3][0].station);

~continuum.( ~dataToSonify[4][3].data, 200, ~findMax.(~dataToSonify[4][3].data), ~dataToSonify[4][3].band, ~dataToSonify[4][3].station);
~continuum.( ~dataToSonify[4][2].data, 200, ~findMax.(~dataToSonify[4][2].data), ~dataToSonify[4][2].band, ~dataToSonify[4][2].station);
~continuum.( ~dataToSonify[4][1].data, 200, ~findMax.(~dataToSonify[4][1].data), ~dataToSonify[4][1].band, ~dataToSonify[4][1].station);
~continuum.( ~dataToSonify[4][0].data, 200, ~findMax.(~dataToSonify[4][0].data), ~dataToSonify[4][0].band, ~dataToSonify[4][0].station);
~continuum.( ~dataToSonify[5][3].data, 200, ~findMax.(~dataToSonify[5][3].data), ~dataToSonify[5][3].band, ~dataToSonify[5][3].station);
~continuum.( ~dataToSonify[5][2].data, 200, ~findMax.(~dataToSonify[5][2].data), ~dataToSonify[5][2].band, ~dataToSonify[5][2].station);
~continuum.( ~dataToSonify[5][1].data, 200, ~findMax.(~dataToSonify[5][1].data), ~dataToSonify[5][1].band, ~dataToSonify[5][1].station);
~continuum.( ~dataToSonify[5][0].data, 200, ~findMax.(~dataToSonify[5][0].data), ~dataToSonify[5][0].band, ~dataToSonify[5][3].station);
~continuum.( ~dataToSonify[6][3].data, 200, ~findMax.(~dataToSonify[6][3].data), ~dataToSonify[6][3].band, ~dataToSonify[6][3].station);
~continuum.( ~dataToSonify[6][2].data, 200, ~findMax.(~dataToSonify[6][2].data), ~dataToSonify[6][2].band, ~dataToSonify[6][2].station);
~continuum.( ~dataToSonify[6][1].data, 200, ~findMax.(~dataToSonify[6][1].data), ~dataToSonify[6][1].band, ~dataToSonify[6][1].station);
~continuum.( ~dataToSonify[6][0].data, 200, ~findMax.(~dataToSonify[6][0].data), ~dataToSonify[6][0].band, ~dataToSonify[6][0].station);
~continuum.( ~dataToSonify[7][3].data, 200, ~findMax.(~dataToSonify[7][3].data), ~dataToSonify[7][3].band, ~dataToSonify[7][3].station);
~continuum.( ~dataToSonify[7][2].data, 200, ~findMax.(~dataToSonify[7][2].data), ~dataToSonify[7][2].band, ~dataToSonify[7][2].station);
~continuum.( ~dataToSonify[7][1].data, 200, ~findMax.(~dataToSonify[7][1].data), ~dataToSonify[7][1].band, ~dataToSonify[7][1].station);
~continuum.( ~dataToSonify[7][0].data, 200, ~findMax.(~dataToSonify[7][0].data), ~dataToSonify[7][0].band, ~dataToSonify[7][0].station);

~continuum.( ~dataToSonify[8][3].data, 200, ~findMax.(~dataToSonify[8][3].data), ~dataToSonify[8][3].band, ~dataToSonify[8][3].station);
~continuum.( ~dataToSonify[8][2].data, 200, ~findMax.(~dataToSonify[8][2].data), ~dataToSonify[8][2].band, ~dataToSonify[8][2].station);
~continuum.( ~dataToSonify[8][1].data, 200, ~findMax.(~dataToSonify[8][1].data), ~dataToSonify[8][1].band, ~dataToSonify[8][1].station);
~continuum.( ~dataToSonify[8][0].data, 200, ~findMax.(~dataToSonify[8][0].data), ~dataToSonify[8][0].band, ~dataToSonify[8][0].station);
~continuum.( ~dataToSonify[9][3].data, 200, ~findMax.(~dataToSonify[9][3].data), ~dataToSonify[9][3].band, ~dataToSonify[9][3].station);
~continuum.( ~dataToSonify[9][2].data, 200, ~findMax.(~dataToSonify[9][2].data), ~dataToSonify[9][2].band, ~dataToSonify[9][2].station);
~continuum.( ~dataToSonify[9][1].data, 200, ~findMax.(~dataToSonify[9][1].data), ~dataToSonify[9][1].band, ~dataToSonify[9][1].station);
~continuum.( ~dataToSonify[9][0].data, 200, ~findMax.(~dataToSonify[9][0].data), ~dataToSonify[9][0].band, ~dataToSonify[9][0].station);
)

3000*1.6
~stationID

(

~continuum = { | data , out, ranges, band, station |
	var vMax = ranges.vMax;
	var nsMax = ranges.nsMax;
	var eoMax = ranges.eoMax;

	var res = switch(band, 4, 1.6, 3, 0.8, 2, 0.4, 1, 0.2);

	var timbre = switch(station, "aovm", 100, "bjvm", 200, "cjvm", 300, "covm", 400, "ctvm", 500,
		"mhvm", 600, "mpvm", 700, "thvm", 800, "tlvm", 900, "vrvm", 1000);

	var ns = data.collect({|item| item.ns.fold(0,nsMax).linexp(0,nsMax, 30/res, 800/res)});
	var v = data.collect({|item| item.v.fold(0,vMax).linlin(0,vMax, (-36).dbamp, 1)});
	var eo = data.collect({|item| item.eo.linlin((eoMax*(-1)),eoMax, 0, 100)   });

	var p = data.collect({|item| item.eo.linlin((eoMax*(-1)),eoMax, 0,1)  });
	var c = data.collect({|item| item.ns.fold(0,nsMax).linexp(0,nsMax, 3000*res, 6000*res)});
	var r = data.collect({|item| item.v.fold(0,vMax).linlin(0,vMax, 0.01, 0.001)});

	{
		var freq = EnvGen.kr(Env(ns,[res]),doneAction:2);
		var amp = EnvGen.kr(Env(v,[res]));
		var w = EnvGen.kr(Env(eo,[res]));
		var pos = EnvGen.kr(Env(p, [res]));
		var cut = EnvGen.kr(Env(c, [res]));
		var rin = EnvGen.kr(Env(r, [res]));

		Out.ar(out,
			PanX.ar(3,
				CombC.ar(RLPF.ar(VOsc.ar(timbre + w, freq, mul: amp),cut,1),0.2, rin, 0.2),
				pos
			);
	)}.play
}
)

s.meter














( // scheduler per station
~scheduler = { |data, out|
	var ranges1 = ~findMax.(data[0].data); var ranges2 = ~findMax.(data[1].data);
	var ranges3 = ~findMax.(data[2].data); var ranges4 = ~findMax.(data[3].data);

	var data1 = data[0]; var data2 = data[1];
	var data3 = data[2]; var data4 = data[3];

	var repeats = data1.data.size -1;

	~time = 0;
	Tdef(((data[0].station.asString)).asSymbol, {
		repeats.do{ |h|
			2.do{ | ii |
				var i = ii+(h*2);
				("i: "++i ++ " time: " ++ ~time).postln;
				~eventToAudio.(data4.data[i], out + (h%3), ranges4,  data4.band, data4.station);
				2.do { | jj |
					var j = (jj+(i*2));
					("j: "++ j ++ " time: " ++ ~time).postln;
					~eventToAudio.(data3.data[j], out + (h%3), ranges3, data3.band, data3.station);
					2.do { | kk |
						var k = (kk+(jj+(i*2)*2));
						("k: "++ k ++ " time: " ++ ~time).postln;
						~eventToAudio.(data2.data[k], out + (h%3), ranges2, data2.band, data2.station);
						2.do { | ll |
							var l = (ll+(kk+(jj+(i*2)*2)*2));
							("l: "++ l ++ " time: " ++ ~time).postln;
							~eventToAudio.(data1.data[l], out + (h%3), ranges1, data1.band, data1.station);
							0.2.wait; // should be 0.2
							~time = ~time + 0.2;
						};
					};
				};
			};
		};
	}).play
}
)

(
~findMax = { | arrayObject |
	var ns = arrayObject.collect {|item|  item.ns};
	var v = arrayObject.collect {|item|  item.v};
	var eo = arrayObject.collect {|item|  item.eo};

	var nsMax = if(ns.maxItem > (ns.minItem*(-1)),
		{ns.maxItem}, {ns.minItem*(-1)});

	var vMax = if(v.maxItem > (v.minItem*(-1)),
		{v.maxItem}, {v.minItem*(-1)});

	var eoMax = if(eo.maxItem > (eo.minItem*(-1)),
		{eo.maxItem}, {eo.minItem*(-1)});

/*	("max NS " + ns.maxItem).postln;
	("min NS " + ns.minItem).postln;
	("max V " + v.maxItem).postln;
	("min V " + v.minItem).postln;
	("max EO " + eo.maxItem).postln;
	("min EO " + eo.minItem).postln;*/

	(nsMax: nsMax, vMax: vMax, eoMax: eoMax)

};
);

(
~eventToAudio = { | timePt, out, ranges, band, station |
	var vMax = ranges.vMax;
	var nsMax = ranges.nsMax;
	var eoMax = ranges.eoMax;



	// unipolar
	var vert = timePt.v.fold(0,vMax).linlin(0,vMax, 0, 1);
	var ns = timePt.ns.fold(0,nsMax).linlin(0,nsMax, 0, 1);
	var eo = timePt.ns.fold(0,eoMax).linlin(0,eoMax, 0, 1);
	// bipolar
	// var eo = timePt.eo.linlin(eoMax*(-1),eoMax,-1,1);

	var f = ns.linlin(0,1, 100,1200);
	var a = vert.linlin(0,1, 0.15,0.5);
	var c = eo.linlin(-1,1, 0, 1500);

	if ( ((f==0) && ((a==0)&&(c==0))), {}, {
	(instrument: \sonified, freq: f, amp: 0.1+a, wmin: c, wmax: c+10, out: out, att: 0.2, rel: 0.15, sus: 0.1).play
	})
};
);


(out:200).play
(
~stations = ~initStationsStereo.(~coordinates);
~continuum.(~data1[i], 200+(i*3), ~findMaxMin.(~data1[i]), 8);

10.do {|i|
	~scheduler.(~dataToSonify[i],200)

};
)

s.meter

(

~continuum = { | timePt, out, ranges, band, station |
	var vMax = ranges.vMax;
	var nsMax = ranges.nsMax;
	var eoMax = ranges.eoMax;

	// unipolar
	var vert = timePt.v.fold(0,vMax).linlin(0,vMax, 0, 1);
	var ns = timePt.ns.fold(0,nsMax).linlin(0,nsMax, 0, 1);
	var eo = timePt.ns.fold(0,eoMax).linlin(0,eoMax, 0, 1);
	// bipolar
	// var eo = timePt.eo.linlin(eoMax*(-1),eoMax,-1,1);

	var f = ns.linlin(0,1, 100,2000);
	var a = vert.linlin(0,1, 0.15,0.5);
	var c = eo.linlin(-1,1, 0, 1500);


	{
		var freq = EnvGen.kr(Env(f,[1.6]),doneAction:2);
		var amp = EnvGen.kr(Env(a,[1.6]));
		var c = EnvGen.kr(Env(c,[1.6]));

		// var amp = EnvGen.kr(Env(a,[0.16/type]));

		Out.ar(out,
			VOsc.ar(c, freq,mul: amp);
	)}.play
}
)





// (station, band, data: [(v: dataPoint, ns: dataPoint, eo: dataPoint)])
~mergeChannelsOfStation.(1, "aovm", ~data)



Array


a[0]


a = ~getBand.( 1, ~getStationData.("aovm",~data))

b = ~getBand.( 2, ~getStationData.("aovm",~data))

c = ~getBand.( 3, ~getStationData.("aovm",~data))

d = ~getBand.( 4, ~getStationData.("aovm",~data))

a[0].data.detectIndex({|item| item != 0})

b[0].data.plot

c[0].data.plot

d[0].data.plot

ArrayedCollection
a[0].data

( // inspect the \labelAnchor of each DrawGridX
var plotter  = [
	a[0].data[((a[0].data.size*0.5).round)..10000],
	b[0].data[0..(b[0].data.size*0.5)],
	c[0].data[0..(c[0].data.size*0.5)],
	d[0].data[0..(d[0].data.size*0.5)]].plot;

plotter.plots.collect({ |plot|
    plot.drawGrid.x.labelAnchor
}).postln;
)


Plotter

(

(
~data1 = [~channelsObject.(~aovmV1,~aovmNS1,~aovmEO1), ~channelsObject.(~bjvmV1,~bjvmNS1,~bjvmEO1)]; // mas largo
~data2 = [~channelsObject.(~aovmV2,~aovmNS2,~aovmEO2), ~channelsObject.(~bjvmV2,~bjvmNS2,~bjvmEO2)];
~data3 = [~channelsObject.(~aovmV3,~aovmNS3,~aovmEO3), ~channelsObject.(~bjvmV3,~bjvmNS3,~bjvmEO3)];
~data4 = [~channelsObject.(~aovmV4,~aovmNS4,~aovmEO4), ~channelsObject.(~bjvmV4,~aovmNS4,~aovmEO4)]; // mas corto
);



~channelsObject = { |v, ns, eo|
	if (
		((v.size == ns.size) && (v.size == eo.size)), {
			v.collect({|item, i|
				(v: item, ns: ns[i], eo: eo[i]);
			})
		},

		{"not the same size".error}

	)
}
)

~data4[0].size
// this needs to take the different data points
(
~stations = ~initStationsNIL.(~coordinates);

2.do {|i|
	// ~data1[0].postln};
	// ~scheduler.(~data1[i],~data2[i],~data3[i],~data4[i], 200 + (i*3))

	~continuum.(~data1[i], 200+(i*3), ~findMaxMin.(~data1[i]), 8);
	~continuum.(~data2[i], 200+(i*3), ~findMaxMin.(~data2[i]), 4);
	~continuum.(~data3[i], 200+(i*3), ~findMaxMin.(~data3[i]), 2);
	~continuum.(~data4[i], 200+(i*3), ~findMaxMin.(~data4[i]), 1);

};
)


~data1[0].plot
~data1[1][2000]

(
~continuum = { | data, out, ranges, type |
	var v = data.collect {|item|  item.v };
	var ns = data.collect {|item|  item.ns };
	var eo = data.collect {|item|  item.eo };
	var mnV = ranges.minV;
	var mxV = ranges.maxV;
	var vMax = if(mxV > (mnV*(-1)), {mxV}, {mnV*(-1)});
	var mnNS = ranges.minNS;
	var mxNS = ranges.maxNS;
	var nsMax = if(mxNS > (mnNS*(-1)), {mxNS}, {mnNS*(-1)});
	var mnEO = ranges.minEO;
	var mxEO = ranges.maxEO;
	var eoMax = if(mxEO > (mnEO*(-1)), {mxEO}, {mnEO*(-1)});

	/*var f = v.linexp(0,vMax,(type*0.5)*500,type*500);
	var c = ns.linexp(0,nsMax, (type*0.5)*13,type*13);
	var p = eo.linlin(0,eoMax,0,1);

	var a = v.linexp(0,vMax, 0.0001, 0.6);
	var ln = ns.linexp(0,nsMax, (type*0.5)*0.3,type*0.3);
	var cf = ns.linexp(0,eoMax, 0.1,0.9);




	{
		var freq = EnvGen.kr(Env(f,[0.16/type]),doneAction:2);
		var ritm = EnvGen.kr(Env(c,[0.16/type]));
		var panx = EnvGen.kr(Env(p,[0.16/type]));

		var amp = EnvGen.kr(Env(a,[0.16/type]));

		Out.ar(out,
			PanX.ar(3,
				Pluck.ar(Pulse.ar(80),Impulse.kr(ritm),1, freq.reciprocal, 1.5, 0.2, (1/type)+amp)
				,
				panx, 1, 1
		)
	)}.play*/


	var f = v.linexp(0,vMax,(type*0.5)*300,type*300);
	var c = ns.linexp(0,nsMax, (type*0.5)*50,type*50);
	var p = eo.linlin(0,eoMax,0,1);

	var a = v.linexp(0,vMax, 0.0001, 0.6);




	{
		var freq = EnvGen.kr(Env(f,[0.16/type]),doneAction:2);
		var freq2 = EnvGen.kr(Env(c,[0.16/type]));
		var panx = EnvGen.kr(Env(p,[0.16/type]));

		var amp = EnvGen.kr(Env(a,[0.16/type]));

		Out.ar(out,
			PanX.ar(3,
				SinOsc.ar(SinOsc.kr(freq2,0,freq), 0 , (1/type)+amp),
				panx, 0.5, 1
		)
	)}.play
}
)



s.meter
(
~stations[0][1].set(\amp, 1, \angle, 180);
~stations[1][1].set(\amp, 1, \angle, 180);
~stations[2][1].set(\amp, 1, \angle, 180);
~stations[3][1].set(\amp, 1, \angle, 180);
~stations[4][1].set(\amp, 1, \angle, 180);
~stations[5][1].set(\amp, 1, \angle, 180);
)


(
Tdef(\pruebilla, {
	inf.do{ |iter|
		~stations[0][1].set(\amp, 0.5, \angle, iter.mod(360).postln);
		~stations[1][1].set(\amp, 0.5, \angle, iter.mod(260).postln);
		~stations[2][1].set(\amp, 0.5, \angle, iter.mod(160).postln);
		~stations[3][1].set(\amp, 0.5, \angle, iter.mod(200).postln);
		~stations[4][1].set(\amp, 0.5, \angle, iter.mod(300).postln);
		~stations[5][1].set(\amp, 0.5, \angle, iter.mod(120).postln);
		0.01.wait;
}}
).play
)

(
~scheduler = { |d1, d2, d3, d4, out|
	var rangesd1 = ~findMaxMin.(d1);
	var rangesd2 = ~findMaxMin.(d2);
	var rangesd3 = ~findMaxMin.(d3);
	var rangesd4 = ~findMaxMin.(d4);

	~time = 0;
	Tdef(\test++out, {
		 inf.do{ |h|
			2.do{ | ii |
				var i = ii+(h*2);
				// ("i: "++i ++ " time: " ++ ~time).postln;
				~objectToAudio.(d4[i], out + (h.mod(3)), rangesd4, 4);
				d4[i].postln;
				2.do { | jj |
					var j = (jj+(i*2));
					// ("j: "++ j ++ " time: " ++ ~time).postln;
					~objectToAudio.(d3[j], out, rangesd3, 3);
					2.do { | kk |
						var k = (kk+(jj+(i*2)*2));
						// ("k: "++ k ++ " time: " ++ ~time).postln;
						~objectToAudio.(d2[k], out, rangesd2, 2);
						2.do { | ll |
							var l = (ll+(kk+(jj+(i*2)*2)*2));
							// ("l: "++ l ++ " time: " ++ ~time).postln;
							~objectToAudio.(d1[l], out, rangesd1, 1);
							0.02.wait; // should be 0.1
							~time = ~time + 0.02;
						};
					};
				};
			};
		};
	}).play
}
)

~findMaxMin.(~data4[0])
(
~findMaxMin = { | arrayObject |
	var ns = arrayObject.collect {|item|  item.ns};
	var v = arrayObject.collect {|item|  item.v};
	var eo = arrayObject.collect {|item|  item.eo};

	("max NS " + ns.maxItem).postln;
	("min NS " + ns.minItem).postln;
	("max V " + v.maxItem).postln;
	("min V " + v.minItem).postln;
	("max EO " + eo.maxItem).postln;
	("min EO " + eo.minItem).postln;

	(maxV: v.maxItem, minV: v.minItem, maxNS: ns.maxItem, minNS: ns.minItem, maxEO: eo.maxItem, minEO: eo.minItem)

};
)

(
~objectToAudio = { | o, out, ranges, type |
	var mnV = ranges.minV;
	var mxV = ranges.maxV;
	var vMax = if(mxV > (mnV*(-1)), {mxV}, {mnV*(-1)});
	var mnNS = ranges.minNS;
	var mxNS = ranges.maxNS;
	var nsMax = if(mxNS > (mnNS*(-1)), {mxNS}, {mnNS*(-1)});
	var mnEO = ranges.minEO;
	var mxEO = ranges.maxEO;
	var eoMax = if(mxEO > (mnEO*(-1)), {mxEO}, {mnEO*(-1)});

	var f = o.v.linlin(0,vMax,30,10000/type);
	var a = o.ns.linlin(0,nsMax,0.5,1);
	var p = o.eo.linlin(mnEO,eoMax,-1,1);

	(instrument: \sinu, freq: f, amp: 1, pan: 0, out: out, att: 0.2, rel: 0.15, ln: 0.2).play
};
)

(instrument: \sinu, freq: 300, amp: 0.5, out: 0).play

~objectToAudio.(~data4[0], 0)

~findMaxMin

s.meter

(
SynthDef(\sinu, {
	|freq, pan, amp, att, ln, rel, out|
	var sig, env;
	sig = Saw.ar(freq, amp*0.5);
	sig = RLPF.ar(sig,freq*Line.kr(5,2,ln));
	env = EnvGen.kr(Env([0,0.5,0.8,0],[att,ln,rel]),doneAction:2);

	Out.ar(out,sig*env)
}).add
)

