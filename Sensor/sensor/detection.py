from dataclasses import dataclass


@dataclass
class Detection():
    species: str
    confidence: float
    end_time: int

    def to_str(self):
        return f"{self.species};{self.confidence};{self.end_time}\n"
