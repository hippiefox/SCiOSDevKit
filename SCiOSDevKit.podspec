#
# Be sure to run `pod lib lint SCiOSDevKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SCiOSDevKit'
  s.version          = '0.8.0'
  s.summary          = 'A short description of SCiOSDevKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hippiefox/SCiOSDevKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Simon Chow' => 'foxhippie5@gmail.com' }
  s.source           = { :git => 'https://github.com/hippiefox/SCiOSDevKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_version       = '5.0'
  s.source_files = 'SCiOSDevKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SCiOSDevKit' => ['SCiOSDevKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.subspec 'Base' do |bb|
        bb.source_files = 'SCiOSDevKit/Classes/Base/*'
        bb.dependency 'KeychainAccess', '~> 4.2.1'
    end
    
    s.subspec 'Widget' do |ww|
        ww.source_files = 'SCiOSDevKit/Classes/Widget/*'
        ww.dependency 'SCiOSDevKit/Base'
        ww.dependency 'SnapKit'
    end
    
    s.subspec 'Extensions' do |ee|
        ee.source_files = 'SCiOSDevKit/Classes/Extensions/*'
    end
    
    s.subspec 'HUD' do |hh|
        hh.source_files = 'SCiOSDevKit/Classes/HUD/*'
        hh.dependency 'MBProgressHUD'
        hh.dependency 'lottie-ios'
    end
    
    s.subspec 'Request' do |rr|
        rr.source_files = 'SCiOSDevKit/Classes/Request/*'
        rr.dependency 'Cache'
        rr.dependency 'Moya'
        rr.dependency 'GTMBase64'
        rr.dependency 'SCiOSDevKit/Base'
        rr.dependency 'SCiOSDevKit/HUD'
    end
    
    s.subspec 'Refresh' do |ff|
        ff.source_files = 'SCiOSDevKit/Classes/Refresh/*'
        ff.dependency 'MJRefresh'

    end

    
    
  
end
