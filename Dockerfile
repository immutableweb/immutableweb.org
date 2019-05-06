FROM metabrainz/python:3.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /code
WORKDIR /code

RUN pip3.6 install setuptools uwsgi

RUN mkdir /code/iw
WORKDIR /code/iw

COPY requirements.txt /code/iw/
RUN pip3.6 install -r requirements.txt

RUN apt-get purge -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean -y

# Now install our code, which may change frequently
COPY . /code/iw/

CMD uwsgi --gid=www-data --uid=www-data --http-socket :3031 \
          --vhost --module=server --callable=app --chdir=/code/iw \
          --enable-threads --processes=15
