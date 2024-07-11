from flask import Blueprint, jsonify
from ..beworker import BEWorker

stats_bp = Blueprint('stats', __name__)

def create_stats_routes(app, worker):
    @stats_bp.route('/api/stats', methods=['GET'])
    def get_temperature_stats():
        return worker.getTemperatureStatsResponse()

    app.register_blueprint(stats_bp)