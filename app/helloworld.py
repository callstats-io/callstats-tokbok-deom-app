from flask import Flask, render_template
from opentok import OpenTok
import os

__API_KEY = os.getenv('TOKBOX_API_KEY', '')
__API_SECRET = os.getenv('TOKBOX_AUTH_TOKEN', '')
__APP_ID = os.getenv('CALLSTATS_APP_ID', '')
__APP_SECRET = os.getenv('CALLSTATS_APP_SECRET', '')
__PORT = os.getenv("PORT", 7070)
__TARGET = os.getenv('TARGET', 'dev')

try:
    api_key = __API_KEY
    api_secret = __API_SECRET
except Exception:
    raise Exception('You must define API_KEY and API_SECRET environment variables')

app = Flask(__name__)
opentok = OpenTok(api_key, api_secret)
session = opentok.create_session()


@app.route("/")
def hello():
    key = api_key
    session_id = session.session_id
    token = opentok.generate_token(session_id)
    return render_template('index.html', api_key=key, session_id=session_id, token=token,
                           csio_app_id=__APP_ID, csio_app_secret=__APP_SECRET)

if __name__ == "__main__":
    isDebug = False
    if __TARGET == 'local':
        isDebug = True
    app.run(host='0.0.0.0', port=__PORT, debug=isDebug, ssl_context='adhoc')
