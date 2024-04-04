///////******* THIS NEEDS TO BE ACTIVATED FOR PERFORMANCE    ********//////////
// CHOOSE BETWEEN STEREO, QUAD OR NIL CONFIGURATIONS OUTPUTS


////////////////// sugerido para estereo:
(
/////////////////// *********** ensamble ********* ////////////
~outputPiraran = Synth(\stereoPiraran);

/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisStereo);

/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsStereo.(~coordinates);

~headphones = False; // si vas a tocar con audifonos (no se recomienda) cambia esto a True
)


////////////////// sugerido para cuadra
(
/////////////////// *********** ensamble ********* ////////////
~outputPiraran = Synth(\quadraPiraran);

/////////////////// *********** eveneto sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisQuad);

/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsQuad.(~coordinates);

~headphones = False; // esto debe estar en falso
)

(
// volume down in all output synths of sonification
var vol = -3; // vol in dBs
~outputStations.collect({|item| item[1].set(\amp, vol.dbamp )})
)










(
///////******* THIS NEEDS TO BE ACTIVATED FOR PERFORMANCE    ********//////////
// CHOOSE BETWEEN STEREO, QUAD OR NIL CONFIGURATIONS OUTPUTS

/////////////////// *********** earthquake event ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisQuad);

~outputFallAndDebris = Synth(\fallAndDebrisStereo);

/////////////////// *********** earthquake sonification ********* ////////////

~outputStations = ~initStationsQuad.(~coordinates);

~outputStations = ~initStationsStereo.(~coordinates);
// ~output = ~initStationsNIL.(~coordinates); // if you are at the NIL


~headphones = False; // if playing with headphones (not recommended, change this to True

)


//////// helpful stuff ///////////

(
// volume down in all output synths of sonification
var vol = -3; // vol in dBs
~outputStations.collect({|item| item[1].set(\amp, vol.dbamp )})
)




//////// testing:
( // play sonification locally (use estuary, superdirtsocket, superdirtlistener to network the event)
~dataToSonify.collect({|station|
	station.collect({|b|
		Synth((b.station++b.band).asSymbol)

	})
})
);

Tdef(\earthquakeEvent).play // locally test earthquake event






/// check buffers of wavetable:
~waveArray[0][0].bufnum


~output[0] // an array with a 'tuplet' (two slot array): a spatial relationship between a seismic station and one of the three representative places of the earthquake, in the second index: the synth that controls its emitting position.

~output[0][1] // seismic station's position Alvaro Obregon of the seismic network of the Valley of Mexico in relationship with the INPI 