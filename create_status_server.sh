#!/bin/bash

# Create the Python web server script (status_server.py)
cat << 'EOF' > /opt/status_server.py
from http.server import BaseHTTPRequestHandler, HTTPServer

class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'OK')

def run(server_class=HTTPServer, handler_class=SimpleHandler, port=8888):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()
EOF

# Create the systemd service file for status_server
cat << 'EOF' > /etc/systemd/system/status_server.service
[Unit]
Description=Status Server
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/status_server.py
WorkingDirectory=/opt
Restart=always
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
echo "Reloading systemd to apply the new service..."
systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling the service to start on boot..."
systemctl enable status_server.service

# Start the service
echo "Starting the status server..."
systemctl start status_server.service

# Confirm the service is running
systemctl status status_server.service
