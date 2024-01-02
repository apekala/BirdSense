from birdnetlib import Recording as Recording_
from birdnetlib.exceptions import AudioFormatError
import librosa
import audioread


class Recording(Recording_):
    """
    Adapter for birdnetlib.Recording that allows passing sound recording as ndarray instead of file path.
    """
    def __init__(self, recording, sample_rate, analyzer, **kwargs):
        super().__init__(analyzer=analyzer, path='', **kwargs)
        self.recording = recording
        self.sample_rate = sample_rate


    def read_audio_data(self):
        print("read_audio_data")
        # Open file with librosa (uses ffmpeg or libav)
        try:
            self.ndarray, rate = self.recording, self.sample_rate  # pass recorded nd array instead of reading a file

            self.duration = librosa.get_duration(y=self.ndarray, sr=self.sample_rate)
        except audioread.exceptions.NoBackendError as e:
            print(e)
            raise AudioFormatError("Audio format could not be opened.")
        except FileNotFoundError as e:
            print(e)
            raise e
        except BaseException as e:
            print(e)
            raise AudioFormatError("Generic audio read error occurred from librosa.")

        self.process_audio_data(rate)
