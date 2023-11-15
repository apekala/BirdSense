import time

from microphone_controller import record_sound
from birdnet_controller import BirdNetController

if __name__ == '__main__':
    lat, lon = 52.21885, 21.01077
    min_conf = 0.5

    analyzer = BirdNetController(lat=lat, lon=lon, min_conf=min_conf)
    rec, sr = record_sound(seconds=3)
    print("recording...")
    start = time.time()
    det = analyzer.analyze(rec, sr)
    print('analysis time: ', time.time() - start)
    print(det)