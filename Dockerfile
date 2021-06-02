ARG SAGE_VERSION=9.2
ARG SAGE_PYTHON_VERSION=3.8

ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER


USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dvipng \
    imagemagick \
    tk tk-dev \
    ffmpeg \
    libcairo2-dev \
    libffi-dev \
    libpango1.0-dev \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-latex-recommended \
    texlive-science \
    texlive-fonts-extra \
    tipa && \
    rm -rf /var/lib/apt/lists/*


USER $NB_UID

# Initialize conda for shell interaction
RUN conda init bash

# Install matplotlib
RUN conda install --quiet --yes \
    'matplotlib=3.4.*' \
    'ipympl=0.7.*' \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install Manim
RUN pip install --no-cache-dir \
    manim \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install Sage conda environment
RUN conda install --quiet --yes -n base -c conda-forge widgetsnbextension && \
    conda create --quiet --yes -n sage -c conda-forge sage=$SAGE_VERSION python=$SAGE_PYTHON_VERSION && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install sagemath kernel
RUN mkdir -p /home/$NB_USER/.local/share/jupyter/kernels && \
    ln -s /opt/conda/envs/sage/share/jupyter/kernels/sagemath /home/$NB_USER/.local/share/jupyter/kernels/ 

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"
