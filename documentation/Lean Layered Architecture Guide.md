Lean Layered Architecture Guide
===============================

Welcome to our Lean Layered Architecture guide for developing microservices using NestJS. This architecture is designed to streamline the development process, reduce complexity, and ensure that our microservices remain maintainable and scalable. Below you will find a comprehensive breakdown of the folder structure and the responsibilities of each layer.

Overview
--------

Lean Layered Architecture simplifies the traditional multi-layered architecture by merging related functionalities into fewer layers. This approach is particularly suited for small to medium-sized microservices where excessive granularity could hinder rather than help development efforts.

Folder Structure
----------------

Here's an overview of the folder structure for our microservices:

bash

Copy code

```
/src
|-- /controllers                 # Controllers that handle incoming HTTP requests
|-- /services                    # Services that contain business logic and application rules
|-- /api-services                # Services that interact with external APIs
|-- /repositories                # Data access layers that interact with the database
|-- /models                      # Data models that define the structure of database entities
|-- /dtos                        # Data Transfer Objects for handling and validating data input/output
|-- /config                      # Configuration files and environment variable management
|-- /middlewares                 # Middleware that handle requests/responses before they reach the controllers or after they leave the controllers
/main.ts                         # Entry point of the application

```

### Controllers (`/controllers`)

Controllers are responsible for handling incoming HTTP requests and sending responses back to the client. They act as the entry point for interactions with the microservice.

*   **Responsibilities**:
    *   Validate incoming data.
    *   Call appropriate services.
    *   Handle HTTP responses.

### Services (`/services`)

Services contain the core business logic of the microservice. They are called by controllers and are responsible for processing data, executing business rules, and calling repositories.

*   **Responsibilities**:
    *   Execute business rules and logic.
    *   Call repositories to access and manipulate database data.
    *   Return results to controllers.


### API Services (`/api-services`)

API Services are responsible for interacting with external APIs. They handle the communication with external services, process the data, and return the results to the calling services.

*   **Responsibilities**:
    *   Communicate with external APIs.
    *   Process and transform data from external services.
    *   Return results to the calling services.
    
### Repositories (`/repositories`)

Repositories abstract the interaction with the database. They provide methods to retrieve data from and persist data to the database, hiding the details of the data source.

*   **Responsibilities**:
    *   Perform database operations.
    *   Ensure data integrity and transactions.
    *   Provide methods for data retrieval and updates.

### Models (`/models`)

Models define the structure of data within the application, usually mirroring database tables. They can include methods for business logic related to the data they represent.

*   **Responsibilities**:
    *   Define data structures.
    *   Possibly include methods for basic data manipulation and validation.

### Data Transfer Objects (DTOs) (`/dtos`)

DTOs are used to structure the data input and output, serving as data containers. They ensure that data sent to the client or received from client requests is correctly formatted and validated.

*   **Responsibilities**:
    *   Define the schema of data exchange.
    *   Validate and sanitize data input/output.

### Configuration (`/config`)

This directory holds configuration files that manage settings like database connection info, API keys, and other environment-specific variables.

*   **Responsibilities**:
    *   Manage application settings.
    *   Ensure sensitive credentials are secured and not hard-coded in the application.

### Main Entry (`main.ts`)

This is the entry point for the NestJS application. It sets up the HTTP server and connects middleware, routes, and services.

*   **Key Setup Steps**:
    *   Bootstrap the NestJS application.
    *   Set global configurations like global pipes for validation.

Conclusion
----------

This architecture is designed to keep each microservice simple yet efficient, focusing on maintainability and scalability. By following this guide, developers can ensure consistent development practices across all microservices, making our systems easier to manage and evolve.

