
Pod::Spec.new do |s|

  #名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
  s.name         = "HJPageMenu"
  #版本号
  s.version      = "1.0.0"
  #支持的pod最低版本
  s.ios.deployment_target = '9.0'
  #简介
  s.summary      = "A clone of HJPageMenu,Support paging scrolling"
  #项目主页地址
  s.homepage     = "https://github.com/hanwanjie853710069/HJPageMenu"
  #许可证
  s.license      = "MIT"
  #作者
  s.author             = { "Mr.H" => "471941655@qq.com" }
  #社交网址,这里我写的简书默认是Twitter,如果你写Twitter的话,你的
  s.social_media_url   = "https://www.jianshu.com/u/7f3c4198e1bd"
  #项目的地址
  s.source       = { :git => "https://github.com/hanwanjie853710069/HJPageMenu.git", :tag => s.version }
  #需要包含的源文件
  s.source_files  = "PageMenu/PageMenu/*.{swift}"
  #资源文件
  s.resources          = "PageMenu/PageMenu/*.{png,bundle,jpg}"
  #是否支持ARC
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0',
 }





end
