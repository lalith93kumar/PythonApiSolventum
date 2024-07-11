from .dbworker import DBWorker
from flask import Response
import json
#BE-DB wrapper
class BEWorker:
    def __init__(self,app):
        self.db = DBWorker(app);
        
    def makeResponse(self,data):
        res = Response(response=json.dumps(data['payload']), status=data['code'])
        res.headers["Content-Type"] = "text/json;"
        return res
            
    def addTemperatureReadingResponse(self,sensor_id,temperature,time_str):
        return self.makeResponse(self.db.addTemperatureReading(sensor_id,temperature,time_str))
    
    def getAllTemperaturesResponse(self):
        return self.makeResponse(self.db.getAllTemperatures())

    def getTemperatureStatsResponse(self):
        return self.makeResponse(self.db.getTemperatureStats())