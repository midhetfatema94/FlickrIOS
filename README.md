# FlickrIOS
This is a basic application in which a collections of pictures from the public feed of Flickr are displayed. Flickr API is linked [here](https://www.flickr.com/services/feeds/)

## Installation (Will Require Xcode v11+)
Clone or download the project > open .xcodeproj > Wait for the dependencies to load (you can check their progress in the organiser tab) > Build and Run

### Provisions:
* A display of public images which give you some information about the image on clicking the image.
* Animations of 0.5 secs on selecting a photo 
* Architechture used is _MVVM_ and the project is written in `Swift`
* Dependency is managed by `Swift Package Manager`
* Library used for image caching and smooth scrolling is `SDWebImage`. You can find the package [here](https://github.com/SDWebImage/SDWebImage)
