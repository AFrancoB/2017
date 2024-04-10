var getRickerWavelets = { | stationInput |
	var path = thisProcess.nowExecutingPath.dirname;
	var waveletshape = path ++ "/Datos-Ricker/";
	var station = waveletshape ++ stationInput;
	var channels = [(path: "/esteOeste/", short: "estOest"),(path: "/norteSur/", short: "norSur"),(path: "/vertical/", short: "vertical")];
	var bands = ["uno","dos","tres","cuatro","cinco"];

	var bandStat = bands.collect({|i| i ++ stationInput.toUpper });
	var filePaths = bandStat.collect({|bandStation|
		var bandString = bandStation[0..(bandStation.size-5)];
		var band =
		switch (bandString,
			"uno", 1,
			"dos", 2,
			"tres", 3,
			"cuatro", 4,
			"cinco", 5
		);

		channels.collect({|channel|
			(
				band: band,
				channel: channel.short,
				path: station ++ channel.path ++
				bandStation ++ channel.short ++ ".txt"
			)
		})
	}).flat;

	var files = filePaths.collect({|file|
		(
			band: file.band,
			channel: file.channel,
			file: CSVFileReader.read(file.path)[0]
		)
	});

	// output:
	// (band: int, channel: string, data: [float] )
	files.collect({|f|
		var data = f.file.collect({|item|
				item.asString
				.replace("[","")
				.replace("]","")
				.asFloat*0.000040});

		(band: f.band, channel: f.channel, data: data)
	})


};

var getEastWestBands = { | stationData |
	stationData.select({|item| item.channel== "estOest"    })
};

var getNorthSouthBands = { | stationData |
	stationData.select({|item| item.channel== "norSur"    })
};

var getVerticalBands = { | stationData |
	stationData.select({|item| item.channel== "vertical"    })
};

var getBand = { |band, stationData|
	stationData.select {|x| x.band == band } ;
};

var getStationData = { | stationID, data |
	data.select({|item|  item.station==stationID})};

var stationIDs = ["aovm","bjvm","cjvm","covm","ctvm","mhvm","mpvm","thvm","tlvm","vrvm"];

// this data is usable already
var data = stationIDs.collect({|item|
	var data = getRickerWavelets.( item);

	data.collect({|x|
		(station: item, channel: x.channel,
			band: x.band, data: x.data)   })
}).flat;

// merges per band and station
var mergeChannelsOfStation = { | band, station, data |
	var bandFromStation = getBand.(band, getStationData.(station,data));

	var estOestD = bandFromStation.select({|item| item.channel == "estOest" })[0].data;
	var norSurD = bandFromStation.select({|item| item.channel == "norSur" })[0].data;
	var verticalD = bandFromStation.select({|item| item.channel == "vertical" })[0].data;

	var processedData =
	if((estOestD.size == norSurD.size) && (estOestD.size == verticalD.size), {
		estOestD.collect {|item, iter|
			(v: verticalD[iter], ns: norSurD[iter], eo: item)
		};
	},
	{"not the same bands probably".error});

	(station: station, band: band, data: processedData)
};

// ready for scheduling as audio
var mergedData = stationIDs.collect({|station|
	var bands = [1,2,3,4];

	bands.collect {|band|
		mergeChannelsOfStation.(band, station, data)
	}
});

// making the data playable by SC
var downSampling = { | mergedData|
	mergedData.collect { |station|
		station.collect { |band|

			// take every 10th sample;

			var downSampledData = band.data.select {|item, index|   index%10 == 0  };

			// take the first 5:50 mins of the time series
			downSampledData = downSampledData[0..((downSampledData.size-1)/2).asInteger];

			(station: band.station, band: band.band, data: downSampledData)
		};
	};
};


var dataToSonify = downSampling.(mergedData);

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

dataToSonify.collect({|stat, iter|
	stat.collect({|b|
		var data = b.data; var station = b.station; var band = b.band;
		var ranges = findMax.(data); var out = 200 + (iter*3);
		// ~continuum.(d, 200 + (iter*3), ~findMax.(d), b, stat)

		SynthDef((station++band).asSymbol, { |vol=0.5|
			var vMax = ranges.vMax;
			var nsMax = ranges.nsMax;
			var eoMax = ranges.eoMax;

			var res = switch(band, 4, 1.6, 3, 0.8, 2, 0.4, 1, 0.2);

			var timbre = switch(station, "aovm", 100, "bjvm", 200, "cjvm", 300, "covm", 400, "ctvm", 500,
				"mhvm", 600, "mpvm", 700, "thvm", 800, "tlvm", 900, "vrvm", 1000);

			var ns = data.collect({|item| item.ns.fold(0,nsMax).linexp(0,nsMax, 30/res, 800/res)});
			var v = data.collect({|item| item.v.fold(0,vMax).linlin(0,vMax, (-35).dbamp, (-12).dbamp)});
			var eo = data.collect({|item| item.eo.linlin((eoMax*(-1)),eoMax, 0, 100)   });

			var p = data.collect({|item| item.eo.linlin((eoMax*(-1)),eoMax, 0,1)  });
			var c = data.collect({|item| item.ns.fold(0,nsMax).linexp(0,nsMax, 3000*res, 6000*res)});
			var r = data.collect({|item| item.v.fold(0,vMax).linlin(0,vMax, 0.01, 0.001)});

			var d = data.collect({|item| item.eo.linlin((eoMax*(-1)),eoMax, 0.1,0.5)});


			var freq = EnvGen.kr(Env(ns,[res]),doneAction:2);
			var amp = EnvGen.kr(Env(v,[res]));
			var w = EnvGen.kr(Env(eo,[res]));
			var pos = EnvGen.kr(Env(p, [res]));
			var cut = EnvGen.kr(Env(c, [res]));
			var rin = EnvGen.kr(Env(r, [res]));
			var dec = EnvGen.kr(Env(d, [res]));

			Out.ar(out,
				Compander.ar(PanX.ar(3,
					CombC.ar(
						RLPF.ar(
							VOsc.ar((timbre+2031) + w, freq, mul: amp) ///// first buffer hardcoded, WARNING!!!!!!!
							,cut,1)
						,0.2, rin, dec),
					pos, vol
				),
				WhiteNoise.ar(0.5),0.5)
			)
		}).add
	})
});

("sonified data" + dataToSonify).postln;

~dataToSonify = dataToSonify;

