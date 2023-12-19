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
    dev_eui: str
    species: str
    confidence: float
    start_time: float
    end_time: float

if __name__ == '__main__':
    u = UserModel(2137, "jp2gmd")
    print(vars(u))