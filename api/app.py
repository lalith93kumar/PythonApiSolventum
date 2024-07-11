from flask import Flask
from .beworker import BEWorker
from .routes import init_routes
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test5.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize DBWorker with the app context
db_worker = BEWorker(app)

# Initialize routes
init_routes(app, db_worker)

if __name__ == '__main__':
    app.run(debug=True)
