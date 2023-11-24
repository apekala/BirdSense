import datetime
import multiprocessing
import time
from multiprocessing import Process, Queue

from microphone_controller import record_sound
from birdnet_controller import BirdNetController
from utils import *

def analyze(sound_samples):
    lat, lon = 52.21885, 21.01077
    min_conf = 0.5


    analyzer = BirdNetController(lat=lat, lon=lon, min_conf=min_conf)


    while True:
        rec, sr, rec_start, rec_end = sound_samples.get()
        det = analyzer.analyze(rec, sr)

        print(rec_start, rec_end)
        print(det)


if __name__ == '__main__':
    # start analyzer process
    sound_samples = Queue()
    analyzer = Process(target=analyze, args=(sound_samples,))
    analyzer.start()

    # record sound and pass it in samples to analyzer
    while True:
        rec_data = record_sound(seconds=3)
        sound_samples.put(rec_data)
