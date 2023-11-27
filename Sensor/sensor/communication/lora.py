import serial
import time

import lora_exceptions


class LoRaConnection:
    def __init__(self):
        self._ser = serial.Serial(port="/dev/ttyUSB3", baudrate=9600, timeout=5)
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
                if line == b'+JOIN: Join failed\r\n':
                    raise lora_exceptions.JoinError("join failed")
                lines.append(line)
        print("Joined LoRa network")

    def send(self, message):
        """
        send a message
        :param message: message
        :return:
        """

        at = f'AT+MSG="{message}"'
        self._send_AT(at)
        lines = []
        while not (lines and lines[-1] == b'+MSG: Done\r\n'):
            if self._ser.in_waiting:
                lines.append(self._ser.readline())
        print(f'message: "{message}" sent')

if __name__ == '__main__':
    lora = LoRaConnection()
    lora.send("dobrze jest byc skryba")
