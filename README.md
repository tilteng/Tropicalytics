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

> CocoaPods 0.39.0+ is required to build Tropicalytics 1.0.0+.

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

### Quick start

Tropicalytics can be quickly configured to start tracking events!

```objc
TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"https://my.analytics.api"]];
Tropicalytics *tracker = [[Tropicalytics alloc] initWithConfiguration:config];
[tracker recordEvent:@{ @"label": @"start", @"category": @"tap", @"value": 1  }];
[tracker recordEvent:@{ @"label": @"edit", @"category": @"tap", @"value": 2  }];
```

Results in the JSON event being posted to the server endpoint:

```json
{
  "events": [
    {
      "label": "start",
      "category": "tap",
      "value": 1
    },
    {
      "label": "edit",
      "category": "tap",
      "value": 2
    }
  ]
}
```

However, all aspects of tracking—including the JSON payload structure, event-batching, and event-recording can be flexibly customized:

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
[structure setEntry:@57 forKey:@"someNumber"];
[structure addEntries:@{
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

### Initialization

Tropicalytics supports the ability to create multiple instances or to use a single shared instance (singleton).

A `TPLConfiguration` instance is required when creating a Tropicalytics instance or setting up the singleton. This configuration object contains the URL of the server that receives tracking requests and provides the ability to configure how many events are batched together in an HTTP request.

```objc
TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"https://my.analytics.api"]];
config.flushRate = 10; // 10 events are batched together.
```

Creating an instance of Tropicalytics:

```objc
Tropicalytics *tracker = [[Tropicalytics alloc] initWithConfiguration:config];
```

Or setting up the singleton:

```objc
[Tropicalytics sharedInstanceWithConfiguration:config];
```

### Tracking events

Arbitrary dictionary data can be tracked:

```objc
[tracker recordEvent:@{ @"label": "add button", @"category": @"start" }];
```

Or more structured events can be represented by a `TPLFieldGroup` subclass and then recorded:

```objc
MyTPLFieldGroupSubclass *event = [[MyTPLFieldGroupSubclass alloc] initWithEntries:@{ @"event_name": @"foo" }];
[tracker recordEventWithFieldGroup:event];
```


#### Adding additional data to each request

Top-level key-values can be added to and removed from the request structure at any time.

```objc
[tracker setEntry:@"bar", forKey:@"foo"];
```

Results in future recording requests containing the added key-values:

```json
{
  "foo": "bar",
  "events": []
}
```

These entries can also be removed.

```objc
[tracker removeEntryForKey:@"foo"];
```

### Working with Tropicalytics defaults

Tropicalytics supports a default configuration that attaches info about the device and the app onto tracking request payloads.

```objc
Tropicalytics *tropicalytics = [[Tropicalytics alloc] initDefaultRequestStructureWithConfiguration:config];
```

By using these defaults, event tracking request payloads look like:

```json
{
  "header": {
    "app_id": "example app id",
    "session_id": "38cdff6f3e104241bd42430d5e098e48",
    "source": "app",
    "app_version": "1.0"
  },
  "device_info": {
    "os_version": "9.2",
    "device": "iPhone",
    "model": "iPhone 6,2",
    "network_type": "Reachable WiFi",
    "timezone": "America/Los_Angeles",
    "platform": "ios"
  },
  "events": []
}
```



## Authors

Matt King, mattk@tilt.com | Brett Bukowski, brett@tilt.com

## License

Tropicalytics is available under the MIT license. See the LICENSE file for more info.
