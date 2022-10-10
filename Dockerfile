FROM pytorch/pytorch:latest

# Install nodejs for jupyterlab
RUN apt-get update
RUN apt-get -y install curl git
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get -y install nodejs

# Install required libraries
# notebook_loginができるようにがんばったができなさそうなのでやめた。
RUN pip install --upgrade pip
RUN pip install \
        ipywidgets  jupyterlab jupyter_http_over_ws \
        diffusers==0.4.0 transformers scipy ftfy 
        # "git+https://github.com/googlecolab/colabtools" httplib2

# Install jupyter extensions
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension \
 && jupyter labextension install @jupyter-widgets/jupyterlab-manager

RUN jupyter serverextension enable --py jupyter_http_over_ws

# COPY super_simple_stable_diffusion.ipynb /workspace/
COPY jupyter_notebook_config.py /root/.jupyter/
COPY sed_filter.py /workspace/
RUN python3 sed_filter.py /opt/conda/lib/python3.7/site-packages/diffusers/pipelines/stable_diffusion/pipeline_stable_diffusion.py
