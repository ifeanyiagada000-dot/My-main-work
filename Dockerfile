FROM python:3.10-slim-buster

# Install basics
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git python3-pip ffmpeg aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Force Port 7860 for Hugging Face
ENV PORT 7860
EXPOSE 7860

# Start Bot
CMD ["python3", "-m", "main"]
