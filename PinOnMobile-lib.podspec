#
# Be sure to run `pod lib lint PinOnMobile-lib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PinOnMobile-lib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PinOnMobile-lib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/x-oauth-basic/PinOnMobile-lib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'x-oauth-basic' => 'kelsey.makale@interswitchgroup.com' }
  s.source           = { :git => 'https://github.com/x-oauth-basic/PinOnMobile-lib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'PinOnMobile-lib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PinOnMobile-lib' => ['PinOnMobile-lib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'JOSESwift', ' ~> 2.3'
  s.dependency 'CocoaMQTT', ' ~> 2.1.0'
  s.dependency 'Alamofire', ' ~> 5.5.0'
  s.dependency 'PercentEncoder',' ~> 1.2.1'
  s.dependency 'CryptoSwift', ' ~> 1.0.0'
  s.dependency 'SwiftyRSA', ' ~> 1.5.0'
end
