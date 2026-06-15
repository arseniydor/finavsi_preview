FinAvsi

A modern personal finance tracker built with SwiftUI and SwiftData.

Features

* Add, edit and delete transactions
* Income and expense tracking
* Transaction filtering and search
* Financial summary and analytics
* SwiftData persistence
* Clean Architecture
* Repository Pattern
* Dependency Injection
* Unit Tests
* UI Tests

Tech Stack

* Swift
* SwiftUI
* SwiftData
* XCTest
* Swift Testing

Architecture

The project follows Clean Architecture principles:

* Presentation Layer (Views, ViewModels)
* Domain Layer (Models, Use Cases, Protocols)
* Data Layer (Repositories, SwiftData Entities, Mappers)

Dependency injection is handled through AppContainer.

Project Structure

Presentation/
Domain/
Data/
Infrastructure/
Tests/

Screens

* Dashboard
* Add Transaction
* Edit Transaction
* Analytics

Testing

The project includes:

* Unit Tests for Use Cases
* Repository Tests
* Transaction Filter Tests
* UI Tests

UI tests run using an in-memory SwiftData database to ensure a clean state for every test run.

![iOS CI](https://github.com/USERNAME/FinAvsi/actions/workflows/ios-ci.yml/badge.svg)