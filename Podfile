# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AWSMobileClientAuthSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  SDK_Version = '~> 2.20.0'
  LCOAL_PATH = '../../aws-sdk-ios'
  
  unless LCOAL_PATH.to_s.strip.empty?
    pod 'AWSMobileClient', :path => LCOAL_PATH
    pod 'AWSAuthUI', :path => LCOAL_PATH
    pod 'AWSUserPoolsSignIn', :path => LCOAL_PATH
    
    pod 'AWSFacebookSignIn', :path => LCOAL_PATH
    pod 'AWSGoogleSignIn', :path => LCOAL_PATH
  else
    pod 'AWSMobileClient', SDK_Version
    pod 'AWSAuthUI', SDK_Version
    pod 'AWSUserPoolsSignIn', SDK_Version
    
    pod 'AWSFacebookSignIn', SDK_Version
    pod 'AWSGoogleSignIn', SDK_Version
  end
  
  pod 'GoogleSignIn', '~> 4.0'
  
end
