from flask import Blueprint, request, jsonify
from app.services.weather_service import fetch_weather_by_city, fetch_weather_by_coords

weather_bp = Blueprint('weather', __name__)

@weather_bp.route('/weather', methods=['GET'])
def get_weather():
    city = request.args.get('city')
    lat = request.args.get('lat')
    lon = request.args.get('lon')

    if city:
        result = fetch_weather_by_city(city)
    elif lat and lon:
        try:
            result = fetch_weather_by_coords(float(lat), float(lon))
        except ValueError:
            return jsonify({"error": "Invalid latitude or longitude values"}), 400
    else:
        return jsonify({"error": "Missing city or coordinates"}), 400
    
    if "error" in result:
        return jsonify(result), 500

    return jsonify(result)