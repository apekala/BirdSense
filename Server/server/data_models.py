from dataclasses import dataclass


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
