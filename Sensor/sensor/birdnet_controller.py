from birdnetlib.analyzer import Analyzer
from datetime import datetime
from numpy import ndarray

from recording import Recording
from utils import *


class BirdNetController:
    def __init__(self, lat, lon, min_conf):
        self.lat = lat
        self.lon = lon
        self.min_conf = min_conf

        # Load and initialize the BirdNET-Analyzer models.
        self.analyzer = Analyzer()

    def analyze(self, recording: ndarray, sr: int):
        recording = Recording(
            recording=recording,
            sample_rate=sr,
            analyzer=self.analyzer,
            lat=self.lat,
            lon=self.lon,
            date=datetime.now(),
            min_conf=self.min_conf,
        )

        with suppress_stdout():
            recording.analyze()

        return recording.detections
