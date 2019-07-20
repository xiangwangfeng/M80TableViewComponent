Pod::Spec.new do |s|
  s.name             = 'M80TableViewComponent'
  s.version          = '0.1.0'
  s.summary          = 'A component-based framework for UITableView.'
  s.description      = 'A component-based framework for UITableView: fast && flexible && safe.'

  s.homepage         = 'https://github.com/xiangwangfeng/M80TableViewComponent'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'amao' => 'xiangwangfeng@gmail.com' }
  s.source           = { :git => 'https://github.com/xiangwangfeng/M80TableViewComponent.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
  s.source_files = 'M80TableViewComponent/Classes/**/*'
  s.frameworks = 'UIKit'
end
