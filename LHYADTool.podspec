#
# Be sure to run `pod lib lint LHYADTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LHYADTool'
  s.version          = '0.0.2'
  s.summary          = 'A short description of LHYADTool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A short description of LHYADTool Test.
                       DESC

  s.homepage         = 'https://github.com/huboceanLi/LHYADTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OceanLi' => 'li437277219@gmail.com' }
  s.source           = { :git => 'https://github.com/huboceanLi/LHYADTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'LHYADTool/Classes/**/*'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.static_framework = true

  # s.resource_bundles = {
  #   'LHYADTool' => ['LHYADTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
#  s.dependency "YYKit"
#  s.dependency "UMCommon"
#  s.dependency "SVProgressHUD"
  s.dependency "QMUIKit"
  s.dependency "Ads-CN", '~> 4.5.1.6'

end
