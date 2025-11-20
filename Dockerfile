FROM python:3.11-slim

# Explicitly unset any host temp variables and set container temp directory
RUN mkdir -p /tmp && chmod 1777 /tmp

ENV TMPDIR=/tmp
ENV TEMP=/tmp
ENV TMP=/tmp
ENV TEMPDIR=/tmp
ENV NODE_TMPDIR=/tmp
ENV UV_CACHE_DIR=/tmp/.uv-cache

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p /tmp/.uv-cache && \
    env -u TMPDIR -u TEMP -u TMP -u TEMPDIR -u NODE_TMPDIR \
    TMPDIR=/tmp TEMP=/tmp TMP=/tmp TEMPDIR=/tmp NODE_TMPDIR=/tmp UV_CACHE_DIR=/tmp/.uv-cache \
    pip install uv

COPY pyproject.toml uv.lock ./

RUN env -u TMPDIR -u TEMP -u TMP -u TEMPDIR -u NODE_TMPDIR \
    TMPDIR=/tmp TEMP=/tmp TMP=/tmp TEMPDIR=/tmp NODE_TMPDIR=/tmp UV_CACHE_DIR=/tmp/.uv-cache \
    uv pip install --system -e .

COPY config/ ./config/
COPY wikiagent/ ./wikiagent/
COPY streamlit_app.py ./

ENV PYTHONUNBUFFERED=1

EXPOSE 8501

CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
