FROM python:3.8-alpine

ARG HELLOPKG=flask_hello_world-1.0-py3-none-any.whl

COPY dist/${HELLOPKG} .
RUN pip --no-cache-dir install -U pip \
    && pip --no-cache-dir install "${HELLOPKG}" \
    && pip install gunicorn \
    && rm "${HELLOPKG}"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV MYNAME Docker-Hello-kun

EXPOSE 8000

CMD ["/usr/local/bin/gunicorn", "-b", "0:8000", "hello.main"]
