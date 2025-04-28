from flask import Flask
from flask_cors import CORS
from flask import jsonify
from app.routes.weather_routes import weather_bp
from app.routes.predict import predict_bp
from dotenv import load_dotenv

load_dotenv()

def create_app():
    app = Flask(__name__)
    CORS(app)

    @app.route('/')
    def index():
        return jsonify({"message": "Flask backend is running!"})
    
    app.register_blueprint(weather_bp)
    app.register_blueprint(predict_bp)
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)
