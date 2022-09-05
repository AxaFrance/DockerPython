FROM ubuntu:22.10

# Install base utilities
RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH


COPY /ci_dependencies.yaml /setup/

# activate environment
ENV PATH /usr/local/envs/mlopspython_ci/bin:$PATH

RUN conda update -n base -c defaults conda 
RUN conda install python=3.8.3 -k
RUN conda env create -f /setup/ci_dependencies.yaml -v --yes -k
RUN /bin/bash -c "source activate mlopspython_ci" 
RUN az --version
RUN chmod -R 777 /usr/local/envs/mlopspython_ci/lib/python3.8