#
# Be sure to run `pod lib lint Tropicalytics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Tropicalytics"
  s.version          = "0.1.1"
  s.summary          = "Tropicalytics is a lightweight, flexible library made for analytics tracking in your iOS app."
  s.description      = <<-DESC
Tropicalytics is a lightweight configurable analytics tool that allows you to send self describing JSON to your own server so you are in control of your data.
                       DESC

  s.homepage         = "https://github.com/tilteng/Tropicalytics"
  s.license          = 'MIT'
  s.author           = { "Tilt.com Inc" => "tech@tilt.com" }
  s.source           = { :git => "https://github.com/tilteng/Tropicalytics.git", :tag => "0.1.1" }
  s.social_media_url = 'https://twitter.com/tilteng'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.exclude_files = 'Pod/Classes/Tropicalytics.xcdatamodeld'
  s.resource_bundles = {
    'Tropicalytics' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'MAObjCRuntime', '~> 0.0.1'
  s.resources = 'Pod/Classes/Tropicalytics.xcdatamodeld'
  s.preserve_paths = 'Pod/Classes/Tropicalytics.xcdatamodeld'
  s.framework = 'CoreData'
  s.requires_arc = true
end
