import logging

import requests
from base64 import b64encode
import json


class HTTPConnection():
    def __init__(self):
        self.url = "http://127.0.0.1:8000/v1/webhooks/detections"

    def send(self, message, timeout=15):
        """
        Sends detections data as HTTP post request to the same endpoint as TTN. If server cannot be reached does NOT ras an error. Used for testing.
        """
        message = b64encode(bytes(json.dumps(message), "ASCII"))

        data_json = {"end_device_ids": {'dev_eui': 'test_dev_eui'},
                     'uplink_message': {'frm_payload': message.decode("ASCII")}
                     }

        try:
            r = requests.post(self.url, data=json.dumps(data_json))
        except requests.exceptions.ConnectionError:
            logging.error("Connection with server unsuccessful. Pretending to send message...")
        logging.info(data_json)

if __name__ == '__main__':
    con = HTTPConnection()

    con.send([{'scientific_name': 'Anas platyrhynchos', 'confidence': 0, 'end_time': 3}])
