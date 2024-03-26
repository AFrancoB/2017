
var findMax = { | arrayObject |
	var ns = arrayObject.collect {|item|  item.ns};
	var v = arrayObject.collect {|item|  item.v};
	var eo = arrayObject.collect {|item|  item.eo};

	var nsMax = if(ns.maxItem > (ns.minItem*(-1)),
		{ns.maxItem}, {ns.minItem*(-1)});

	var vMax = if(v.maxItem > (v.minItem*(-1)),
		{v.maxItem}, {v.minItem*(-1)});

	var eoMax = if(eo.maxItem > (eo.minItem*(-1)),
		{eo.maxItem}, {eo.minItem*(-1)});

	(nsMax: nsMax, vMax: vMax, eoMax: eoMax)

};


~dataToSonify.collect({|stat, iter|
	stat.collect({|b|
		var data = b.data; var station = b.station; var band = b.band;
		var ranges = findMax.(data); var out = 200 + (iter*3);
		// ~continuum.(d, 200 + (iter*3), ~findMax.(d), b, stat)

		SynthDef((station++band).asSymbol, { |vol=1|
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

			var freq = EnvGen.kr(Env(ns,[res]),doneAction:2);
			var amp = EnvGen.kr(Env(v,[res]));
			var w = EnvGen.kr(Env(eo,[res]));
			var pos = EnvGen.kr(Env(p, [res]));
			var cut = EnvGen.kr(Env(c, [res]));
			var rin = EnvGen.kr(Env(r, [res]));

			Out.ar(out,
				PanX.ar(3,
					CombC.ar(RLPF.ar(VOsc.ar((timbre+2017) + w, freq, mul: amp),cut,1),0.2, rin, 0.2),
					pos
				)*vol;
			)



		}).add
	})

})



