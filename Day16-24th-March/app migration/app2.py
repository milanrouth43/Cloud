    from flask import Flask
    import requests

    app = Flask(__name__)

    S3_URL = "https://migration-static-bucket.s3.amazonaws.com/static.html"

    @app.route('/')
    def home():
        response = requests.get(S3_URL)
        return response.text

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000)