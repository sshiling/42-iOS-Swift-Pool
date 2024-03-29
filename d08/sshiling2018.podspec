#
# Be sure to run `pod lib lint sshiling2018.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'sshiling2018'
  s.version          = '0.1.0'
  s.summary          = 'utomatically assigning platform `ios` with version `9.3` on target `sshiling2018_Exa'
  s.swift_version    = '4.0.3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
utomatically assigning platform `ios` with version `9.3` on target `sshiling2018_Exautomatically assigning platform `ios` with version `9.3` on target `sshiling2018_Exautomatically assigning platform `ios` with version `9.3` on target `sshiling2018_Exautomatically assigning platform `ios` with version `9.3` on target `sshiling2018_Exa
                       DESC

  s.homepage         = 'https://github.com/sshiling/sshiling2018'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sshiling' => 'sshiling@student.unit.ua' }
  s.source           = { :git => 'https://github.com/sshiling/sshiling2018.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'sshiling2018/Classes/**/*'
  s.resource = 'sshiling2018/Assets/*.xcdatamodeld'
  
  # s.resource_bundles = {
  #   'sshiling2018' => ['sshiling2018/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
