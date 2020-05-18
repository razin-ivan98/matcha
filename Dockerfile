FROM python:3

WORKDIR /usr/src/app

COPY py-dependencies.txt ./
RUN pip install --no-cache-dir -r py-dependencies.txt

COPY . .

CMD [ "python", "./run.py" ]
