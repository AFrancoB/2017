
OSCdef(\earthquake,{
	|msg,time,addr,recvPort|
	if(msg[2].asString=="sismo", {
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
