import sounddevice as sd
from scipy.io.wavfile import write


def record_sound(fs=44100, seconds=3):
    myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=1)
    sd.wait()  # Wait until recording is finished
    write('output.wav', fs, myrecording)  # Save as WAV file
    # print(myrecording.flatten())
    return myrecording.flatten(), fs
