FROM python:2.7

WORKDIR /code

ADD app/ /code
RUN pip install -r requirements.txt

CMD ["python","helloworld.py"]