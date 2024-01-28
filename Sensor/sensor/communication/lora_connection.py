import logging
import os
import time

import serial

from sensor.communication.lora_exceptions import JoinError


class LoRaConnection:
    def __init__(self, port):
        os.system(f'sudo chmod 666 {port}')
        self._ser = serial.Serial(port=port, baudrate=9600, timeout=5)
        self._join()

    def _send_AT(self, command: str):
        self._ser.write(bytes(command + '\r\n', "ASCII"))

    def _join(self):
        """
        join LoRaWan network
        :return:
        """
        self._send_AT("AT+JOIN")
        lines = []
        while not (lines and lines[-1] in [b'+JOIN: Done\r\n', b'+JOIN: Joined already\r\n']):
            if self._ser.in_waiting:
                line = self._ser.readline()
                print(line)
                if line == b'+JOIN: Join failed\r\n':
                    raise JoinError("join failed")
                lines.append(line)
        print("Joined LoRa network")

    def send(self, message, confirmation=True, timeout=30):
        """
        send a message
        :param confirmation: True if confirmation required, False if not
        :param message: message
        :return: False if confirmation required and not received, else True.
        """
        start_time = time.time()

        logging.info(f'sending msg "{message}"')
        at = f'AT+CMSG="{message}"' if confirmation else f'AT+MSG="{message}"'

        self._send_AT(at)
        lines = []
        was_confirmed = False

        start_time = time.time()
        while not (lines and lines[-1] in [b'+MSG: Done\r\n', b'+CMSG: Done\r\n']):
            if lines and lines[-1] == b'+CMSG: ACK Received\r\n':
                was_confirmed = True

            if time.time() - start_time > timeout:
                raise TimeoutError(f"Sending LoRaWan message took more than {timeout} seconds")
            if self._ser.in_waiting:
                lines.append(self._ser.readline())
            time.sleep(0)

        if confirmation and not was_confirmed:
            logging.warning(f'Message has not been confirmed. time: {time.time() - start_time}s')
            return False
        elif was_confirmed:
            logging.info(f'Message sent and confirmed. time: {time.time() - start_time}s')
        else:
            logging.info(f'Message sent, confirmation not required. time: {time.time() - start_time}s')
        return True

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    lora = LoRaConnection("/dev/ttyUSB0")
    # lora.send("hello")
    lora.send("a" * 10)
