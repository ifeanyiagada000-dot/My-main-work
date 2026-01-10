FROM python:3.10-slim-bullseye

# 1. Install Basics
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git python3-pip ffmpeg aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 👇 2. THE CRITICAL FIX (Create a Non-Root User)
RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"

# 3. Copy Files (Give ownership to the user)
COPY --chown=user . /app

# 4. Install Requirements
RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# 5. Hugging Face Port
ENV PORT=7860
EXPOSE 7860

# 6. Start Command
CMD ["python3", "main.py"]
