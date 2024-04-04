(
var path = thisProcess.nowExecutingPath.dirname;
var coords = path ++ "/coordinates.scd";
var spatialisation = path ++ "/earthquakeSpatialisation.scd";
var synths = path ++ "/Synths.sc";
var ensemble = path ++ "ensembleOutputs.scd";
var data = path ++ "/dataProcessing.scd";
var stationSynths = path ++ "/stationSynths.scd";
var oscDefs = path ++ "/OSCDefs.scd";
var earthquakeEvent = path ++ "/earthquakeEvent2017.scd";

s.options.numBuffers = 1024 * 256;
Server.default.options.memSize= 512000*20;
Server.default.options.maxNodes=128*1024;
Server.default.options.numWireBufs= 512;

// Server.default.options.device = "ASIO : MOTU Pro Audio";

// add here your interface

Server.default.options.numOutputBusChannels = 26;
Server.default.options.sampleRate = 48000;

s.waitForBoot {
	~dirt = SuperDirt(4, s); // quadra and stereo only floor bus works
	// ~dirt = SuperDirt(8, s); // octa and NIL
	~dirt.loadSoundFiles;
	~dirt.loadSoundFiles(path ++ "/agua/primeradeclaracionEZLN/");
	~dirt.loadSoundFiles(path ++ "/agua/ayotzinapa2015/");
	~dirt.loadSoundFiles(path ++ "/agua/madrid2016/");
	~dirt.loadSoundFiles(path ++ "/agua/chile2019/");
	~dirt.loadSoundFiles(path ++ "/agua/berlinmayday2023/");
	~dirt.loadSoundFiles(path ++ "/agua/hamilton2024/");
	~dirt.start(57120, [100,108,116]); ////// 100 = floor, 108 = middle and 116 = ceiling
	coords.load;
	spatialisation.load;
	oscDefs.load;
	ensemble.load;
	synths.load;
	earthquakeEvent.load;
	data.load;
};
s.latency = 0.3;
);
