  
1. First of all we have to install pod in ios folder for run in ios device
  open ios folder from your project and open terminal
  => enter this command in termial 
 $ sudo gem install cocoapods
 $ pod setup
 //make sure that you have already specify version of ios in your general file.
 
2. After that you have to refresh your xcode and build the app if there are something absence then you have to add into Podfile.lock
Like example and repeat 1 step for get that package in pod
  pod "BSImagePicker", "~> 2.8"
  pod 'Firebase/Analytics'
  pod 'Firebase/Core'

3. moreever i got right now if your project with the firebase then you have to put  googleService-info.plist in Runner directory

  and enjoy ios
