#
# Be sure to run `pod lib lint QMChatUICore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QMChatUICore'
  s.version          = '0.5'
  s.summary          = 'A short description of QMChatUICore.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/7moor-tech/QMUICores'
 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '焦林生' => '18515384635@163.com' }
  s.source           = { :git => 'https://github.com/7moor-tech/QMUICores.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = "QMChatUICore/Classes/**/*"
       
   s.resource = [
         'QMChatUICore/Assets/*.bundle'
    ]

   s.pod_target_xcconfig = {'VALID_ARCHS'=>'armv7 x86_64 arm64'}
   s.requires_arc = true
   s.frameworks = 'UIKit'
   s.dependency 'SDWebImage', '~> 5.12.5'
   s.dependency 'Masonry', '~> 1.1.0'
   s.dependency 'JSONModel'
   s.dependency 'MJRefresh', '~> 3.6.1'
   
end
