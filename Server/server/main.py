#  ngrok http  --domain=saving-crow-bursting.ngrok-free.app 127.0.0.1:8000
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
    # sensor_data = json.loads(sensor_data.replace("'", "\""))

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
async def get_all_detections(after: int = 0, before: int = 2**64, devEUI='%'):
    """
    Get detections data.
    - **after**: unix timestamp, only detections ending after this time will be included
    - **before**: unix timestamp, only detections beginning before this time will be included
    - **devEUI**: devEUI of device from which detections will be included
    """
    return db.get_detections(after, before, devEUI)


@app.get('/v1/device-location/{dev_eui}')
async def get_device_location(dev_eui: str):
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
