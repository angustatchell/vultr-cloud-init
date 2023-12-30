# Use Alpine Linux as the base image
FROM alpine:latest

# Update the package list and install WireGuard
RUN apk add --no-cache wireguard-tools

# Copy the WireGuard configuration files into the container
# Ensure you have a wg0.conf file in the same directory as this Dockerfile
COPY wg0.conf /etc/wireguard/

# Expose the WireGuard port
# Replace 51820 with your WireGuard server's port if it's different
EXPOSE 51820/udp

# Start the WireGuard server using wg-quick
ENTRYPOINT ["wg-quick", "up", "wg0"]

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
