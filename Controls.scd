// local stuff:

// one of these two needs to be turned one for you to get audio
//// this probably is for performers:
~output = ~initStationsStereo.(~coordinates); // if you are networked at home, maybe even with headphones

~output = ~initStationsNIL.(~coordinates); // if you are at the NIL

(
// volume down in all output synths
var vol = -3; // vol in dBs
~output.collect({|item| item[1].set(\amp, vol.dbamp )})
)






( // play earthquake locally (use estuary, superdirtsocket, superdirtlistener to network the event
~dataToSonify.collect({|station|
	station.collect({|b|
		Synth((b.station++b.band).asSymbol)

	})
})
);

~output[0] // an array with a 'tuplet' (two slot array): a spatial relationship between a seismic station and one of the three representative places of the earthquake, in the second index: the synth that controls its emitting position.

~output[0][0] // seismic station's position Alvaro Obregon of the seismic network of the Valley of Mexico in relationship with the INPI 