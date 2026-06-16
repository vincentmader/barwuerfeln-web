from datetime import datetime
from flask import Flask
from flask import render_template

app = Flask(
    __name__,
    static_url_path='',
    template_folder="../templates",
    static_folder="../static",
)


@app.context_processor
def inject_year():
    return {"current_year": datetime.now().year}


@app.route("/")
def index():
    return render_template("index.html", props={})


@app.route("/imprint")
def imprint():
    return render_template("imprint.html", props={})


@app.route("/privacy")
def privacy():
    return render_template("privacy.html", props={})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5020, debug=False)
