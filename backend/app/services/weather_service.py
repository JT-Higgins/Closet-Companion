import requests
import os
from datetime import datetime, timezone

API_KEY = os.getenv("OPENWEATHER_API_KEY")
BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

def fetch_weather_by_city(city: str):
    try:
        params = {
            "q": city,
            "units": "metric",
            "appid": API_KEY
        }
        response = requests.get(BASE_URL, params=params)
        response.raise_for_status()
        data = response.json()
        return parse_weather_response(data)
    except requests.RequestException as e:
        return {"error": f"Weather API request failed: {str(e)}"}

def fetch_weather_by_coords(lat: float, lon: float):
    try:
        params = {
            "lat": lat,
            "lon": lon,
            "units": "metric",
            "appid": API_KEY
        }
        response = requests.get(BASE_URL, params=params)
        response.raise_for_status()
        data = response.json()
        return parse_weather_response(data)
    except requests.RequestException as e:
        return {"error": f"Weather API request failed: {str(e)}"}

def parse_weather_response(data):
    if "main" not in data or "weather" not in data:
        return {"error": "Invalid response from weather API"}
    
    return {
        "temperature": data["main"]["temp"],
        "condition": data["weather"][0]["main"],
        "humidity": data["main"]["humidity"],
        "windSpeed": data["wind"]["speed"],
        "location": data["name"],
        "timestamp": datetime.now(timezone.utc).isoformat()
    }