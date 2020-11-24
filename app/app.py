from typing import List, Dict
from flask import Flask
import mysql.connector
import json
import logging
from functools import wraps
import subprocess, os
import yaml


app = Flask(__name__)

config = {
    'user': 'root',
    'password': 'root',
    'host': 'db',
    'port': '3306',
    'database': 'statistics'
}


log_file = "./logfile.log"
log_level = logging.DEBUG
logging.basicConfig(level=log_level, filename=log_file, filemode="w+",
                        format="%(asctime)-15s %(levelname)-8s %(message)s")
logger = logging.getLogger("statistics_logger")



def wrap(pre, post):
    def decorate(func):
        @wraps(func)
        def call(*args, **kwargs):
            pre(func, *args, **kwargs)
            result = func(*args, **kwargs)
            post(func, *args, **kwargs)
            return result
        return call
    return decorate

def entering(func):
   logger.debug("Entered %s", func.__name__)

def exiting(func):
   logger.debug("Exitedd  %s", func.__name__)


@wrap(entering, exiting)
def disk_usg() -> List[Dict]:
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM disk_usage WHERE Taken_at >= NOW() - INTERVAL 24 HOUR')
    results = [[{"Used": Used}, {"Free": Free}, {"Taken_at": Taken_at.strftime("%m/%d/%Y, %H:%M:%S")}] for Used, Free, Taken_at in cursor]
    cursor.close()
    connection.close()

    return results

@wrap(entering, exiting)
def mem_usg() -> List[Dict]:
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM mem_usage WHERE Taken_at >= NOW() - INTERVAL 24 HOUR')
    results = [[{"Used": Used}, {"Free": Free}, {"Taken_at": Taken_at.strftime("%m/%d/%Y, %H:%M:%S")}] for Used, Free, Taken_at in cursor]
    cursor.close()
    connection.close()

    return results

@wrap(entering, exiting)
def cpu_usg() -> List[Dict]:
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM cpu_usage WHERE Taken_at >= NOW() - INTERVAL 24 HOUR')
    results = [[{"Usage": Usage}, {"Taken_at": Taken_at.strftime("%m/%d/%Y, %H:%M:%S")}] for (Usage, Taken_at) in cursor]
    cursor.close()
    connection.close()

    return results

@app.route('/')
@wrap(entering, exiting)
def hello_world():
    return 'Hello, World! Continue to know the servers statistics.'

@app.route('/disk')
@wrap(entering, exiting)
def disk() -> str:
    return json.dumps({'disk_usg': disk_usg()})

@app.route('/memory')
@wrap(entering, exiting)
def mem() -> str:
    return json.dumps({'mem_usg': mem_usg()})

@app.route('/cpu')
@wrap(entering, exiting)
def cpu() -> str:
    return json.dumps({'cpu_usg': cpu_usg()})


@wrap(entering, exiting)
@app.route('/current')
def current():
     result = subprocess.check_output(['bash', '/app/current_statistics.sh'])
     result = yaml.load(result)
     return json.dumps(result, indent=4, default=str)



if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

