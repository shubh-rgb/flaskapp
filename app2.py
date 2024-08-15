from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def reverse_message():
    # Make a request to the first service
    response = requests.get('http://localhost:5000/')
    data = response.json()

    # Reverse the message
    reversed_message = data["message"][::-1]

    # Return the reversed message
    reversed_response = {
        "id": data["id"],
        "message": reversed_message
    }
    return jsonify(reversed_response)

if __name__ == '__main__':
    app.run(host='localhost', port=5001)

