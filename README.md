# Simple To-Do List App
* MVVM Design Pattern
* UserDefaults
* UIContentUnavailableConfiguration
* UITableView
* UIAlertController

## Purpose

The primary purpose of this project is to change the architecture of this application, which I previously built using the MVC pattern, to MVVM.

## Features

* The app displays tasks entered by the user in a TableView.
* Tasks can be stored, deleted, and checked/unchecked using local storage using UserDefaults. 
* UIContentUnavailableConfiguration, a new feature introduced in UIKit that allows us to customize the appearance of an empty page, which I learned about while following WWDC23.

## Benefits

* The MVVM architecture makes the app more modular, testable, and maintainable. 
* The UIContentUnavailableConfiguration feature ensures that the user experience is not disrupted when the page is first opened.

You can read additional details on the topics I mentioned below:

## UserDefaults

* UserDefaults is a key-value store that stores small amounts of data that persist across app launches.
* The data that can be stored in UserDefaults include simple types such as strings, integers, floats, and Booleans.
* To store data in UserDefaults, you use the setValue() method to set the value of a key-value pair.
* To retrieve data from UserDefaults, you use the value(forKey:) method to get the value of a key-value pair.
* To remove data from UserDefaults, you use the removeObject(forKey:) method to remove the key-value pair.

UserDefaults is a convenient way to store small amounts of data that persist across app launches. However, it is not a good choice for storing large amounts of data or data that needs to be secure.

## MVC vs MVVM

* MVC is a design pattern that separates the data (model) and the interface (view) into two separate components. 
The controller acts as a bridge between the model and the view, handling user input and updating the view with the latest data from the model.
* MVVM is a variation of MVC that introduces a new layer called the view model. The view model is responsible for handling the business logic of the application, such as data validation and formatting. This frees up the controller to focus on handling user input and updating the view.
* The advantages of MVC include its simplicity and ease of use, as well as its wide availability of learning resources. However, MVC can be difficult to test and maintain, as the controller can become tightly coupled to the model and view.
* The advantages of MVVM include its clear separation of concerns, which makes it easier to test and maintain. MVVM is also more scalable than MVC, as the view model can be reused in multiple views.

Overall, MVVM is a more modern and flexible architectural pattern than MVC. It can be a good choice for applications that need to be easily tested and maintained, or that need to be scalable to a large number of features and user flows.

## UIContentUnavailableConfiguration

* UIContentUnavailableConfiguration is a new feature introduced in UIKit that allows you to customize the appearance of an empty page. 
* This can be useful for apps that display a list of items, such as a To-Do List app, where the user may not have any items to display when the app opens.
* To use UIContentUnavailableConfiguration, you first need to create a UIContentUnavailableConfiguration object.
* You can then specify the title, message, and image that you want to display on the empty page.

Hope this helps on your Swift learning journey!:)

https://github.com/aycakman/Music-App3/assets/81530201/2a08e241-d674-43c5-bdcc-eb96fc049938
