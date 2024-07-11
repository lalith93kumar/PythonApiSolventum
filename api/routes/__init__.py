from .temperature import create_temperature_routes
from .stats import create_stats_routes

def init_routes(app, db_worker):
    create_temperature_routes(app, db_worker)
    create_stats_routes(app, db_worker)