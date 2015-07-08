# Article List iOS Application

iOS application that displays a list of articles in a tableview.

Articles are requested from server in JSON format and stored in CoreData as persistent objects. The articles can be sorted by title, date, website and authors. Upon selection, the content of an article is displayed in a separate controller.

Build in Xcode 7 Beta with Swift 2.0.

Tested in simulators only. Platforms >= 8

###__Frameworks used:__

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [CocoaPods](https://cocoapods.org/)
- [CoreData](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html)
- [UIKit](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKit_Framework/)


### Configuration:

- Clone to project to your local directory
```
$ git clone https://github.com/ismalakazel/ios-article-list
```
- Open the file `cheesecakelabs.xcworkspace` either by double-clicking the file or running the following in the the project folder:

```
$ open cheesecakelabs.xcworkspace`
```
- Choose a simulator or connect an iOS device to your computer and run the application with  `⌘ + R` command

- Run tests with `⌘ + U`

### Preview:

![Portrait](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/image1.png)
![Portrait](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/image2.png)
![Portrait](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/image3.png)
![Portrait](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/image4.png)
![Portrait](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/image5.png)
  
### Diagram:
![Diagram](https://raw.githubusercontent.com/ismalakazel/random-api-files/master/ios-article-list/diagram.png)


