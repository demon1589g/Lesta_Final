from flask import request, jsonify

from app import app, db
from app.models import Result


@app.route('/submit', methods=['POST'])
def submit():
    data = request.json
    new_result = Result(name=data['name'], score=data['score'])
    db.session.add(new_result)
    db.session.commit()
    return jsonify({"message": "Saved"}), 201


@app.route('/results', methods=['GET'])
def results():
    all_results = Result.query.all()
    output = [
        {
            "id": r.id,
            "name": r.name,
            "score": r.score,
            "timestamp": r.timestamp.isoformat()
        }
        for r in all_results
    ]
    return jsonify(output)


@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({"status": "ok"})
