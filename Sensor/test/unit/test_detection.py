import unittest

from sensor.detection import Detection

class MyTestCase(unittest.TestCase):
    def test_given_Detection_object_when_to_str_called_output_is_correct(self):
        detection = Detection("name", 0.5, 123)
        self.assertEqual("name;0.5;123\n", detection.to_str())

if __name__ == '__main__':
    unittest.main()
