# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

def network 
  pod 'Alamofire'
  pod 'Kingfisher'
end

def rx
  pod 'RxSwift'
  pod 'RxCocoa'
end

def ui
  pod 'SkeletonView'
end

target 'hana-bank-test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for hana-bank-test
  rx
  network
  ui

end

deployment_target = '12.0'
