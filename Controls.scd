///////******* THIS NEEDS TO BE ACTIVATED FOR PERFORMANCE    ********//////////
(  ///// NIL SETTINGS !!!!
/////////////////// *********** ensamble ********* ////////////
~timekNot = Synth(\nilTimekNot, addAction: 'addToTail');

/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisNIL); // ready!!

s.volume = -6;

// ~timekNot.set(\vol, 0)

/*~timekNot.set(\vol, 1)
~cosmos.set(\vol, 0)*/
/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsNIL.(~coordinates);

)
~waveList.choose


(  ///// NEW STEREO SETTINGS !!!!
/////////////////// *********** ensamble ********* ////////////
~timekNot = Synth(\nilTimekNotToStereo,[\out, ~mainOut],  addAction: 'addToTail');

/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisStereo, [\out, ~outearthquakeEvent]);


/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsStereo.(~coordinates, ~outSonification);

)

//// USE THIS CODE TO FIX STEREO SIGNAL
//~stereoFromNilTimekNot.set(\makeUp, 2.25, \lim, (-20).dbamp, \thresh, 1/8)


// CHOOSE BETWEEN STEREO, QUAD OR NIL CONFIGURATIONS OUTPUTS

////////////////// sugerido para estereo:

(
/////////////////// *********** ensamble ********* ////////////
~outputPiraran = Synth(\quadToStereoPiraran, addAction: 'addToTail'); /////***** Esto en todos los de SuperDirt

/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisStereo);

/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsStereo.(~coordinates);

)



////////////////// sugerido para ArrayMusic
(
/////////////////// *********** ensamble ********* ////////////
~outputPiraran = Synth(\surroundPiraran, addAction: 'addToTail');

/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisSurround);


/////////////////// *********** sonificacion ********* ////////////
~outputStations = ~initStationsSurround.(~coordinates);

 // esto debe estar en falso
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


~headphones = false; // if playing with headphones (not recommended, change this to True

)


//////// helpful stuff ///////////

(
// volume down in all output synths of sonification
var vol = 3; // vol in dBs
~outputStations.collect({|item| item[1].set(\amp, vol.dbamp )})
)




//////// testing:
// test batimentos

( // play sonification locally (use estuary, superdirtsocket, superdirtlistener to network the event)
~dataToSonify.collect({|station|
	station.collect({|b|
		Synth((b.station++b.band).asSymbol)

	})
})
);

Tdef(\earthquakeEvent).play // locally test earthquake event

~eightyFive = Synth(\1985 ++ ("Stereo"), [\out, ~mainOut])

~eightyFive = Synth(\1985, [\gain, (6).dbamp])

~eightyFive.set(\gain, 2.2)

~cosmos = Synth(\cosmos ++ ("Stereo"), [\out, ~mainOut], addAction: 'addToTail');

s.meter



/// check buffers of wavetable:
~waveArray[0][0].bufnum


///// esto es para la sonificacion

~output[0] // an array with a 'tuplet' (two slot array): a spatial relationship between a seismic station and one of the three representative places of the earthquake, in the second index: the synth that controls its emitting position.

~output[0][1] // seismic station's position Alvaro Obregon of the seismic network of the Valley of Mexico in relationship with the INPI 