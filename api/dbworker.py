from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from sqlalchemy.sql import func

db = SQLAlchemy()
class TemperatureReading(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    sensor_id = db.Column(db.String(255), nullable=False)
    temperature = db.Column(db.Float, nullable=False)
    time = db.Column(db.DateTime, nullable=False)

    def __repr__(self):
        return f"<TemperatureReading(sensor_id={self.sensor_id}, temperature={self.temperature}, time={self.time})>"

class DBWorker:
    def __init__(self,app):
        self.app = app
        with self.app.app_context():
            db.init_app(app)
            db.create_all()
        
    def dto(self, code, payload):
        data = {
            'code' : code,
            'payload' : payload
        }
        return data

    def addTemperatureReading(self, sensor_id, temperature, time_str):
        try:
            # Validate the time format
            try:
                time = datetime.strptime(time_str, '%Y-%m-%d %H:%M:%S')
            except ValueError:
                return self.dto(400, {"error": "Invalid date format. Use 'YYYY-MM-DD HH:MM:SS'."})
            
            # Validate the presence of required fields
            if not sensor_id or temperature is None or not time:
                return self.dto(400, {"error": "Missing required fields."})
            
            # Create a new TemperatureReading object
            new_reading = TemperatureReading(sensor_id=sensor_id, temperature=temperature, time=time)
            db.session.add(new_reading)
            db.session.commit()
            return self.getAllTemperatures()
        except Exception as e:
            return self.dto(400, f"Exception: {str(e)}")

    def getAllTemperatures(self):
        try:
            assets = TemperatureReading.query.all()
            dt = [{'id': asset.id, 'sensor_id': asset.sensor_id, 'temperature': asset.temperature, 'time': asset.time.strftime('%Y-%m-%d %H:%M:%S')} for asset in assets]
            return self.dto(200, dt)
        except Exception as e:
            return self.dto(400, f"Exception: {str(e)}")

    
    def getTemperatureStats(self):
        try:
            max_temp = db.session.query(func.max(TemperatureReading.temperature)).scalar()
            min_temp = db.session.query(func.min(TemperatureReading.temperature)).scalar()
            avg_temp = db.session.query(func.avg(TemperatureReading.temperature)).scalar()
            
            stats = {
                "Maximum": max_temp,
                "Minimum": min_temp,
                "Average": avg_temp
            }
            return self.dto(200, stats)
        except Exception as e:
            return self.dto(400, f"Exception: {str(e)}")