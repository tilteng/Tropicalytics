![alt tag](Logo/Tropicalytics.png)

[![Circle CI](https://circleci.com/gh/tilteng/Tropicalytics.svg?style=svg&circle-token=9191e56bdefa12b9309c2c8b569218d872c70da5)](https://circleci.com/gh/tilteng/Tropicalytics)
[![Version](https://img.shields.io/cocoapods/v/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)
[![License](https://img.shields.io/cocoapods/l/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)
[![Platform](https://img.shields.io/cocoapods/p/Tropicalytics.svg?style=flat)](http://cocoapods.org/pods/Tropicalytics)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Tropicalytics is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Tropicalytics"
```

##Desired Behavior (Hopefully we can change this to acutal behavior)

Send analytics as a self describing JSON blob to the desired endpoint. Maybe we can build our own custom endpoint to do stuff with self describing JSON.
Anyways... The data engineering team did us a solid and put together a nice spec that is a nice generic solution for sending analytics which is below...

#Log Format
```
{
  "header": {
    ... 
  },
  "batch_info": {
    ...
	},
  "user_info": {
    ...
	},
	"device_info": {
    ...
	},
	"events": [
    ... 
  ]
}
```

#Header Fields

```
{
  "source": "app",
  "app_id": "tilt_web",
  "env": "prod",  
  "session_id": "619DF0CEF-8649-483A-AE4E-6191531866E2",
  "request_id": "xxx",
  "ip": "160.117.71.11",
  "geolocation": {
    "geo_country": "US",
  	"geo_region": "NJ",
  	"geo_city": "Absecon",
  	"geo_zipcode": "08205",
  	"geo_latitude": "39.49",
  	"geo_longitude": "-74.48",
  	"geo_region_name": "New Jersey"
  },
  "versions": {
  	"app_version": "1.1.0",
  	"server_version": "1.2.1",
  	"flash_version": "20.0"
  }
}
```

#Batch Info Fields
```
{
  "batch_id": "xxx",
  "total_events": 20,
  "source": "client",
  "server_time": 14583850383,
  "last_update_time": 14583850383
}
```

#User Info Fields

```
{
  "domain_user_id": "4c42d8f37923dabe",
  "network_user_id": "e34d31ea-5989-4424-9aba-dda1c59d24f0",
  "tilt_user_id": "385928493",
  "guid": "USRB4DC735D05CF4906BB254D2F8C42176F"
  "user_fingerprint": "3153610022",
  "mac_address": "12-34-56-78-9A-BC",
  "idfa": "1E2DFA89-496A-47FD-9941-DF1FC4E6484A",
  "idfv": "599F9C00-92DC-4B5C-9464-7971F01F8370",
  "openudid": "0d943976b24c85900c764dd9f75ce054dc5986ff",
  "android_id": "4906BB254D2F8C42",
  "imei": "315361002211114"
  "fb_id": "10010010",
  "google_id": "4906BB254D2F8C42",
  "country_code": "US",
  "locale": "xxx",
  "app_installed": "true", (if had)
  "is_employee": "false",
  "tilts_created": 2,
  "contributions": 6,
  "registration_time": 1452291633,
  "registered_platform": "ios",
  "experiment_info": [
    {
       "experiment_id" : 4069541102,
       "experiment_state" : 2,
       "variation_id" : 4071251470
    },
    {
       "experiment_id" : 4070672813,
       "experiment_state" : 2,
       "variation_id" : 4102791555
    },
    ...
  ]
}
```

#Device Info Fields

```
{
  "platform": "ios",
  "device": "iPhone",
  "cpu": "Apple A9",
  "gpu": "PowerVR GX6450",
  "os_version": "8.1.1",
  "browser": "Firefox",
  "browser_version": "41.0.2227.1",
  "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36",
  "model": "iPhone 6",
  "network_type": "wi-fi",
  "timezone": "America/Los_Angeles",
  "hacked": "false"
}
```

#Events Field

```
[
  {
    "type": "campaign_created",
    "client_tstamp": 1452291633,
    "ctx": {
      ...
    }
  },
  ...
]
```

#Context Example

```
{
  "type": "Contribution_Success",
  "client_tstamp": 1452291633,
  "ctx": {
    "campaign_info": {
      "guid": "xxyyxxyxyxyxyxx",
      "title": "Chainsmokers All Day",
      "creation_date": "2016-01-01 00:00:00",
      "expiration_date": "2016-03-01 00:00:00",
      "tilt_timestamp": "2016-01-01 00:00:00",
      "currency": "USD",
      "to_date_amt": 10.00,
      "num_contributors": 1,
      "target_amt": 10000.00,
      "people_invited": 10,
      "total_comments": 2,
      "total_likes": 3,
      "campaign_type": "collect",
      "campaign_security": "private",
      "target_timestamp": "2016-03-01 00:00:00",
      "created_platform": "ios"
    },
    "contribution_info": {   
      "quantity": 10, //null if Tilt Collect or Fundraise
      "contribution_total": 20.00,
      "quantity": 10, //null if Tilt Collect or Fundraise
      "answers": {},
      "shipping_country": "USA",
      "state": "Texas",
      "city": "Houston",
      "zip": "94117",
      "card_id": "Visa"
  }
}
```



## Authors

Brett Bukowski, brett@tilt.com | Matt King, mattk@tilt.com

## License

Tropicalytics is available under the MIT license. See the LICENSE file for more info.
