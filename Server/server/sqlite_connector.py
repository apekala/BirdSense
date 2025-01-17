import sqlite3
import time

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

        # add species to species table if it doesn't exist yet
        query = f"""
        insert into species (name)
        select "{detection.species}"
        where not exists(select * from species where name="{detection.species}")
        """

        self._cur.execute(query)

        # det species id
        query = f"""
        select species_id from species where name = "{detection.species}" limit 1;
                """

        res = self._cur.execute(query)
        species_id = res.fetchone()[0]

        MIN_TIME_BETWEEN_DETECTIONS = 60

        # update start_time, end_time and accuracy if a species is detected 2 times on a single device in short period of time
        query = f"""
            update detections
            set start_time = min({detection.start_time}, start_time),
                end_time = max({detection.end_time}, end_time),
                confidence = confidence * 0.5 + (1-0.5) * {detection.confidence}
            where dev_eui = "{detection.dev_eui}"
                and species_id = {species_id}
                and {detection.start_time} - end_time < {MIN_TIME_BETWEEN_DETECTIONS}
                and start_time - {detection.end_time} < {MIN_TIME_BETWEEN_DETECTIONS}
        """

        self._cur.execute(query)

        # insert a record to detections table if detection is not already included in different record (may happen if message confirmation is not received by a client)
        query = f"""
        insert into detections
        select NULL,
                "{species_id}",
                {detection.confidence},
                {detection.start_time},
                {detection.end_time},
                "{detection.dev_eui}"
        where not EXISTS(select *
                         from detections
                         where dev_eui = "{detection.dev_eui}"
                           and species_id = {species_id}
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

        query = f"""SELECT name, confidence, start_time, end_time, dev_eui 
        FROM detections d
        join species s on d.species_id = s.species_id
        where end_time>{after} and start_time<{before}
        and dev_EUI like "{dev_eui}"
        order by end_time desc
        """
        # logging.info(f"running query:\n{query}")
        res = self._cur.execute(query)
        # print(res.fetchone())
        return [DetectionModel(*args) for args in res.fetchall()]

    def get_detection_stats(self, after: int, before: int, dev_eui: str = "%") -> list[SpeciesDetectionStatModel]:
        """
        Get stats of number and time of detections by species name.
        :param after: nix timestamp, only detections ending after this time will be included
        :param before: unix timestamp, only detections beginning before this time will be included
        :param dev_eui: devEUI of device from which detections will be included, use '%' to return from all devices
        :return: query result
        """
        query = f"""select name, count(*) detections_count, sum(end_time - start_time) duration 
        from detections d
        join species s on d.species_id = s.species_id
        where end_time>{after} and start_time<{before}
        and dev_EUI like "{dev_eui}"
        group by s.species_id
        order by duration desc
        """

        res = self._cur.execute(query)
        return [SpeciesDetectionStatModel(*args) for args in res.fetchall()]

    def get_all_devices_info(self):
        """
        Get coordiantes of all devices.
        :return: latitude and longitude of all devices.
        """
        query = f"""
        select dev_eui, name, latitude, longitude from devices;
        """
        res = self._cur.execute(query)
        return [DeviceLocationModel(*args) for args in res.fetchall()]

    def get_device_info(self, dev_eui: str):
        """
        Get coordiantes of a device.
        :param dev_eui: devEUI
        :return: latitude and longitude of the device, None if device does not exist.
        """
        query = f"""
        select dev_eui, name, latitude, longitude from devices
        where dev_eui = "{dev_eui}"
        """

        res = self._cur.execute(query)
        if location := res.fetchone():
            return DeviceLocationModel(*location)
        return None

    def insert_article(self, article: ArticleUploadModel):
        query = f"""
        INSERT INTO articles (publish_time, header, article_url, img_url)
        VALUES ({round(time.time())}, "{article.header}","{article.article_url}","{article.img_url}")
        """

        self._cur.execute(query)
        self._con.commit()

    def get_articles(self) -> list[ArticleModel]:
        query = f"""
        select header, publish_time, article_url, img_url from articles
        order by publish_time desc
        """
        res = self._cur.execute(query)
        return [ArticleModel(*args) for args in res.fetchall()]
