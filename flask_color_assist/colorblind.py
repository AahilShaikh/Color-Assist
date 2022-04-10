from flask import Flask, request
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast

app = Flask(__name__)
api = Api(app)

class Colors(Resource):
    def get(self):
        image = request.args.get('image')
        print(image)
        return image

api.add_resource(Colors, '/')

if __name__ == '__main__':
    app.run(host="0.0.0.0")
