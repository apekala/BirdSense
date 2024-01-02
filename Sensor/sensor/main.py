import logging
import time
from multiprocessing import Process, Queue

from sensor.birdnet_controller import BirdNetController
from sensor.communication.http_connection import HTTPConnection
from sensor.detection import Detection
from sensor.message_composer import MessageComposer
from sensor.microphone_controller import record_sound


def analyze(sound_samples, detections):
    lat, lon = 52.21885, 21.01077
    min_conf = 0.2
    analyzer = BirdNetController(lat=lat, lon=lon, min_conf=min_conf)
    while True:
        rec, sr, rec_start, rec_end = sound_samples.get()
        analyzer_out = analyzer.analyze(rec, sr)
        if not analyzer_out:
            continue

        det = analyzer_out[0]  # len of list should be 1 because recording length is equal to analyzed time (3s)
        result = Detection(
            species=det['scientific_name'],
            confidence=round(det['confidence'], 2),
            end_time=int(round(rec_end)))

        if result:
            logging.info(f"detected {[det['label'] for det in analyzer_out]}")
            detections.put(result)
            print(result)


def send(detections: Queue):
    MAX_MSG_SIZE = 242

    # lora = LoRaConnection('/dev/ttyUSB0')
    lora = HTTPConnection()

    message_composer = MessageComposer(detections, MAX_MSG_SIZE)

    while True:
        if message := message_composer.compose():
            lora.send(message)
        time.sleep(0.1)


if __name__ == '__main__':
    logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

    # start analyzer process
    sound_samples = Queue()
    detections = Queue()

    analyzer = Process(target=analyze, args=(sound_samples, detections))
    analyzer.start()

    sender = Process(target=send, args=(detections,))
    sender.start()

    print("recording...")
    # record sound and pass it in samples to analyzer
    while True:
        rec_data = record_sound(seconds=3)
        sound_samples.put(rec_data)
