# NewsApp


## Demonstrations

Covers the following:
* Screenshots
* Architecture 
* Unit Tests and Coverage
* CI/CD using Azure Devops

App Features:
* Auto layouts
* VIPER Design Pattern 
* Supports Portrait and Landscape
* Headline news from `https://newsapi.org/`
* Fetch from different source

## Screenshots

|             Sources         |         News          | News Detail |
|---------------------------------|------------------------------|------------------------------|
|![Demo](https://github.com/mwaqasbhati/NewsApp/blob/master/Screenshots/Categories.png)|![Demo](https://github.com/mwaqasbhati/NewsApp/blob/master/Screenshots/Article%20List.png)|![Demo](https://github.com/mwaqasbhati/NewsApp/blob/master/Screenshots/Article%20Detail.png)|

## Requirements

- Xcode 10.2.1
- Swift 5.0
- Minimum iOS version 12.2


## Architecture at a Glance

![Architecture at a Glance](https://github.com/mwaqasbhati/NewsApp/blob/master/System%20Architecture/System%20Architecture.jpeg)

## Installation

Checkout this repository, go to project directory and run command `Pod Install`

## Build

To build using xcodebuild without code signing
```
xcodebuild clean build -workspace "NewsArticle.xcworkspace" -scheme "NewsArticle" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO
```

## Tests

To run tests using xcodebuild.
```
xcodebuild -workspace "NewsArticle.xcworkspace" -scheme "NewsArticle" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone X,OS=12.2' test
```
## Coverage

![Architecture at a Glance](https://github.com/mwaqasbhati/NewsApp/blob/master/Screenshots/Test%20Coverage.png)

## Azure Devops CI/CD

![Architecture at a Glance](https://github.com/mwaqasbhati/NewsApp/blob/master/Screenshots/Azure%20Devops.png)

## Open Source Libraries Used

* pod 'PKHUD', '~> 5.0'
* pod 'SDWebImage'
* pod 'Dropdowns'

## Discussions

I have used VIPER design pattern in this project. VIPER follows a very clean architecture. It isolates each module from others. So changing or fixing bugs are very easy as you only have to update a specific module. Also for having modular approach VIPER creates a very good environment for unit testing. As each module is independent from others, it maintains low coupling very well. So, dividing work among co-developers are pretty simple.

## Author

mwaqasbhati, m.waqas.bhati@hotmail.com

## License

NewsApp is available under the MIT license. See the LICENSE file for more info.

