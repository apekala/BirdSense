import sqlite3

from server.data_models import *


class SqliteConnector:
    def __init__(self):
        self._con = sqlite3.connect("BirdSense.sqlite")
        self._cur = self._con.cursor()

    def insert_detection(self, detection: DetectionModel):
        """
        Save detection in DB.

        If a species is detected 2 times on a single device in short period of time existing record is updated instead of adding a new record.
        Start and end times are updated to include both detections and confidence is set to max of both confidence scores.
        :param detection: Detection data.
        """

        MIN_TIME_BETWEEN_DETECTIONS = 60

        # update start_time, end_time and accuracy if a species is detected 2 times on a single device in short period of time
        query = f"""
            update detections
            set start_time = min({detection.start_time}, start_time),
                end_time = max({detection.end_time}, end_time),
                confidence = max({detection.confidence}, confidence)
            where dev_eui = "{detection.dev_eui}"
                and species = "{detection.species}"
                and ({detection.end_time} > start_time or {detection.start_time} < end_time)
                and {detection.start_time} - end_time < {MIN_TIME_BETWEEN_DETECTIONS}
                and start_time - {detection.end_time} < {MIN_TIME_BETWEEN_DETECTIONS}
        """

        self._cur.execute(query)

        # insert a record to detections table if detection is not already included in different record (may happen if message confirmation is not received by a client)
        query = f"""
        insert into detections
        select NULL,
                "{detection.species}",
                {detection.confidence},
                {detection.start_time},
                {detection.end_time},
                "{detection.dev_eui}"
        where not EXISTS(select *
                         from detections
                         where dev_eui = "{detection.dev_eui}"
                           and species = "{detection.species}"
                           and start_time <= {detection.start_time}
                           and end_time >= {detection.end_time});
        """

        self._cur.execute(query)
        self._con.commit()

    def get_detections(self, after: int, before: int, dev_eui: str = "%") -> list[DetectionModel]:
        """
        Get detections from DB.
        :param after: unix timestamp, only detections ending after this time will be returned
        :param before: unix timestamp, only detections beginning before this time will be returned
        :param dev_eui: devEUI of device from which detections will be returned, use '%' to return from all devices
        :return: query result
        """

        query = f"""SELECT * FROM detections
        where end_time>{after} and start_time<{before}
        and dev_EUI like "{dev_eui}"
        order by end_time desc
        """
        # logging.info(f"running query:\n{query}")
        res = self._cur.execute(query)
        # print(res.fetchall())
        return [DetectionModel(*args[1:]) for args in res.fetchall()]

    def get_detection_stats(self, after: int, before: int, dev_eui: str = "%") -> list[SpeciesDetectionStatModel]:
        """
        Get stats of number and time of detections by species name.
        :param after: nix timestamp, only detections ending after this time will be included
        :param before: unix timestamp, only detections beginning before this time will be included
        :param dev_eui: devEUI of device from which detections will be included, use '%' to return from all devices
        :return: query result
        """
        query = f"""select species, count(*) detections_count, sum(end_time - start_time) duration from detections
        where end_time>{after} and start_time<{before}
        and dev_EUI like "{dev_eui}"
        group by species
        order by duration desc
        """

        res = self._cur.execute(query)
        return [SpeciesDetectionStatModel(*args) for args in res.fetchall()]

    def get_device_info(self, dev_eui: str):
        """
        Get coordiantes of a device.
        :param dev_eui: devEUI
        :return: latitude and longitude of the device, None if device does not exist.
        """
        query = f"""
        select latitude, longitude from devices
        where dev_eui = "{dev_eui}"
        """

        res = self._cur.execute(query)
        if location := res.fetchone():
            return DeviceLocationModel(*location)
        return None
