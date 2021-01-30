<br />
<p align="center">
  <h1 align="center">TeltechEmployees</h3>
</p>
<br />

<!-- ABOUT THE PROJECT -->
## About The Project

TeltechEmployees is a project created for Teltech iOS Coding Challenge.
<br />
Project is built using Swift's Combine library and SwiftUI, it is broken down into Core app and embedded frameworks each with it's purpose.

Embedded frameworks include:
* Networking framework
* Analytics framework

### Core app

Core app is built using MVVM-C design pattern in combination with SwiftUI and Combine. 
For the purposes of demonstrating AppCoordinator, app has been constructed so that there are multiple entry points from which user can enter the app.
Only two of these entry points have been used.

App also includes localization support for English and German - keep in mind that API returns data with informations in English only, as such translations for that data is not available.
App is also, partially, covered with Unit tests. Networking framework has been covered by unit test with 85%+ code coverage. Core app, however, does not have Unit test as SwiftUI does not expose any View properties that can be used to make assertions.

Project has been set up with Firebase Analytics, and tracked events are being reported to the Firebase event console. For the demo purposes only one configuration has been used to configure Firebase, this can be changed to include multiple configurations and switch between them based on the app environment variables.

App consists of:
* AppCoordinator - App View router, responsible for handling app Navigation based on specific events,
* AppRootView - Root View of the app, all views are displayed via AppRootView,
* LoginView - used to demonstrate AppCoordinator,
* HomeView - ViewBuilder which, based on HomeViewModel states, displays different Views in HomeView,
  * EmployeeCarouselView - Main HomeView components, used to display Employee data in a carousel-like View,
  * HomeErrorView - View used to convey a message about an error occurring when fetching data,
  * HomeLoadingView - Used to indicate that data is being fetched,
* EmployeeDetailView - Detailed View used to display more information on each Employee, accessed by tapping on EmployeeCardView.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Coordinator/AppCoordinator.swift">AppCoordinator<a /> and <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/AppRoot/AppRootView.swift">AppRootView<a />

AppCoordinator is responsible for displaying app entry point Views. It is used in unison with AppRootView. 
AppCoordinator's singleton instance provides a ViewBuilder method scene(for entryPoint:) which takes EntryPoint as a parameter and returns some View based on that parameter.
AppCoordinator has been fully documentated with possible use examples.

Following code is used in AppRootView in order to handle app View display

```
@ObservedObject var coordinator = AppCoordinator.shared

@ViewBuilder
    var body: some View {
        NavigationView {
            ZStack {
                coordinator.scene(for: $coordinator.entryPoint.wrappedValue)
                
                ...
            }
            ...
        }
        ...
    }
```

Above code returns some View based on Published variable entryPoint. 
EntryPoint is an enum which defines access points to the app. New users may land on a View design for First Time User Experience, logged in users may land on HomeView, etc.
By changing the value of AppCoordinator's entryPoint, we instruct AppRoot to reconstruct current View hierarchy.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/FTUE/LoginView.swift">LoginView <a />

LoginView is a simple view displaying title Text, TextField, SecureField, and 'Log in' tappable View. Entire purpose of LoginView is to demonstrate behaviour of AppCoordinator.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/HomeView.swift">HomeView<a /> and subviews

HomeView represents app's heart and soul - it is used to provide User with information. Initial display of HomeView will cause HomeViewModel to execute data tasks for fetching Employee data.
While data is still loading, if no error has occurred while executing data task, <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/HomeLoadingView.swift">HomeLoadingView<a /> will be displayed. This will contains a simple rotating view with Text informing user that data is being fetched.
In case of an error, <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/HomeErrorView.swift">HomeErrorView<a /> is displayed. This View tells User that something went wrong. It will provide User with a tappable View used to retry fetch request.
If everything goes as planned, if data has been fetched and mapped to Employee data model, HomeView will display EmployeeCarouselView.

<a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/EmployeeCarousel.swift">EmployeeCarouselView<a /> is constructed from an array of Employee objects, each object is used to generate <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/EmployeeCardView.swift">EmployeeCardView<a /> which displays information on each employee.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/TeltechEmployees/Dashboard/Views/EmployeeDetailView.swift">EmployeeDetailView<a />

EmployeeDetailView is a fullscreen View which provides more information on the employee than EmployeeCardView. Mainly, it displays an additional Text view with description that employees provided on themselves.

### Networking framework

Networking framework provides a convenient way of fetching data from the API. 
It implements:
* Decodable data model based on API data format, 
* Endpoint data model which conveniently construct URL for data tasks,
* RequestManager class used to generate data task Publishers for Employee and UIImage data,
* ImageCacheManager class used to cache UIImage data,
* and NetworkStatusMonitor class which uses NWPathMonitor in order to monitor changes in network status,
* URLSession+Publisher extensions, methods which construct data task Publisher based on input parameters.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Models/Employee.swift">Employee<a />: Codable, Identifiable

Employee model is used to decode json data to a readable Swift data model.
This data model is used to populate main content view - a carousel - as well as detailed View providing more information.
Employee's image property is used to fetch and cache UIImage data, and display it within the app Views.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Models/Endpoint.swift">Endpoint<a />

Endpoint data model provides a convenient way of constructing URL for data task Publishers. 

```
let endpoint = Endpoint(path: "/some/path", queryItems: urlQueryItems)
let url = endpoint.url
```

Endpoint's url property is optional as it is possible to create a malformed URL.

It provides predefined methods used to construct URLs pointing to Employee data endpoint as well as Employee image data endpoint.

```
//Following returns an Endpoint with URL pointing towards Employee data endpoint
let employees = Endpoint.employees(query: (key: key, value: value), sortedBy: sortingKey)
var url = employees.url //Returns URL with absolute String '{baseURL}/api'

//Following returns an Endpoint with URL pointing to employee image resource
let image = Endpoint.image(with: imageName)
url = image.url         //Returns URL with absolute String '{baseURL}/images/members/{imageName}-main.jpg' 
```

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Managers/RequestManager.swift">RequestManager<a />

RequestManager class provides a singleton instance with with access to methods which construct Publishers used to fetch data from the API.
RequestManager instance has access to singleton instance of ImageCacheManager which is responsible for caching UIImage data.

```
//Constructs Publisher used to fetch Employee data.
let employeePublisher = RequestManager.shared.employeePublisher()

//If image is not cached method constructs a Publisher which perform data task.
//If image is cached constructs a Publisher which returns a Result with cached UIImage data.
//In case of a malformed URL, constructs a Publisher which returns a Failure with URLError(.badURL).
let imagePublisher = RequestManager.shared.imagePublisher(for: imageName)
```

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Managers/ImageCacheManager.swift">ImageCacheManager<a />

ImageCacheManager class provides a singleton instance used to cache UIImage data. By using subscript data can be fetched, stored, or deleted from the cache.

```
ImageCacheManager.shared[{imageName}] = imageData     //Store
let image = ImageCacheManager.shared[{imageName}]     //Fetch
ImageCacheManager.shared[{imageName}] = nil           //Delete
```

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Managers/NetworkStatusMonitor.swift">NetworkStatusMonitor<a />

NetworkStatusMonitor class provides a singleton instance used to monitor and notify of network status changes.
It uses NWPathMonitor to monitor network changes on a separete DispatchQueue. NWPathMonitor's handler updates NetworkStatusMonitor's isOnline property on main queue.
This property can be used to indicate network status to app User.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Networking/Networking/Extensions/URLSession%2BPublisher.swift">URLSession+Publisher<a />

Using Combine library URLSession has been extended to include methods used to construct data task Publishers.
These Publishers take resource URL and perform a task which, if successful, maps the response data to a Decodable data model.
In case of a bad server response or failed data mapping, Publisher will throw an error.


### Analytics framework

Framework is used to setup Firebase Analytics in order to track User events within the app. 
It is possible to provide multiple configurations based on environment variables, for example, one could provide separate configurations for Debug and Release versions of the app.
At the moment project uses a single configuration for both.
Analytics implements EventTracker class which is used to configure Firebase, and track user events.

#### <a href="https://github.com/DomBabic/TeltechEmployees/blob/master/Analytics/Analytics/Managers/EventTracker.swift">EventTracker<a />

EventTracker class provides a singleton instance which is used to configure Firebase on app launch.

```
//In AppDelegate call EventTracker.shared.configureFirebase()
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        EventTracker.shared.configureFirebase()
        return true
    }
```

To track events simply call trackEvent(_ name:, parameters:) method of EventTracker. 
Method parameter 'name' is the name we give to our events, 'parameters' is an optional dictionary which may hold additional information about the event.

```
func loginUser() {
    EventTracker.shared.trackEvent("login")   //Fires an event named "login"
        
    entryPoint = EntryPoint.home(route: .root)
}
```


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.
