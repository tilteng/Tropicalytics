#
# Be sure to run `pod lib lint Tropicalytics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Tropicalytics"
  s.version          = "0.1.0"
  s.summary          = "Tropicalytics is a lightweight configurable analytics tool that allows you to send self describing JSON to your own server so you are in control of your data."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/tilteng/Tropicalytics"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tilt.com Inc" => "mattk@tilt.com" }
  s.source           = { :git => "https://github.com/tilteng/Tropicalytics.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tilteng'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Tropicalytics' => ['Pod/Assets/*.png']
  }

   s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking', '~> 3.0'
end
