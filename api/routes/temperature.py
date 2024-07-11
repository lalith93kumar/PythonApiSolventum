from flask import Blueprint, request, jsonify
from ..beworker import BEWorker
from flask import request
from random import randint, getrandbits
temperature_bp = Blueprint('temperature', __name__)
def create_temperature_routes(app, worker):
	@temperature_bp.route('/api/temperature', methods=['PUT'])
	def add_temperature_reading():
	    data = request.get_json()
	    sensor_id = data.get('sensorId')
	    temperature = data.get('temperature')
	    time_str = data.get('time')
	    return worker.addTemperatureReadingResponse(sensor_id,temperature,time_str)
	@temperature_bp.route('/api/temperatures', methods=['GET'])
	def get_temperature_readings():
		is_high_loaded = bool(getrandbits(1))
		if (is_high_loaded):
			latency = randint(0, 15)
			time.sleep(latency)
		return worker.getAllTemperaturesResponse()

	app.register_blueprint(temperature_bp)