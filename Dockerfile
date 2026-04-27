FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1
WORKDIR /build

COPY requirements.txt .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install -r requirements.txt

FROM python:3.12-slim AS runtime
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"
RUN groupadd --system app \
    && useradd --system --gid app --create-home --home-dir /home/app app
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv

COPY . .

RUN chown -R app:app /app
USER app

EXPOSE 5001

CMD ["python", "app.py"]
