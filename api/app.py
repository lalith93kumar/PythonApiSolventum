from flask import Flask
from .beworker import BEWorker
from .routes import init_routes
import os
app = Flask(__name__)
if(os.getenv('DBINSTANCE_ENDPOINT',default = None)==None):
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test5.db'
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://foo:foobarbaz@"+os.getenv('DBINSTANCE_ENDPOINT',default = None)+"/mydb"
print(app.config['SQLALCHEMY_DATABASE_URI'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# Initialize DBWorker with the app context
db_worker = BEWorker(app)

# Initialize routes
init_routes(app, db_worker)

if __name__ == '__main__':
    app.run(debug=True)
