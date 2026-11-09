# Ollama local AI

Install Ollama in the **Guest** from https://ollama.com/download/windows.

```powershell
ollama --version
ollama list
ollama pull qwen3:4b
ollama run qwen3:4b
```

In another Guest PowerShell window:

```powershell
ollama ps
```

Inspect the PROCESSOR column to determine CPU/GPU placement. **GPU-P Ollama inference has not yet been verified.**

A Modelfile supplies instructions but does not train model weights or create persistent memory. RAG retrieves documents; fine-tuning requires separate training tools.

An `ollama launch codex` attempt returned HTTP 402 Payment Required, consistent with selecting a paid cloud route. This does not establish failure of the local model. No keys or credentials are published.