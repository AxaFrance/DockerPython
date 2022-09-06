
FROM conda/miniconda3

LABEL org.label-schema.vendor = "Microsoft" \
    org.label-schema.url = "https://hub.docker.com/r/microsoft/mlopspython" \
    org.label-schema.vcs-url = "https://github.com/microsoft/MLOpsPython"

COPY ci_dependencies.yaml /setup/

# activate environment
ENV PATH /usr/local/envs/mlopspython_ci/bin:$PATH

RUN conda update -n base -c defaults conda && \
    conda install python=3.8.3 && \
    conda env create -f /setup/ci_dependencies.yaml && \
    /bin/bash -c "source activate mlopspython_ci" && \
    az --version && \
    chmod -R 777 /usr/local/envs/mlopspython_ci/lib/python3.8



