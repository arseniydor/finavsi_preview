# FinAvsi

![Platform](https://img.shields.io/badge/iOS-17.6+-blue)
![Swift](https://img.shields.io/badge/Swift-5.10-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-ready-green)

A modern personal finance tracker built with **SwiftUI**, **SwiftData**, and **Clean Architecture**.

FinAvsi helps users manage personal finances by tracking income and expenses, organizing transactions, and providing monthly analytics through a clean and native iOS experience.

The project demonstrates modern iOS development practices including:

- SwiftUI
- SwiftData
- Clean Architecture
- Repository Pattern
- Dependency Injection
- Unit Testing
- UI Testing
- GitHub Actions CI/CD

---

## Screenshots

| Dashboard | Transactions |
|-----------|-------------|
| ![](Screenshots/dashboard.png) | ![](Screenshots/transactions.png) |

| Add Transaction | Edit Transaction |
|-----------|-------------|
| ![](Screenshots/add_transaction.png) | ![](Screenshots/edit_transaction.png) |

---

## Features

### Transactions

- Add transactions
- Edit transactions
- Delete transactions
- Income and expense tracking
- Transaction search
- Advanced transaction filtering
- Swipe actions for quick editing and deletion

### Dashboard

- Monthly financial summary
- Month navigation
- Income overview
- Expense overview
- Balance calculation
- Category analytics
- Top spending categories

### Analytics

- Total income
- Total expenses
- Current balance
- Transaction count
- Category breakdown
- Monthly aggregation

---

## Tech Stack

### UI

- SwiftUI
- NavigationStack
- MVVM

### Persistence

- SwiftData
- ModelContainer
- ModelContext

### Testing

- Swift Testing
- XCTest

### CI/CD

- GitHub Actions

---

## Architecture

The project follows **Clean Architecture** principles.

### Presentation Layer

Responsible for UI and user interactions.

- Views
- ViewModels
- Router
- Reusable Components

### Domain Layer

Contains business logic and application rules.

- Models
- Use Cases
- Protocols
- Analytics Builders

### Data Layer

Responsible for persistence and data access.

- Repositories
- SwiftData Entities
- Mappers
- Persistence Layer

---

## Dependency Injection

Dependencies are assembled through a central `AppContainer`.

This approach provides:

- Better testability
- Loose coupling
- Clear dependency management
- Easy replacement of implementations

---

## Project Structure

```text
FinAvsi
├── App
│   ├── AppContainer
│   ├── AppRouter
│   └── RootView
│
├── Features
│   ├── Dashboard
│   ├── Transactions
│   ├── AddTransaction
│   └── EditTransaction
│
├── Domain
│   ├── Models
│   └── UseCases
│
├── Data
│   ├── Repositories
│   ├── Mapper
│   └── Local
│
├── Core
│   ├── Extensions
│   ├── DesignSystems
│   └── Protocols
│
├── FinAvsiTests
│
└── FinAvsiUITests
```

---

## Screens

- Dashboard
- Transactions
- Add Transaction
- Edit Transaction

---

## Testing

### Unit Tests

Coverage includes:

- Repository Tests
- Transaction Filtering
- Use Cases
- Analytics Builders

Unit tests use an in-memory SwiftData container to ensure deterministic and isolated execution.

### UI Tests

Coverage includes:

- App Launch
- Create Transaction
- Edit Transaction
- Delete Transaction
- Search Transaction

UI tests also use an in-memory database to guarantee a clean state for every test run.

---

## Continuous Integration

GitHub Actions automatically performs:

- Project Build Validation
- Unit Test Execution
- Test Result Artifacts Upload

UI Tests are available through a dedicated manual workflow to keep CI execution fast and reliable.

---

## Requirements

- Xcode 16+
- iOS 17.6+
- Swift 5.10+

---

## Future Improvements

### Transactions

- Recurring transactions
- Transaction templates
- Bulk editing

### Data

- CSV export/import
- Cloud synchronization
- Backup and restore

---

## License

This project is available under the MIT License.
