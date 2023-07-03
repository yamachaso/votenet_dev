FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN rm -f /etc/apt/sources.list.d/cuda.list \
 && apt-get update && apt-get install -y --no-install-recommends \
        wget \
 && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb \
 && dpkg -i cuda-keyring_1.0-1_all.deb \
 && rm -f cuda-keyring_1.0-1_all.deb

# ref: https://dev.classmethod.jp/articles/apt-get-magic-spell-in-docker/
# UbuntuやDebianの公式イメージでは clean は自動で設定されているが一応コマンドも打っておく
RUN apt-get update
RUN apt-get install -y \
    python3 python3-pip libopencv-dev sudo gosu \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ~/.local/lib/python3.8/site-packagesではなく
# 
# opencvはpipが古いバージョンだとビルドできない
RUN pip3 install --upgrade pip
RUN pip3 install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1 -f https://download.pytorch.org/whl/cu111/torch_stable.html
RUN pip3 install numpy==1.23.1 wheel plyfile trimesh==2.35.39 matplotlib opencv-python
# RUN pip uninstall networkx
RUN pip install networkx==2.2


# ARG BUILD_USER
#ENV USER appuser
#ENV HOME /home/${USER}
#ENV PASS password
#ENV PATH=${HOME}/.local/bin:${PATH}
#RUN useradd -s /bin/bash ${USER}
#RUN usermod -d ${HOME} ${USER}
# RUN gpasswd -a ${USER} sudo
# RUN mkdir -p /home/${USER}/votenet
# RUN chown -R ${USER} ${HOME}
# RUN echo "${USER}:${PASS}" | chpasswd
# USER ${USER}


WORKDIR /home/appuser


COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

