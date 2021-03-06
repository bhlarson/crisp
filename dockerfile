#FROM nvcr.io/nvidia/pytorch:21.12-py3-py3
FROM nvcr.io/nvidia/cuda:11.4.1-cudnn8-runtime-ubuntu20.04
LABEL maintainer="Brad Larson"

#USER root
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
    apt-get install -y python3-pip && pip3 install --upgrade pip && \
    apt-get install -y wget && \
    apt-get install -y libgl1-mesa-glx ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/*

#RUN useradd -D user
#USER user
#WORKDIR /home/user

RUN pip3 install --no-cache-dir \
        minio \
        tqdm \
        natsort \
        path \
        wget \
        configparser \
        prettytable \
        PyYAML \
        mlflow \
        debugpy \
        matplotlib \
        opencv-python \
        torch \
        torchvision \
        tensorboard \
        adabound

RUN echo 'alias py=python' >> ~/.bashrc

ENV LANG C.UTF-8
# port 3000 exposes debugger
EXPOSE 3000

# Launch training
#ENTRYPOINT ["python3", "networks/cell2d.py"]
RUN ["/bin/bash"]
