import sounddevice as sd
from scipy.io.wavfile import write
import time

def record_sound(seconds, fs=44100):
    start = time.time()
    myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=1)
    sd.wait()  # Wait until recording is finished
    end = time.time()
    write('output.wav', fs, myrecording)  # Save as WAV file

    return myrecording.flatten(), fs, start, end
