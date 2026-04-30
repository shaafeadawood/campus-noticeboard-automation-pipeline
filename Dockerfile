FROM nginx:alpine
COPY src/ /usr/share/nginx/html/
COPY styles/ /usr/share/nginx/html/styles/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
