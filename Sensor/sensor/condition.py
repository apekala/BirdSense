import smbus2


class Conditions():

    def __init__(self):
        self.port = 1
        self.adress = 0x77
        self.bus = smbus2.SMBus(self.port)
        calibration_params = bme280.load_calibration_params(self.bus, self.adress)

    def get_temperature(self):
        '''
        Return current temperature in Celcius
        '''
        temperature = 0
        for i in range(10):
            bme280_data = bme280.sample(self.bus, self.adress, )
            temperature = temperature + bme280_data.temperature
        temperature = temperature / 10
        return temperature

    def get_humidity(self):
        '''
        Return current humidity as percent
        '''
        humidity = 0
        for i in range(10):
            bme280_data = bme280.sample(self.bus, self.adress, )
            humidity = humidity + bme280_data.humidity
        humidity = humidity / 10
        return humidity

    def get_pressure(self):
        '''
        Return current pressure in hPa 
        '''
        pressure = 0
        for i in range(10):
            bme280_data = bme280.sample(self.bus, self.adress, )
            pressure = pressure + bme280_data.pressure
        pressure = pressure / 10
        return pressure

    def get_all(self) -> list[float]:
        '''
        Return list of current conditions
        '''
        condition = [self.get_temperature(), self.get_humidity(), self.get_pressure()]
        return condition
