# Smart-Task-Insight-Tracker
A productivity app that fetches tasks from an API, enriches them with analytics, and works fully offline.

A **production-grade SwiftUI application** built on top of the [JSONPlaceholder](https://jsonplaceholder.typicode.com) APIs.

This project demonstrates **Clean Architecture + MVVM**, modern **Swift Concurrency (async/await)**, **dependency injection**, **network abstraction**, **local caching**, and a **polished SwiftUI UI layer**.

---

## ✨ Features

### 🧭 Navigation & Tabs

* `TabView` with 4 tabs:

  * ✅ Todos
  * 📝 Posts
  * 🖼 Albums
  * 👤 Profile
* Centralized navigation styling
* Dynamic navigation titles per tab

### ✅ Todos

* Fetch Todos from API
* Create new Todo
* Toggle completion (PATCH)
* Pull-to-refresh
* Filters:

  * All
  * Completed
  * Pending
* Floating action button
* Bottom sheet for creating Todo
* Local cache support (CoreData / SwiftData ready)

### 🔐 Authentication (Mocked)

* Login via email
* Session persistence via `SessionStore`
* Logout handling from Profile

### 📣 Toast / Banner Notifications

* Full-width toast banners
* Types:

  * Success
  * Error
  * Warning
* Auto-dismiss
* Smooth animations

### 🌐 Networking

* Type-safe API routing
* Async/Await based networking
* Dynamic API requests
* Centralized request logging
* Error handling & decoding

---

## 🏗 Architecture

The project strictly follows **Clean Architecture + MVVM**, reflected directly in the folder structure:

```
App
├── AppCoordinatorView / ViewModel
├── AppContainer (DI)

Presentation (SwiftUI)
├── Feature-based modules (Todos, Posts, Albums, Profile, Auth)
├── Views
├── ViewModels

Domain
├── Entities
├── UseCases
├── Repository Protocols

Data
├── Network
│   ├── Core (APIClient, APIRoute, Logger)
│   └── DTOs
├── Persistence (SessionStore, CoreData)
├── Repository Implementations

Helpers / Utilities
├── UI Modifiers
├── Extensions
├── Fonts & Styling

```

Presentation (SwiftUI)
│
├── View
├── ViewModel
│
Domain
│
├── Entity
├── UseCase
├── Repository (Protocol)
│
Data
│
├── DTO
├── Repository Implementation
├── API Client
├── Local Cache

````

### Why Clean Architecture?
- Separation of concerns
- Testable business logic
- Replaceable data sources
- Scalable for large apps

---

## 🧩 Dependency Injection

A central **AppContainer** is used to construct and inject dependencies.

```swift
@Environment(\.appContainer) private var container
````

### AppContainer Responsibilities

* Build APIClient
* Provide repositories
* Provide use cases
* Construct ViewModels

This ensures:

* No singletons
* Easy mocking
* Clear dependency graph
  swift
  @Environment(.appContainer) private var container

````

Example:
```swift
TodosView(viewModel: container.makeTodosViewModel())
````

Benefits:

* No singletons
* Easy mocking
* Unit-test friendly

---

## 🌐 Networking Layer

Located under:

```
Data/Network/Core
```

### Components

* `APIClient` – Async/Await networking
* `APIRoute` – Type-safe endpoints
* `DynamicAPIRequest` – Reusable request builder
* `NetworkLogger` – Logs request & response

Example:

```swift
let request = DynamicAPIRequest<[TodoDTO]>(
    path: .todosByUser(userID),
    method: .get
)
```

swift
func request<T: APIRequest>(_ request: T) async throws -> T.Response

````

### APIRoute

```swift
enum APIRoute {
    case users
    case todos
    case todosByUser(String)
}
````

---

## 🗂 Models

### DTO

Used only for decoding API responses

```swift
struct TodoDTO: Decodable {
    let id: Int
    let title: String
    let completed: Bool
}
```

### Entity

Used inside the app

```swift
struct Todo: Identifiable {
    let id: Int
    let title: String
    let isCompleted: Bool
}
```

---

## 🔁 UseCases

Encapsulate business logic

Examples:

* FetchTodosUseCase
* CreateTodoUseCase
* ToggleTodoCompletionUseCase
* LoginUseCase
* LogoutUseCase

```swift
protocol TodosUseCase {
    func fetchTodos(forceRefresh: Bool) async throws -> [Todo]
    func createTodo(with title: String) async throws -> Todo
}
```

---

## 🧪 Unit Testing

* UseCases are fully testable
* Repository protocols allow mocking
* Async tests supported

Example:

```swift
func testCreateTodoSuccess() async throws {
    let todo = try await sut.createTodo(with: "Test")
    XCTAssertEqual(todo.title, "Test")
}
```

---

## 💾 Local Caching

* Cache layer ready for:

  * CoreData
  * SwiftData
* Automatically used on network failure
* Pull-to-refresh forces API reload

---

## 📣 Toast System

Reusable toast banner system:

* Full-width
* Top overlay
* Auto dismiss

```swift
Toast(type: .success, message: "Todo created")
```

---

## 🎨 UI Components

* Custom buttons
* Custom text fields
* Floating action button
* Bottom sheets with detents
* Consistent styling

---

## 🔐 Session Handling

### SessionStore

```swift
protocol SessionStore {
    func save(user: User)
    func clear()
    func getUserID() async throws -> Int
}
```

Used for:

* Auth state
* Logout handling
* API authorization headers

---

## 🚀 Getting Started

### Requirements

* Xcode 15+
* iOS 17+
* Swift 5.9+

### Run

1. Clone repository
2. Open `.xcodeproj`
3. Build & Run

---

## 📌 API Reference

Powered by:

* [https://jsonplaceholder.typicode.com/users](https://jsonplaceholder.typicode.com/users)
* [https://jsonplaceholder.typicode.com/todos](https://jsonplaceholder.typicode.com/todos)
* [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)
* [https://jsonplaceholder.typicode.com/albums](https://jsonplaceholder.typicode.com/albums)

---

## 📈 Future Improvements

* Offline-first sync
* Pagination
* Search
* Dark mode polish
* Global toast manager
* Analytics

---

## 👨‍💻 Author

**Husnain Ali**
Principal Software Engineer
SwiftUI • Clean Architecture • Async/Await

---

## 📄 License

This project is for **learning and demonstration purposes**.

---

⭐ If you like this project, consider giving it a star!
