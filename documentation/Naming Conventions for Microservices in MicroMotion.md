# Naming Conventions for Microservices in Our System

### Purpose
This document aims to provide clear and consistent naming conventions for all microservices in our system. By adhering to these conventions, we ensure that the architecture remains organized, maintainable, and easily understandable. This is crucial for facilitating collaboration among team members and ensuring efficient development processes.

### Overview
Our microservices architecture includes different types of services, each serving specific functions within the system. To maintain clarity and organization, we will use specific prefixes for different categories of services. These categories include Frontend Services, Backend for Frontend (BFF) Services, Aggregator Services, and Core Services.

## Naming Conventions

### 1. Frontend Services
**Prefix**: `fe_`

**Description**: These services are responsible for the frontend or user interface aspects of our applications.

**Examples**:
- `fe_EmployeeDashboard`
- `fe_AdminPanel`
- `fe_CustomerPortal`

### 2. Backend for Frontend (BFF) Services
**Prefix**: `api_serviceName_bff`

**Description**: These services act as an intermediary between the frontend and the backend services. They aggregate data from various services and prepare it for the frontend.

**Examples**:
- `api_employeeDashboard_bff`
- `api_adminPanel_bff`
- `api_customerPortal_bff`

### 3. Aggregator Services
**Prefix**: `api_serviceName_aggregator`

**Description**: These services aggregate data and functionality from multiple core services into a cohesive unit. They simplify the frontend interaction by providing a unified interface to access multiple services.

**Examples**:
- `api_chat_aggregator`: Aggregates data from `api_chatbot_service` and `api_chatroom_service`.
- `api_finance_aggregator`: Aggregates data from `api_accountant_service` and `api_invoice_service`.

### 4. Core Services
**Prefix**: `api_serviceName_service`

**Description**: These services handle the core business logic and data operations of our system. They perform specific business functions and provide essential functionality.

**Examples**:
- `api_auth_service`
- `api_userProfile_service`
- `api_logging_service`
- `api_chatbot_service`
- `api_chatroom_service`
- `api_accountant_service`
- `api_invoice_service`

## Detailed Naming Examples

### Frontend Services
- **Employee Dashboard**: `fe_EmployeeDashboard`
- **Admin Panel**: `fe_AdminPanel`
- **Customer Portal**: `fe_CustomerPortal`

### BFF Services
- **Employee Dashboard BFF**: `api_employeeDashboard_bff`
- **Admin Panel BFF**: `api_adminPanel_bff`
- **Customer Portal BFF**: `api_customerPortal_bff`

### Aggregator Services
- **Chat Aggregator**: `api_chat_aggregator` (aggregates `api_chatbot_service` and `api_chatroom_service`)
- **Finance Aggregator**: `api_finance_aggregator` (aggregates `api_accountant_service` and `api_invoice_service`)
- **Notification Aggregator**: `api_notification_aggregator`

### Core Services
- **Authentication Service**: `api_auth_service`
- **User Profile Service**: `api_userProfile_service`
- **Logging Service**: `api_logging_service`
- **Chatbot Service**: `api_chatbot_service`
- **Chatroom Service**: `api_chatroom_service`
- **Accountant Service**: `api_accountant_service`
- **Invoice Service**: `api_invoice_service`

## Guidelines for Creating New Services

1. **Determine the Type**: Identify whether the new service is a Frontend, BFF, Aggregator, or Core service.
2. **Use the Appropriate Prefix**: Apply the prefix according to the type of service.
3. **Service Name**: Choose a descriptive name that clearly indicates the service's purpose.
4. **Documentation**: Ensure that each new service is documented with its purpose, responsibilities, and interactions with other services.

## Example Scenarios

### Adding a New Frontend Service
If we need a new frontend service for managing user settings, we would name it:
- `fe_UserSettings`

### Adding a New BFF Service
For a new admin reporting dashboard, the BFF service would be:
- `api_adminReporting_bff`

### Adding a New Aggregator Service
For aggregating analytics data, the service would be named:
- `api_analytics_aggregator`

### Adding a New Core Service
For a new payment processing service, the core service would be named:
- `api_payment_service`

## Importance of Consistent Naming
- **Clarity**: Clear names make it easier for developers to understand the purpose and function of each service.
- **Maintainability**: Consistent naming helps in maintaining the system and making future updates easier.
- **Collaboration**: Facilitates better collaboration and communication among team members.

## Conclusion
Adhering to these naming conventions will help ensure that our microservices architecture remains organized, maintainable, and understandable. All team members are encouraged to follow these guidelines when creating new services or updating existing ones.

If you have any questions or need further clarification, please refer to this document or contact the project lead.
