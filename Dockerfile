FROM jrottenberg/ffmpeg:4.1-vaapi as build-stage
FROM python:3-alpine

WORKDIR /usr/src/app/tesla_dashcam

RUN apk add --no-cache --update gcc libc-dev linux-headers \
 && apk add --no-cache --update tzdata ttf-freefont libnotify \
 && mkdir /usr/share/fonts/truetype \
 && ln -s /usr/share/fonts/TTF /usr/share/fonts/truetype/freefont

COPY . /usr/src/app/tesla_dashcam
RUN pip install -r requirements.txt

# Enable Logs to show on run
ENV PYTHONUNBUFFERED=true 
# Provide a default timezone
ENV TZ=America/New_York
# Add intel drivers
ENV LD_LIBRARY_PATH=/opt/intel/mediasdk/lib64:/lib

ENTRYPOINT [ "python3", "tesla_dashcam/tesla_dashcam.py" ]
