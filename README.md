![alt tag](Logo/Tropicalytics.png)

[![Circle CI](https://circleci.com/gh/tilteng/Tropicalytics.svg?style=svg&circle-token=9191e56bdefa12b9309c2c8b569218d872c70da5)](https://circleci.com/gh/tilteng/Tropicalytics)
[![Version](https://img.shields.io/cocoapods/v/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)
[![License](https://img.shields.io/cocoapods/l/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)
[![Platform](https://img.shields.io/cocoapods/p/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)

Tropicalytics is a lightweight, flexible library made for analytics tracking in your iOS app. At its core, it's essentially a way to post JSON to an API endpoint. Request batching is handled by default so that network requests are economical.

## Requirements

**Minimum iOS Target:** iOS 8  
**Minimum Xcode Version:** 7

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Tropicalytics in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build Tropicalytics 3.0.0+.

#### Podfile

To integrate Tropicalytics into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

pod 'Tropicalytics', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

## Usage

An example project that makes use of Tropicalytics is included in this repo.

### Configuration

Everything in Tropicalytics—specifically the way the JSON structure of event data that is sent to an API server is built—is designed to be easily configurable.

#### TPLFieldGroup

A big part of Tropicalytics is in representing data in a flexible, transparent structure that's easily convertible to JSON. 

`TPLFieldGroup` is a data-wrapper class that encapsulates properties and arbitrary dictionary key-values and provides a `dictionaryRepresentation` method that combines properties and dictionary key-values into a single JSON-conversion-ready dictionary.

All of the JSON-data-representing classes that Tropicalytics makes use of itself—and expect clients to make use of—subclass this class.

#### Building a request structure

Since every analytics-tracking API server is different and every app has its own specific tracking needs and business logic, the JSON payload request structure is expected to be configured by library users.

When initializing Tropicalytics, clients are expected to define the JSON structure of every event-tracking request by using an instance of `TPLRequestStructure`.

```objc
TPLRequestStructure *structure = [[TPLRequestStructure alloc] init];
```

This object represents the resulting JSON payload that's sent to the server for tracking events. Any number of key-values can be added to the structure.

```objc
TPLRequestStructure *structure = [[TPLRequestStructure alloc] initWithEntries:@{
  @"beep": @"bop",
  @"anything": @{
    @"else": @"is cool",
  }
}];
[structure setValue:@57 forKey:@"someNumber"];
[structure addValues:@{
    @"sub": @"mariner",
}];
```

Then on subsequent tracking calls, the specified data is sent in requests:

```json
{
  "beep": "bop",
  "anything": {
    "else": "is cool"
  },
  "someNumber": 57,
  "sub": "mariner",
  "events": [...]
}
```


#### events structure


TK ~~Let's say you want to post event JSON data to a server and wish to have the following JSON structure:~~

```json
{
  "events": [
    {
      "type": "list_created",
      "client_tstamp": 1454520067,
      "ctx": {
        "list_guid": "LI231AD...",
        ...
      }
    },
    {
      "type": "list_viewed",
      "client_tstamp": 1454520104,
      "ctx": {
        "list_guid": "LI231AD...",
        ...
      }
    }
  ],

  "user_info": {
    "guid": "A24DG...",
    ...
  },

  "device_info": {
    "platform": "ios",
    "device": "iPhone",
    "model": "iPhone6,2",
    "os_version": "9.2.0",
    "network_type": "wifi",
    "timezone": "Pacific/Los Angeles"
  }
}
```




##### Adding 'header' fields


##### Adding 'device info' fields


##### Adding additional data to each request

You can also add additional fields 


### Initialization

### Tracking events




## Authors

Matt King, mattk@tilt.com | Brett Bukowski, brett@tilt.com

## License

Tropicalytics is available under the MIT license. See the LICENSE file for more info.
