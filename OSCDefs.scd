
OSCdef(\earthquake,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="sonify", {
		var stations = ["aovm","bjvm","cjvm","covm","ctvm","mhvm","mpvm","thvm","tlvm","vrvm"];
		var bands = [1,2,3,4];

		stations.collect({|station|
			bands.collect({|band|
				Synth((station++band).asSymbol);
				(station++band).postln

			});
		});
	});
},"/play2");


OSCdef(\1985,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="1985", {
		if( ~stereo,
			{~eightyFive = Synth(\1985 ++ ("Stereo"), [\out, ~mainOut])}, ///// main out should be declared before turning on MAIN!
		{~eightyFive = Synth(\1985)})
	});
},"/play2");

OSCdef(\cosmos,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="cosmos", {
		if( ~stereo,
			{~cosmos = Synth(\cosmos ++ ("Stereo"), [\out, ~mainOut], addAction: 'addToTail');
				"cosmosStereo".postln},
			{~cosmos = Synth(\cosmos, addAction: 'addToTail');
				"cosmosNIL".postln})
	});
},"/play2");


OSCdef(\cosmosoff,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="cosmosoff", {
		~cosmos.set(\gate, 0);
		"cosmosOFF".postln;
	});
},"/play2");


OSCdef(\2017,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="2017", {
		Tdef(\earthquakeEvent).play
	});
},"/play2");


// OSCdef(\testy,{
// 	|msg,time,addr,recvPort|
// 	msg.postln;
// },"/play2");
