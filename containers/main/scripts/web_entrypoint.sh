#!/bin/sh
set -e
# NOTE the API_SCHEME, API_HOST, API_PORT env vars are required here
# cd $HOME/draftsmith_rs/draftsmith_flask  && \
#     source venv/bin/activate && \
#     cd draftsmith_flask && \
#     gunicorn -w 4 -b 0.0.0.0:${WEB_PORT} server:app

# Just use the global packages
cd $HOME/draftsmith_rs/draftsmith_flask  && \
    source ${FLASK_VENV}/bin/activate && \
    cd draftsmith_flask && \
    gunicorn -w 4 -b 0.0.0.0:${WEB_PORT} server:app
