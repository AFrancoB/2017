///////******* THIS NEEDS TO BE ACTIVATED FOR PERFORMANCE    ********//////////

(
/////////////////// *********** ensamble ********* ////////////
~stereoFromNilTimekNot = Synth(\nilTimekNotToStereo, addAction: 'addToTail');
/////***** Esto en todos los de SuperDirt
// Pbind(\out, 116, \pan, Pseq([0,0.25,0.5,0.75,1,1.25,1.5,1.75],inf), \dur, 0.3, \instrument, \aguitar, \volume, (-15).dbamp, \note, Pseq([0,2,3,5,7,8,5,3],inf)).play;
/////////////////// *********** evento sismico ********* ////////////
~outputFallAndDebris = Synth(\fallAndDebrisNIL);

/////////////////// *********** sonificacion ********* ////////////
// ~outputStations = ~initStationsStereo.(~coordinates);

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

~eightyFive = Synth(\1985 ++ ("Headphones"))

~eightyFive = Synth(\1985)

~eightyFive.set(\gain, 2.2)

s.meter



/// check buffers of wavetable:
~waveArray[0][0].bufnum


///// esto es para la sonificacion

~output[0] // an array with a 'tuplet' (two slot array): a spatial relationship between a seismic station and one of the three representative places of the earthquake, in the second index: the synth that controls its emitting position.

~output[0][1] // seismic station's position Alvaro Obregon of the seismic network of the Valley of Mexico in relationship with the INPI 