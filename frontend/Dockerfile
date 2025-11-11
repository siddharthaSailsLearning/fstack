FROM nginx:stable-alpine

#remove dependency issues with modifying configuration file

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY site /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
