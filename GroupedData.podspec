Pod::Spec.new do |s|

  s.name         = "GroupedData"
  s.version      = "1.0.0"
  s.platform     = :ios, "11.0"
  s.requires_arc = true
  s.frameworks   = 'UIKit'
  s.license      = { :type => 'MIT' }
  s.summary      = "通讯录联系人按索引排序，侵入性小，效率高，只要遵守协议即可排序"
  s.homepage     = "https://github.com/ygf-git/GFGroupedData-master"
  s.author       = { "杨桂福" => "ygf@yeastar.com" }
  s.source       = { :git => "https://github.com/ygf-git/GFGroupedData-master.git", :tag => s.version.to_s }
  s.source_files = "GroupedData/GroupedData/GroupedData/**/*.{h,m}"
end

