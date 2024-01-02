import logging
import sqlite3

from server.data_models import *


class SqliteConnector:
    def __init__(self):
        self._con = sqlite3.connect("BirdSense.sqlite")
        self._cur = self._con.cursor()

    def get_users(self):
        res = self._cur.execute("""SELECT * FROM users""")
        return [UserModel(*args) for args in res.fetchall()]

    def insert_detection(self, detection: DetectionModel):
        query = f"""INSERT INTO detections 
        VALUES (NULL,
        "{detection.species}",
        {detection.confidence}, 
        {detection.start_time}, 
        {detection.end_time}, 
        "{detection.dev_eui}")
        """

        logging.info(f"running query:\n{query}")
        self._cur.execute(query)
        self._con.commit()

    def get_all_detections(self, after):
        query = f"""SELECT * FROM detections
        where end_time>{after}
         order by end_time desc
        """
        # logging.info(f"running query:\n{query}")
        res = self._cur.execute(query)
        # print(res.fetchall())
        return [DetectionModel(*args[1:]) for args in res.fetchall()]

if __name__ == '__main__':
    db = SqliteConnector()
    print(db.get_all_detections())