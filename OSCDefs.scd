
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
		if( ~headphones,
			{~eightyFive = Synth(\1985 ++ ("Headphones"))},
			{~eightyFive = Synth(\1985)})
		});
},"/play2");


OSCdef(\2017,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="2017", {
		Tdef(\earthquakeEvent).play
		});
},"/play2");


OSCdef(\testy,{
	|msg,time,addr,recvPort|
	msg.postln;
},"/play2");
