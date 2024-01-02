import time
import unittest
from multiprocessing import Queue
from unittest.mock import MagicMock

from sensor.detection import Detection
from sensor.message_composer import MessageComposer


class TestMessageComposer(unittest.TestCase):
    def test_given_non_empty_short_queue_when_dump_detections_queue_called_then_correct_list_returned(self):
        q = Queue()
        q.put(Detection('n', 0.5, 1))
        time.sleep(0.01)

        composer = MessageComposer(q, 100)
        result = composer._dump_detections_queue()
        self.assertEqual("n;0.5;1\n", result)

    def test_given_non_empty_short_queue_when_dump_detections_queue_called_then_last_element_buffer_is_None(self):
        q = Queue()
        q.put(Detection('n', 0.5, 1))
        time.sleep(0.01)

        composer = MessageComposer(q, 100)
        result = composer._dump_detections_queue()
        self.assertIsNone(composer._last_element_buffer)

    def test_given_queue_longer_than_max_message_len_when_dump_detections_queue_called_then_longest_allowed_message_returned(
            self):
        q = Queue()
        q.put(Detection('n', 0.5, 1))
        q.put(Detection('n', 0.5, 2))
        q.put(Detection('n', 0.5, 3))
        time.sleep(0.01)

        composer = MessageComposer(q, 20)
        result = composer._dump_detections_queue()

        expected = "n;0.5;1\nn;0.5;2\n"
        self.assertEqual(expected, result)

    def test_given_queue_longer_than_max_message_len_when_dump_detections_queue_called_twice_then_detections_retuned_in_second_message(
            self):
        q = Queue()
        q.put(Detection('n', 0.5, 1))
        q.put(Detection('n', 0.5, 2))
        q.put(Detection('n', 0.5, 3))
        time.sleep(0.01)

        composer = MessageComposer(q, 20)
        composer._dump_detections_queue()
        result = composer._dump_detections_queue()

        expected = "n;0.5;3\n"
        self.assertEqual(expected, result)

    # @patch('MessageComposer._dump_detections_queue')
    def test_given_single_detection_when_compose_called_then_message_returned(self):
        # mock_dump = MagicMock(return_value=["a", "b"])
        expected = ["a", "b"]

        composer = MessageComposer(MagicMock(), 100)
        composer._dump_detections_queue = MagicMock(return_value=["a", "b"])
        result = composer.compose()

        self.assertEqual(expected, result)

    def test_given_empty_queue_when_compose_called_then_None_returned(self):
        composer = MessageComposer(MagicMock(), 100)
        composer._dump_detections_queue = MagicMock(return_value=[])
        result = composer.compose()

        self.assertIsNone(result)


if __name__ == '__main__':
    unittest.main()
