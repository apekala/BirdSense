import datetime
import multiprocessing
import time
import logging
from multiprocessing import Process, Queue

from microphone_controller import record_sound
from birdnet_controller import BirdNetController
from communication.lora import LoRaConnection
from utils import *


def analyze(sound_samples, detections):
    lat, lon = 52.21885, 21.01077
    min_conf = 0.2
    analyzer = BirdNetController(lat=lat, lon=lon, min_conf=min_conf)
    while True:
        rec, sr, rec_start, rec_end = sound_samples.get()
        det = analyzer.analyze(rec, sr)

        detections.put(det)

def send(detections: Queue):
    MAX_MSG_SIZE = 242

    lora = LoRaConnection('/dev/ttyUSB0')

    def dump_queue(q, last_element_buffer):
        res = []
        if last_element_buffer:
            res += last_element_buffer

        while not (q.empty() or len(str(res + (last_element_buffer := q.get()))) > MAX_MSG_SIZE):
            res += last_element_buffer
            last_element_buffer = None

        return res


    last_element_buffer = None
    while True:
        if message := dump_queue(detections, last_element_buffer):
            logging.info(f"seending message (): {message} msg len: {len(str(message))}")
            logging.warning(f"there are {detections.qsize() + 1 if last_element_buffer else detections.qsize()} unsent messages")
            lora.send(message)
            time.sleep(1)


if __name__ == '__main__':
    logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

    # start analyzer process
    sound_samples = Queue()
    detections = Queue()

    analyzer = Process(target=analyze, args=(sound_samples, detections))
    analyzer.start()

    sender = Process(target=send, args=(detections,))
    sender.start()

    # record sound and pass it in samples to analyzer
    while True:
        print("recording...")
        rec_data = record_sound(seconds=3)
        sound_samples.put(rec_data)
