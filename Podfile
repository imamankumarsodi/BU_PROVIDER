# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BU_PROVIDER' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BU_PROVIDER
  pod 'IQKeyboardManagerSwift'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'lottie-ios'
  pod 'DropDown','2.3.4'
  pod 'SDWebImage', '~> 5.0'
  pod 'ViewAnimator'
  pod 'lottie-ios'
  pod 'Alamofire','~> 4.9.0'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'Firebase/Performance'
  pod 'TPKeyboardAvoiding'
  pod 'ReachabilitySwift'
  pod 'DropDown','2.3.4'
  pod 'SwipeCellKit'
  pod 'XCGLogger', '~> 7.0.1'
  pod 'GoogleSignIn'
  pod 'FBSDKCoreKit' 
  pod 'FBSDKLoginKit' 
  pod 'FacebookCore' 
  pod 'FacebookLogin'
  pod 'SkeletonView'
  #pod 'KYDrawerController'

  target 'BU_PROVIDERTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BU_PROVIDERUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
