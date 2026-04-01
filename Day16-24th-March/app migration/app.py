from flask import Flask
import socket
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    hostname = socket.gethostname()
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    return f"""
    <html>
    <head>
        <title>Flask App - EC2 Deployment</title>
        <style>
            body {{
                font-family: Arial, sans-serif;
                background: linear-gradient(to right, #031e36, #4998de);
                margin: 0;
                padding: 0;
                text-align: center;
            }}
            .container {{
                background: white;
                margin: 60px auto;
                padding: 30px;
                width: 70%;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }}
            h1 {{
                color: #2c3e50;
            }}
            .info {{
                margin-top: 20px;
                padding: 15px;
                background: #f1f1f1;
                border-radius: 8px;
            }}
            .badge {{
                display: inline-block;
                margin-top: 15px;
                padding: 10px 20px;
                background: #27ae60;
                color: white;
                border-radius: 20px;
                font-weight: bold;
            }}
        </style>
    </head>

    <body>
        <div class="container">
            <h1>🚀 Flask App Deployed on EC2</h1>
            <p>This is the <b>Rehost Phase</b> of AWS Migration</p>

            <div class="info">
                <p><b>Instance:</b> {hostname}</p>
                <p><b>Time:</b> {current_time}</p>
            </div>

            <div class="badge">
                Running on Port 5000
            </div>

            <p style="margin-top:20px;">
                Next Step ➡️ Move Static Content to S3 (Replatform)
            </p>
        </div>
    </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)