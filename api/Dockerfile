FROM python:alpine3.20
COPY . /app
WORKDIR /app
RUN pip install poetry
Run poetry install
EXPOSE 5000
CMD poetry run flask run --host=0.0.0.0