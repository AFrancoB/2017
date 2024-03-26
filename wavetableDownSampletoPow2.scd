(
var file, data, n, newData, outFile;

// 'protect' guarantees the file objects will be closed in case of error
protect {
        // Read original size of data
        file = SoundFile.openRead("... the path...");
        data = Signal.newClear(f.numFrames);
        file.readData(data);

        // Convert to n = some power of 2 samples.
        n = data.size.nextPowerOfTwo;
        newData = data.resamp1(n);

        // Convert the resampled signal into a Wavetable.
        // resamp1 outputs an Array, so we have to reconvert to Signal
        newData = newData.as(Signal).asWavetable;

        // Load this into a buffer, or save to disk.
        outFile = SoundFile(".... output path...")
        .headerFormat_("WAV")
        .sampleFormat_("float")
        .numChannels_(1)
        .sampleRate_(44100);
        if(outFile.openWrite.notNil) {
                outFile.writeData(newData);
        } {
                "Couldn't write output file".warn;
        };
} {
        file.close;
        if(outFile.notNil) { outFile.close };
};
)