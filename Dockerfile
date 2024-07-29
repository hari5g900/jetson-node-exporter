## Dockerfile for Jetson Stats Node Exporter
# sources: https://rnext.it/jetson_stats/docker.html
#          https://github.com/laminair/jetson_stats_node_exporter
# Usage: See git hub documentation

# Base image, Python image
FROM python:3.11-slim

# Set environment variables (prevents writing .pyc files and buffering of stdout and stderr)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies (including gcc and python3-dev) and clean up to reduce image size
RUN apt-get update && apt-get install -y gcc python3-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt
RUN pip install -r ./app/requirements.txt
COPY jetson_stats_node_exporter /app
WORKDIR /app/
ENV PYTHONPATH=/app

EXPOSE 9400
# Install the Jetson Stats Node Exporter
# --> Insert the version you want to install and which fits your system requirements
# RUN pip3 install -U https://github.com/laminair/jetson_stats_node_exporter/releases/download/v0.0.6/jetson_stats_node_exporter-0.0.6-py3-none-any.whl

# Set the start command
CMD ["python3", "__main__.py"]