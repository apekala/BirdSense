from pydantic import BaseModel
from dataclasses import dataclass
@dataclass
class UserModel:
    user_id: int
    name: str

@dataclass
class DeviceModel:
    dev_eui: int
    owner_id: int

@dataclass
class DetectionModel:
    species: str
    confidence: float
    start_time: int
    end_time: int
    dev_eui: str

if __name__ == '__main__':
    pass