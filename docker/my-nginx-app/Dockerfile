# Use a lightweight Nginx base image
FROM nginx:alpine

# Remove default Nginx configuration
# This removes the default Nginx configuration file so we can replace it.
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom Nginx configuration
# This copies your custom nginx.conf file into the correct location inside the Nginx container.
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the static HTML content into the Nginx web root
# This puts your index.html file where Nginx expects to find it for serving web content.
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 for web traffic
# This tells Docker that the container will listen on port 80.
EXPOSE 80

# Command to run Nginx when the container starts
# This command ensures Nginx runs in the foreground, which is necessary for Docker containers.
CMD ["nginx", "-g", "daemon off;"]
