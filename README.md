# Trionda — J2EE Ticketing Web Application

Trionda is a Java web application for managing football match ticket booking built with Jakarta Servlet, JSP, JDBC, and MySQL. The project was developed as a J2EE learning application and demonstrates common enterprise web architecture patterns such as DAO, Service, Facade, Factory, Strategy, Decorator, Observer, and Filter.

## Overview

Trionda provides two main user roles:

- **Customer**: view matches, view match details, book tickets, view booking history, and cancel bookings.
- **Admin**: monitor dashboard metrics, manage matches, view bookings, and close/open matches.

## Main Features

### Customer Features
- User registration and login
- Browse available matches
- View match details with ticket categories
- Confirm and submit ticket bookings
- See booking history
- Cancel an existing booking

### Admin Features
- Admin dashboard with revenue, customer, match, and booking summaries
- Manage match list
- Create new matches with ticket categories
- Open or close matches
- View all bookings

## Technology Stack

- **Java 17**
- **Jakarta Servlet 6.0**
- **JSP / JSTL**
- **Maven**
- **MySQL 8**
- **Tomcat 10.1+**

## Project Structure

- `src/main/java/com/trionda/servlet` — Controllers / servlet handlers
- `src/main/java/com/trionda/service` — Business logic services
- `src/main/java/com/trionda/dao` — Data access layer interfaces and implementations
- `src/main/java/com/trionda/model` — Domain entities
- `src/main/java/com/trionda/facade` — Booking facade for simplified access
- `src/main/java/com/trionda/factory` — Factory design patterns
- `src/main/java/com/trionda/strategy` — Pricing strategies
- `src/main/java/com/trionda/decorator` — Logging decorator for booking operations
- `src/main/java/com/trionda/observer` — Observers for audit and sold-out notifications
- `src/main/java/com/trionda/filter` — Authentication filter
- `src/main/webapp/WEB-INF/views` — JSP views for customer/admin pages

## Design Patterns Used

This project applies the following patterns to reflect J2EE best practices:

- **DAO Pattern** for database access abstraction
- **Service Layer** for business rules
- **Facade Pattern** to simplify booking flow through `BookingFacade`
- **Factory Pattern** for creating tickets and pricing strategies
- **Strategy Pattern** for regular and VIP pricing logic
- **Decorator Pattern** for logging booking service operations
- **Observer Pattern** for events such as audit logs and sold-out handling
- **Filter Pattern** for route-based authorization via `AuthFilter`

## Database Configuration

The application uses a MySQL database with configuration in `src/main/resources/db.properties`.

Default configuration:

```properties
db.url=jdbc:mysql://localhost:3306/trionda_db?useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver
```

### Database Setup

1. Create a MySQL database named `trionda_db`.
2. Update the username and password in `src/main/resources/db.properties` if needed.
3. Import or create the required tables used by the DAO layer.

## Running the Application

### Prerequisites

- JDK 17+
- Maven 3.9+
- MySQL 8+
- Apache Tomcat 10.1+

### Build the project

```bash
./mvnw clean package
```

The compiled WAR file will be generated at:

```bash
target/trionda.war
```

### Deploy to Tomcat

1. Copy `target/trionda.war` to the Tomcat `webapps` directory.
2. Start Tomcat.
3. Open the app in a browser:

```text
http://localhost:8080/trionda
```

## Important URLs

- `/login` — Login page
- `/register` — Registration page
- `/customer/matches` — Customer match list
- `/customer/matches/detail` — Match detail page
- `/customer/bookings/confirm` — Booking confirmation page
- `/customer/bookings/history` — Booking history page
- `/admin/dashboard` — Admin dashboard
- `/admin/matches` — Admin match management
- `/admin/bookings` — Admin booking list

## Notes

- The app is designed for teaching purposes and demonstrates modular enterprise Java web development.
- Authentication is enforced through the `AuthFilter`, which restricts admin routes to users with the `ADMIN` role.
- The booking flow uses a facade to hide complexity from servlet controllers.

## Authors

Project developed as part of a J2EE course assignment.
