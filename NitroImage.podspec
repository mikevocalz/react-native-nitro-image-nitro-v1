require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

# React Native CLI 20 still requires a podspec to discover iOS dependencies.
# Native sources and dependencies are built through Package.swift (Nitro V1).
Pod::Spec.new do |s|
  s.name         = "NitroImage"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
  s.source       = { :git => "https://github.com/mrousavy/react-native-nitro-image.git", :tag => "#{s.version}" }
  s.ios.deployment_target = "16.0"
  s.visionos.deployment_target = "1.0"
end
