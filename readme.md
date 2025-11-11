services:
  db:
    image: siddhussoft136/assignments:db
    container_name: webapp_db
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: appdb
      MYSQL_USER: appuser
      MYSQL_PASSWORD: apppass
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql
    networks:
      - my_Nodejs_nginx_mysql_network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uappuser", "-papppass"]
      interval: 10s
      retries: 5
 
  backend:
    image: siddhussoft136/assignments:backend
    container_name: backend
    environment:
      DB_HOST: db
      DB_PORT: 3306
      DB_USER: appuser
      DB_PASSWORD: apppass
      DB_NAME: appdb
    networks:
      - my_Nodejs_nginx_mysql_network
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "3000:3000"
 
  frontend:
    image: siddhussoft136/assignments:frontend
    container_name: webapp_frontend
    depends_on:
      - backend
    ports:
      - "8080:80"
    networks:
      - my_Nodejs_nginx_mysql_network
 
volumes:
  mysql-data:
 
networks:
  my_Nodejs_nginx_mysql_network:
    driver: bridge

# Copy the above script in docker-compose.yaml file and hit below command 
## docker-compose up --build

    -> open http://localhost:8080 to view the frontend
    -> open http://localhost:3000/api/items to view backend