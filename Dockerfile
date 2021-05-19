# Start with a Linux micro-container to keep the image tiny
# FROM alpine:3.7
FROM python:3.8

# Document who is responsible for this image
MAINTAINER Mengyang Zhang "mz2325@nyu.edu"

# Install just the Python runtime (no dev)
# RUN apk add --no-cache \
#     python \
#     py-pip \
#     ca-certificates
RUN apt-get update \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Expose any ports the app is expecting in the environment
ENV PORT 8002
EXPOSE $PORT

# Set up a working folder and install the pre-reqs
WORKDIR /app
ADD requirements.txt /app
ADD ./images /app/images
RUN pip install -r requirements.txt
# RUN pip install --upgrade pip \
    # && pip install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

# Add the code as the last Docker layer because it changes the most
ADD neural_style_transfer.py  /app/neural_style_transfer.py

# Run the service
CMD [ "python", "neural_style_transfer.py" ]

