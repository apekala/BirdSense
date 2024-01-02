import sys
import time
import unittest
from unittest.mock import MagicMock, patch

from multiprocessing import Process, Queue
from audio2numpy import open_audio

import sensor.main as main
from sensor.detection import Detection

from sensor.utils import suppress_stdout
# mock lora communication package to stop test from failing when testing without lora module connected
sys.modules['sensor.communication.lora'] = MagicMock()

class TeatAnalyzeProcess(unittest.TestCase):
    def test_given_bird_recording_when_analyzing_then_output_format_is_correct(self):
        rec, sr = open_audio('mallard.mp3')
        rec_data = rec[:3*sr], sr, 0, 3
        sound_samples = Queue()
        detections = Queue()


        analyzer = Process(target=main.analyze, args=(sound_samples, detections))
        analyzer.start()

        sound_samples.put(rec_data)

        result: Detection = detections.get()
        expected: Detection = Detection(species='Anas platyrhynchos', end_time=3, confidence=0)

        self.assertEqual(result.species, expected.species)
        self.assertEqual(result.end_time, expected.end_time)
        self.assertIsInstance(result.confidence, float)


if __name__ == '__main__':
    unittest.main()
