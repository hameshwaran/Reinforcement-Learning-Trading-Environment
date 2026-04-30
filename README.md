<div align="center">
  <h1>🤖 Quant RL Trading Environment</h1>
  <p><i>A production-grade, full-stack Reinforcement Learning trading simulator built for quantitative finance.</i></p>
  
  <p>
    <img src="https://img.shields.io/badge/Python-3.9+-blue.svg" alt="Python Version" />
    <img src="https://img.shields.io/badge/FastAPI-0.100+-green.svg" alt="FastAPI" />
    <img src="https://img.shields.io/badge/React-18.0+-61dafb.svg" alt="React" />
    <img src="https://img.shields.io/badge/PyTorch-2.0+-ee4c2c.svg" alt="PyTorch" />
    <img src="https://img.shields.io/badge/License-MIT-purple.svg" alt="License" />
  </p>
</div>

---

## 📖 Overview

This project trains an Artificial Intelligence agent using **Proximal Policy Optimization (PPO)** to make continuous portfolio allocation decisions. It navigates realistic market physics like slippage and transaction costs, maximizing risk-adjusted returns using Wall Street standard metrics.

The architecture features a high-performance Python/PyTorch backend wrapped in a beautiful, dynamic React desktop application.

## ✨ Key Features

* **🧠 Continuous Action Space**: Unlike basic models that just output "Buy" or "Sell", this agent predicts continuous target portfolio weights (ranging from `-100%` Short to `+100%` Long) for dynamic capital allocation.
* **📉 Advanced Reward Shaping**: The agent isn't just rewarded for raw profit. It is optimized using online approximations of the **Differential Sharpe Ratio** and **Sortino Ratio**, forcing it to learn true risk-adjusted strategies.
* **📊 Quantitative State Space**: Processes raw OHLCV data into non-stationary technical features, including Log Returns, 20-day Realized Volatility, MACD, and RSI.
* **💸 Realistic Frictions**: Accurately models percentage-based transaction fees and market slippage to prevent the AI from exploiting high-frequency "churning" illusions.
* **🏆 Professional Benchmarking**: The custom backtest engine pits the trained AI directly against classic quantitative strategies: *Buy & Hold*, *Random*, *MACD Crossover*, and *Bollinger Mean-Reversion*.
* **🖥️ Native Desktop App**: Packaged with a native window wrapper (`pywebview`) and a single-click batch launcher for an instant, terminal-free user experience.

---

## 🚀 Quick Start (Windows)

This application is bundled with a fully automated setup script. You do not need to use the terminal.

1. Clone the repository to your machine.
2. Ensure you have **Python 3.9+** and **Node.js** installed on your system.
3. Double-click the **`Run_Trading_App.bat`** file.

**That's it!** On the first run, the script will automatically create a virtual environment, install all Python and Node dependencies, compile the React interface, generate sample market data, and instantly snap open the native Desktop window. On subsequent runs, it will launch like a flash.

---

## 💻 Manual Installation (Mac / Linux)

If you prefer to run the components manually or are on a UNIX system:

### 1. Backend Setup
```bash
# Create and activate virtual environment
python -m venv backend/venv
source backend/venv/bin/activate  # On Mac/Linux
# backend\venv\Scripts\activate   # On Windows

# Install Python dependencies
pip install -r backend/requirements.txt

# Generate sample SPY and BTC data
python sample_data/generate_sample.py
```

### 2. Frontend Setup
```bash
cd frontend
npm install
npm run build
cd ..
```

### 3. Launch Application
```bash
# The app will detect the built frontend and launch the native desktop window
python app.py
```

---

## 📈 Using Your Own Data

The system accepts any standard financial CSV file. 
1. Open the application.
2. Drag and drop your `.csv` file into the **Dataset** upload zone.
3. The file must contain the following lowercase columns: `date`, `open`, `high`, `low`, `close`, `volume`.

The backend will automatically engineer all necessary features (Moving Averages, Volatility, Log Returns) on the fly.

---

## 🔬 Evaluation Metrics

The built-in backtesting engine automatically computes professional quantitative metrics:
* **Total Return & Max Drawdown**
* **Sharpe Ratio** (Risk-adjusted performance)
* **Sortino Ratio** (Downside risk-adjusted performance)
* **Information Ratio** (Active return compared against the Buy & Hold benchmark)
* **Profit Factor** (Gross Profits / Gross Losses)
* **Win Rate**

---

## 📂 Project Architecture

```text
├── backend/
│   ├── agent/         # PPO Agent wrapper and Training Callbacks
│   ├── api/           # FastAPI endpoints (Train, Predict, Backtest)
│   ├── backtesting/   # Backtest Engine, Baseline Strategies, Metrics
│   ├── data/          # CSV Loaders, Feature Engineering, Preprocessing
│   ├── env/           # Custom Gymnasium Trading Environment & Rewards
│   └── config.py      # Global Hyperparameters
├── frontend/          # React + Vite UI (Price Charts, Dashboards)
├── sample_data/       # Synthetic data generation scripts
├── app.py             # Desktop Window Wrapper entry point
└── Run_Trading_App.bat# One-click automated launcher for Windows
```

---

## 📝 License
This project is open-source and available under the **MIT License**. Feel free to use and modify it for personal, academic, or commercial quantitative projects.
