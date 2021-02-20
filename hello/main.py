from flask import Flask
import os


application = Flask(__name__)

MYNAME = os.environ.get('MYNAME') or __name__

@application.route('/')
def hello_world():
    return f"<!DOCTYPE html><html><body>Hello, world! I'm {MYNAME}</body></html>"
