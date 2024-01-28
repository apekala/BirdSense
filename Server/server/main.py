import logging
import time

from fastapi import FastAPI, Request, HTTPException

from server.data_models import *
from server.sqlite_connector import SqliteConnector

app = FastAPI()

db = SqliteConnector()

logging.basicConfig(level=logging.DEBUG)


@app.post('/v1/webhooks/detections', status_code=201)
async def upload_detections_from_ttn(request: Request):
    """
    Webhook for sending data from TTN.
    """
    print(await request.body())
    body = await request.json()

    dev_eui = body["end_device_ids"]['dev_eui']
    sensor_data = body['uplink_message']['decoded_payload']['data']

    rec_length = 3
    for det in sensor_data:
        detection = DetectionModel(
            dev_eui=dev_eui,
            species=det['species'],
            confidence=float(det['confidence']),
            start_time=int(det['end_time']) - rec_length,
            end_time=int(det['end_time'])
        )

        db.insert_detection(detection)


@app.get('/v1/detections', response_model=list[DetectionModel])
async def get_all_detections(after: int = 0, before: int = 2 ** 64, devEUI='%'):
    """
    Get detections data.
    - **after**: unix timestamp, only detections ending after this time will be included
    - **before**: unix timestamp, only detections beginning before this time will be included
    - **devEUI**: devEUI of device from which detections will be included
    """
    return db.get_detections(after, before, devEUI)


@app.get('/v1/device-info', response_model=list[DeviceLocationModel])
async def get_all_devices_location() -> list[DeviceLocationModel]:
    """
    Get locations of all devices
    - **devEUI**: devEUI of a device
    """
    print(db.get_all_devices_info())
    return db.get_all_devices_info()


@app.get('/v1/device-info/{dev_eui}', response_model=DetectionModel)
async def get_device_location(dev_eui: str) -> DeviceLocationModel:
    """
    Get location of a device
    - **devEUI**: devEUI of a device
    """
    if res := db.get_device_info(dev_eui):
        return res
    raise HTTPException(status_code=404, detail="Device not found")


@app.get("/v1/stats/detections-by-species", response_model=list[SpeciesDetectionStatModel])
async def get_detecions_by_species_stats(after: int = 0, before: int = round(time.time()), devEUI='%'):
    """
    Get number of detections and total time of detections groupped by species names.

    - **after**: unix timestamp, only detections ending after this time will be included
    - **before**: unix timestamp, only detections beginning before this time will be included
    - **devEUI**: devEUI of device from which detections will be included
    """
    return db.get_detection_stats(after, before, devEUI)


@app.post('/v1/articles', status_code=201)
async def post_articles(article: ArticleUploadModel):
    """
    upload an article:
    """
    db.insert_article(article)


@app.get('/v1/articles', response_model=list[ArticleModel])
async def get_articles():
    """
    Get all articles
    """
    return db.get_articles()
