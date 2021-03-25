import os
import sys
import click
from werkzeug.serving import run_simple
from flask import Flask, jsonify, request, render_template, redirect, session, url_for, flash
from werkzeug.exceptions import NotFound, InternalServerError, BadRequest, Unauthorized
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)
app.wsgi_app = ProxyFix(app.wsgi_app)

app.config.update(dict(
    PROPAGATE_EXCEPTIONS=True,
    STATIC_PATH = "/static",
    STATIC_FOLDER = "static",
    TEMPLATE_FOLDER = "templates"
))

cli = click.Group()

@cli.command()
@click.option("--host", "-h", default="0.0.0.0", show_default=True)
@click.option("--port", "-p", default=8080, show_default=True)
@click.option("--debug", "-d", is_flag=True,
              help="Turns debugging mode on or off. If specified, overrides "
                   "'DEBUG' value in the config file.")
def runserver(host, port, debug=False):
    app.debug = debug
    run_simple(
        hostname=host,
        port=port,
        application=app,
        use_debugger=debug,
        use_reloader=debug,
        processes=5
    )

@app.route('/', methods=['GET'])
def index():
    return render_template("index.html")

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=80)
