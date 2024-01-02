import logging


class MessageComposer:
    def __init__(self, detections, max_len):
        self._MAX_MSG_SIZE = max_len
        self.detections = detections
        self._last_element_buffer = None


    def _to_csv(self, data: list):
        pass

    def _dump_detections_queue(self):
        """
        returns content of a multiprocessing.Queue without exceedeing max message size (bytes).
        :return:
        """
        res = ''
        if self._last_element_buffer:
            res += self._last_element_buffer

        last_element_buffer = None
        while not (self.detections.empty() or len(
                res + (last_element_buffer := self.detections.get().to_str())) > self._MAX_MSG_SIZE):
            res += last_element_buffer
            last_element_buffer = None

        self._last_element_buffer = last_element_buffer
        return res

    def compose(self):
        """
        joins max number of detections from multiprocessing.Queue() without exceeding maximum allowed message lentgh (bytes)
        :return: message or None if qu
        """
        if message := self._dump_detections_queue():
            logging.info(f"seending message: {message} msg len: {len(str(message))}")
            logging.warning(
                f"there are {self.detections.qsize() + 1 if self._last_element_buffer else self.detections.qsize()} unsent messages")
            return message
        return None
