FROM python:3.8-alpine
LABEL MAINTAINER="Hamed Daneshvar | Hameddaneshvar3@gmail.com"

ENV PYTHONUNBUFFERED 1

RUN mkdir /blogpy
WORKDIR /blogpy

COPY . /blogpy/
ADD requirments/requirments.txt /blogpy/
RUN pip install --upgrade pip
RUN pip install -r requirments.txt
RUN pip install psycopg2-binary==2.8.6

RUN python manage.py collectstatic --no-input

CMD [ "gunicorn", "--chdir", "blogpy", "--bind", ":8000", "blogpy.wsgi:application" ]