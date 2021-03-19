#
#  Be sure to run `pod spec lint GroupedData.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "GroupedData"
  spec.version      = "0.0.1"
  spec.summary      = "通讯录联系人按索引排序，效率高"

  spec.description  = <<-DESC
			通讯录联系人按索引排序，效率高,只有遵守协议即可
                   DESC

  spec.homepage     = "https://github.com/ygf-git/GFGroupedData-master"
  spec.license      = { :type => 'MIT' }
  spec.author       = { "杨桂福" => "ygf@yeastar.com" }

  spec.platform     = :ios
  spec.platform     = :ios, "9.0"


  spec.source       = { :git => "https://github.com/ygf-git/GFGroupedData-master.git", :tag => "#{spec.version}" }


  spec.source_files  = "GroupedData/GroupedData/GroupData/**/*.{h,m}"

end
