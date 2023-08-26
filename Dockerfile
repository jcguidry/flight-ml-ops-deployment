# Use the official Python image from the DockerHub
FROM python:3.8-slim

# Set the maintainer label
# LABEL maintainer="your_email@example.com"

# Set the working directory in docker
WORKDIR /app

# Install build essentials for packages that require compilation (gcc)
RUN apt-get update && \
    apt-get install -y gcc python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt

# For Jupyter and ipykernel
RUN pip install jupyter ipykernel

# Set up the environment for Jupyter
RUN python -m ipykernel.kernelspec

# Expose port 8888 for Jupyter Notebook
EXPOSE 8888


# This command only runs when you start the container locally with "docker run"
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

# docker build -t jupyter-container .
# docker run -p 8888:8888 jupyter-container
# docker run -p 8888:8888 -v /path/to/my/repo:/workspace jupyter/base jupyter-container
