ARG BUILDER_IMAGE=rootproject/root:6.26.02-ubuntu20.04
FROM ${BUILDER_IMAGE} as builder

USER root
WORKDIR /usr/local

SHELL [ "/bin/bash","--login","-c"]

RUN apt-get -qq -y update && \
    apt-get -qq -y install --no-install-recommends \
      gcc \
      g++ \
      gfortran \
      make \
      cmake \
      vim \
      rsync \
      bash-completion \
      python3-dev \
      python3-pip \
      python3-tk \
      python3.10 \
      wget \
      ghostscript \
      rsync \
      wget\ 
      git && \
    apt-get -y clean && \
    #apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10


# Enable tab completion by uncommenting it from /etc/bash.bashrc
# The relevant lines are those below the phrase "enable bash completion in interactive shells"
RUN export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
    sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
    unset SED_RANGE

# Create user "docker"
RUN useradd --shell /bin/bash -m docker && \
   cp /root/.bashrc /home/docker/ && \
   chown -R --from=root docker /home/docker && \
   chown -R --from=root docker /usr/local/share 


# Folder for volume sharing
RUN mkdir /data && chmod a+rwx /data




# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV HOME /home/docker
WORKDIR ${HOME}/install_data

ADD requirements.txt .

RUN cp /root/.profile ${HOME}/.profile && \
    cp /root/.bashrc ${HOME}/.bashrc && \
    echo "" >> ${HOME}/.bashrc && \
    echo 'export PATH=${HOME}/.local/bin:$PATH' >> ${HOME}/.bashrc && \
    python -m pip --no-cache-dir install --upgrade pip setuptools wheel && \
    python -m pip --no-cache-dir install -r requirements.txt
    # python -m pip --no-cache-dir install six numpy && \

# Switch to docker user
ENV USER docker
USER docker
#ENV PYTHONPATH=/usr/local/lib
#ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
#ENV PATH=${HOME}/.local/bin:$PATH



USER root 
RUN python -m pip --no-cache-dir install --upgrade jupyter 

RUN mkdir /home/docker/.local && chmod a+rwx -R /home/docker/.local

#COPY mltutorial.yml . 

#RUN "conda env create -f mltutorial.yml"
#RUN "conda init bash"
#RUN "conda activate mltutorial"

USER docker
# Default working is the volume shared folder
WORKDIR /data
ENV OUTDIR /data

ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/bin/bash"]
