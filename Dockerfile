From nvidia/cudagl:10.0-runtime-ubuntu18.04

Run sed -i 's/archive.ubuntu.com/jp.archive.ubuntu.com/' /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive

RUN rm -f /etc/apt/sources.list.d/cuda.list \
 && apt-get update && apt-get install -y --no-install-recommends \
    wget \
 && distro=$(. /usr/lib/os-release; echo $ID$VERSION_ID | tr -d ".") \
 && arch=$(/usr/bin/arch) \
 && wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.0-1_all.deb \
 && dpkg -i cuda-keyring_1.0-1_all.deb \
 && rm -f cuda-keyring_1.0-1_all.deb
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    vim  \
    tzdata git freeglut3-dev
ENV TZ=Asia/Tokyo

RUN chmod 777 /opt

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


USER $USERNAME
WORKDIR /opt

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/miniconda3/bin:$PATH

WORKDIR /home/$USERNAME

ENV ENV_FILE=https://github.com/icoxfog417/baby-steps-of-rl-ja/raw/master/environment.yml
ENV ENV_FILE_NAME=environment.yml

RUN wget $ENV_FILE
RUN pip install --upgrade pip && \
    conda update -n base -c defaults conda && \
    conda env create -n rl-book -f $ENV_FILE_NAME && \
    conda init && \
    echo "conda activate rl-book" >> ~/.bashrc
RUN rm $ENV_FILE_NAME

ENV CONDA_DEFAULT_ENV rl-book
ENV PATH /opt/conda/envs/rl-book/bin:$PATH

RUN echo '######### start setup #########' >> /home/$USERNAME/setup.sh
RUN echo 'git clone https://github.com/icoxfog417/baby-steps-of-rl-ja.git' >> /home/$USERNAME/setup.sh
RUN echo 'cd baby-steps-of-rl-ja' >> /home/$USERNAME/setup.sh
RUN echo 'pip install -r requirements.txt' >> /home/$USERNAME/setup.sh
RUN echo '######### done #########' >> /home/$USERNAME/setup.sh

CMD ["/bin/bash"]

USER root
RUN conda clean --all -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER $USERNAME
