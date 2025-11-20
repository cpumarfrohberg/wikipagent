# Wikipedia Agent

A Streamlit application for querying Wikipedia using an AI agent.

## Prerequisites

- Docker and Docker Compose installed
- OpenAI API key

## Setup

1. Create a `.env` file in the project root with your OpenAI API key:

```bash
OPENAI_API_KEY=your_api_key_here
```

Optional environment variables:
```bash
OPENAI_RAG_MODEL=gpt-4o-mini
OPENAI_JUDGE_MODEL=gpt-4o
LOG_LEVEL=INFO
```

## Running with Docker

Build and start the application:

```bash
docker compose up --build
```

The application will be available at `http://localhost:8501`

## Stopping the Application

Press `Ctrl+C` to stop, or run:

```bash
docker compose down
```
