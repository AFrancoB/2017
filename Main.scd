(
var path = thisProcess.nowExecutingPath.dirname;
var coords = path ++ "/coordinates.scd";
var spatialisation = path ++ "/earthquakeSpatialisation.scd";
var synths = path ++ "/Synths.sc";
var data = path ++ "/dataProcessing.scd";
var stationSynths = path ++ "/stationSynths.scd";
var oscDefs = path ++ "/OSCDefs.scd";

s.options.numBuffers = 1024 * 256;
Server.default.options.memSize= 512000*20;
Server.default.options.maxNodes=128*1024;
Server.default.options.numWireBufs= 512;

// Server.default.options.device = "ASIO : MOTU Pro Audio";
// Server.default.options.device = "ASIO : Realtek ASIO";
Server.default.options.numOutputBusChannels = 40;
Server.default.options.sampleRate = 48000;

s.waitForBoot {
	~dirt = SuperDirt(8, s);
	~dirt.loadSoundFiles;
	~dirt.start(57120, 200 ! 2);
	coords.load;
	spatialisation.load;
	oscDefs.load;
	synths.load;
	data.load;
};
s.latency = 0.3;
);

