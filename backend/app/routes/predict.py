# This is a placeholder route that handles POST requests from the Swift app 
from flask import Blueprint, request, jsonify
from app.services.predictions_service import make_prediction

predict_bp = Blueprint('predict', __name__)

@predict_bp.route('/predict', methods=['POST'])
def predict():
    #placeholder for ML route
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing input data"}), 400

    result = make_prediction(data)
    return jsonify(result)
    
