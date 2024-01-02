import time

import sounddevice as sd


def record_sound(seconds, fs=44100):
    """
    records sound
    :param seconds: recording duration
    :param fs: sample rate
    :return: recording, sample rate, start time as UNIX timestamp, end time as UNIX timestamp
    """
    start = time.time()
    myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=1)
    sd.wait()  # Wait until recording is finished
    end = time.time()
    # write('output.wav', fs, myrecording)  # Save as WAV file
    return myrecording.flatten(), fs, start, end
