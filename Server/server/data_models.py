from dataclasses import dataclass

from pydantic import BaseModel


@dataclass
class DetectionModel:
    species: str
    confidence: float
    start_time: int
    end_time: int
    dev_eui: str


@dataclass
class SpeciesDetectionStatModel:
    species: str
    count: int
    duration: int


@dataclass
class DeviceLocationModel:
    dev_eui: str
    name: str
    latitude: float
    longitude: float


class ArticleUploadModel(BaseModel):
    header: str
    article_url: str
    img_url: str


@dataclass
class ArticleModel:
    header: str
    publish_time: str
    article_url: str
    img_url: str
