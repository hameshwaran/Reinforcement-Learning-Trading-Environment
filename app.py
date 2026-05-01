import os
import sys
import threading
import time
import socket
import uvicorn
from pathlib import Path
import webbrowser

try:
    import webview
    HAS_WEBVIEW = True
except ImportError:
    HAS_WEBVIEW = False

from backend.api.main import app
from backend.config import API_CONFIG

def start_server():
    """Start the FastAPI server via Uvicorn."""
    print("Starting local server...")
    uvicorn.run(
        app, 
        host=API_CONFIG["host"], 
        port=API_CONFIG["port"], 
        log_level="error" # Keep console clean
    )

def wait_for_port(port: int, host: str = '127.0.0.1', timeout: float = 5.0) -> bool:
    """Wait until a port starts accepting connections."""
    start_time = time.time()
    while True:
        try:
            with socket.create_connection((host, port), timeout=0.1):
                return True
        except OSError:
            time.sleep(0.05)
            if time.time() - start_time > timeout:
                return False

if __name__ == '__main__':
    # Make sure we don't start the webview if not running as main script
    
    # 1. Start the FastAPI server in a background daemon thread
    server_thread = threading.Thread(target=start_server)
    server_thread.daemon = True
    server_thread.start()
    
    # Wait for server to bind port (dynamic wait instead of slow hardcoded sleep)
    wait_for_port(API_CONFIG["port"])
    
    # 2. Create and start the native window wrapper or fallback to browser
    url = f"http://127.0.0.1:{API_CONFIG['port']}"
    
    if HAS_WEBVIEW:
        print(f"Opening desktop application window at {url}...")
        window = webview.create_window(
            title='RL Trading Environment Pro', 
            url=url,
            width=1280,
            height=800,
            min_size=(1024, 600),
            background_color='#0d1117' # Match the app's dark theme
        )
        
        # Start the GUI loop
        webview.start(private_mode=False) # Keep local storage intact between sessions
    else:
        print(f"Opening application in default web browser at {url}...")
        webbrowser.open(url)
        
        # Keep the main thread alive since uvicorn is running in a daemon thread
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Shutting down...")
