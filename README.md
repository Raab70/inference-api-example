# Machine Learning Inference API Example - Flask + Scikit-Learn + Docker
This repository contains an example machine learning inference API to serve a scikit-learn
model using Flask and Docker. It is based on [this blog post](https://unsupervisedpandas.com/python/deploying-machine-learning-models/)
and is intended as supporting material for [this talk at PyTennessee 2020](https://2020.pytennessee.org/talks/deploying-machine-learning-models-with-flask-and-docker) whose slides are [here](https://docs.google.com/presentation/d/1aL9tPMkXw9AVvccuAPW4uToIxAjNe2GsniqTzNM0otk/edit?usp=sharing)

## Getting Started
This repository utilizes a Makefile for easy interaction. You can view available commands by
simply running `make` without a target. Running `make run` will build a docker image,
train a model and start the inference API server. You can then test the server with
the excellent [httpie](https://httpie.org/):
```sh
❯ http POST localhost:5000 data="Ferari is the best sports car"
HTTP/1.0 200 OK
Content-Length: 28
Content-Type: application/json
Date: Fri, 28 Feb 2020 20:01:30 GMT
Server: Werkzeug/1.0.0 Python/3.8.2

{
    "result": "rec.autos"
}
```

or with cURL:
```sh
❯ curl -H 'Content-Type:application/json' -d '{"data": "Ferrari is the best sports car"}' localhost:5000
{
  "result": "rec.autos"
}
```

## Overview
This repository contains two scripts:
* `create_model.py` downloads the 20 newsgroups datasets and trains a simple classifier, it saves
the results to a file named `pipeline.pkl`. This model is based on Scikit-Learn's [introduction
to working with text data](https://scikit-learn.org/stable/tutorial/text_analytics/working_with_text_data.html)
* `api.py` creates an inference API by loading the model into module-level memory at startup and
calculating predictions based on the loaded model for each incoming request.

This repository uses [Docker](https://www.docker.com/)
and [docker-compose](https://docs.docker.com/compose/) to make the
API portable. However, we do not embed the `pipeline.pkl` model data
into the docker image. This is accomplished with the `.dockerignore`,
This is beacuse models can be large
and future improvements could include loading new models,
potentially through an API endpoint. Instead this file is provided
through the volume mount in docker-compose.
