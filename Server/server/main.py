#  ngrok http  --domain=saving-crow-bursting.ngrok-free.app 127.0.0.1:8000
import logging
from fastapi import FastAPI, Request
from pydantic import BaseModel
from typing import Any
import json
from base64 import b64decode

from server.sqlite_connector import SqliteConnector
from server.data_models import *

app = FastAPI()

db = SqliteConnector()

logging.basicConfig(level=logging.DEBUG)


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post('/v1/webhooks/detections', status_code=201)
async def upload_detections_from_ttn(request: Request):
    # print(await request.body())
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
            start_time=int(det['end_time'])-rec_length,
            end_time=int(det['end_time'])
        )

        db.insert_detection(detection)


@app.get('/v1/detections', response_model=list[DetectionModel])
async def get_all_detections(after: int = 0):
    return db.get_all_detections(after)

