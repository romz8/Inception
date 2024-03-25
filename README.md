## Inception

Inception is a 42 school's project aimed at deploying a small infrastructure composed of various services encapsulated in `Docker` containers. This setup includes a secure Nginx server, WordPress with php-fpm, and MariaDB, all orchestrated to work seamlessly together within a virtual machine environment using `docker compose`. 

## Status

Validated on 22/03/2024. Grade: 100%.

## **Project Structure**

```bash
.
├── Inception
│   ├── Makefile
│   └── srcs
│       ├── docker-compose.yml
│       └── requirements
│           ├── mariadb
│           │   ├── Dockerfile
│           │   ├── conf
│           │   │   └── my.cnf
│           │   └── tools
│           │       └── init_mariadb.sh
│           ├── nginx
│           │   ├── Dockerfile
│           │   └── conf
│           │       └── nginx.conf
│           └── wordpress
│               ├── Dockerfile
│               ├── conf
│               │   └── wp_www.conf
│               └── tools
│                   └── init_wp.sh

```

## **Requirements**

- **Docker and Docker Compose**: The project relies on Docker to containerize each service and `docker compose` to manage the multi-container setup.
- **Virtual Machine**: The entire infrastructure should be deployed within a virtual machine environment.
- **Debian or Alpine**: Containers must be built using either the penultimate stable version of Debian or Alpine for performance considerations.

## **Setup Instructions**

1. **Clone Repository**: Clone this repository to your local machine to begin the setup.
    
    ```bash
    
    git clone <repository-url> inception-project
    cd inception-project
    ```
    
2. **Environment Variables**: Configure the necessary environment variables in the **`.env`** file within the **`srcs`** directory. The `.env` should not be part of the git, but I left it here is for exercise purposes.
3. **Build and Run Containers**:
Utilize the Makefile to build Docker images and run the containers.
    
    ```bash
    
    make
    make stop
    make clean 
    make wipeout 
    ```
    
    This will use **`docker-compose.yml`** to orchestrate the setup and run the services as defined.

- `make` : build Docker images and then run the containers in detached mode.
- `make stop` : Use this command when you want to temporarily halt all services without removing their data.
- `make clean` : stop all running services, then completely removes the containers, networks, and volumes associated with the project as defined in the Docker Compose file.
- `make wipeout`: The most aggressive cleanup command in the Makefile. It stops all Docker containers currently running on your system (not just those related to this project), removes all unused Docker images, networks, and volumes, and then explicitly removes all Docker volumes. Use this command with caution as it will affect all Docker containers and data on your system, not just those associated with the project.
    

## **Services**

- **Nginx**: Configured to serve content over HTTPS using TLSv1.2 or TLSv1.3.
- **WordPress + php-fpm**: WordPress is set up with php-fpm, without Nginx in the container.
- **MariaDB**: Runs in its dedicated container, storing data persistently in a Docker volume.
- **Volumes**: Two volumes are created; one for the WordPress database and another for the WordPress website files. They are mounted to local volumes, ensuring data persistence.
- **Docker Network**: A custom network facilitates communication between containers without using host networking or deprecated linking options.

## **Best Practices and Restrictions**

- **Dockerfiles**: Custom Dockerfiles are written for each service, ensuring a tailored and optimized container setup.
- **No Pre-made Images**: The project prohibits the use of pre-made Docker images except for the base Debian or Alpine images.
- **Security**: TLS configurations are enforced for secure communications. WordPress's administrative user does not include common admin names to enhance security.
- **Persistence**: Data is made persistent through Docker volumes, ensuring the resilience and stability of the services.
- **Container Management**: Containers are configured to restart automatically in case of crashes, improving reliability.
