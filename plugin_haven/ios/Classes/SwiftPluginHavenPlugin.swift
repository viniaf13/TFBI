import Flutter
import PassKit
import UIKit

class NativeButtonFactory: NSObject, FlutterPlatformViewFactory {
    var registrar: FlutterPluginRegistrar!

    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return NativeViewButton(frame:frame, viewId: viewId, args: args, registrar: registrar)
    }
}

class NativeViewButton: NSObject, FlutterPlatformView {
    var button: UIButton!

    init(frame: CGRect, viewId: Int64, args: Any?, registrar: FlutterPluginRegistrar) {
        super.init()

        button = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.black)
    }

    func view() -> UIView {
        return button
    }
}

public class SwiftPluginHavenPlugin: NSObject, FlutterPlugin {
  var viewController: UIViewController

  init(controller: UIViewController) {
    self.viewController = controller
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let controller : UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!
    let channel = FlutterMethodChannel(name: "plugin_haven", binaryMessenger: registrar.messenger())
    let instance = SwiftPluginHavenPlugin(controller: controller)
    let flutterController : FlutterViewController = controller as! FlutterViewController
    let buttonFactory = NativeButtonFactory(registrar: registrar)

    registrar.register(buttonFactory, withId: "native_button")

    registrar.addMethodCallDelegate(instance, channel: channel)
    // Add other method channels here.

  }

  func isExpirationDatePast(expirationDateString: String?) -> Bool {
    if expirationDateString == nil { return false };
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    if let expirationDate = dateFormatter.date(from: expirationDateString!) {
        let currentDate = Date()
        return currentDate > expirationDate
    } else {
        print("Error: The expiration date string is not a valid ISO 8601 date.")
        return false
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        break;
        case "getWalletPasses":
            let passLibrary = PKPassLibrary()
            if PKPassLibrary.isPassLibraryAvailable() {
                let passes = passLibrary.passes(of: .any)
                var resultArray: [[String: Any]] = []

                for pass in passes {
                    var passDict: [String: Any] = [:]

                    passDict["passTypeIdentifier"] = pass.passTypeIdentifier
                    passDict["serialNumber"] = pass.serialNumber
                    passDict["authenticationToken"] = pass.authenticationToken
                    passDict["organizationName"] = pass.organizationName
                    passDict["userInfo"] = pass.userInfo
                    // Add more properties here as needed (use mirror?)
                    resultArray.append(passDict);
                }
                result(resultArray)
            } else {
                result(FlutterError(code: "PassLibraryNotAvailable", message: "Pass Library is not available", details: nil))
            }
        break;
        case "addWalletPass":
            var filePath: String?
            guard let arguments = call.arguments as? [String : Any] else {result(false); return}

            if let path = arguments["path"] as? String {
                filePath = path
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid or missing arguments", details: nil))
                return
            }
            let pkFile : NSData = NSData(contentsOfFile: filePath!)!

            do {
                let pass = try PKPass.init(data: pkFile as Data)
                let vc = PKAddPassesViewController(pass: pass)
                self.viewController.show(vc.unsafelyUnwrapped, sender: self)
                result(true)
            }
            catch {
                result(false)
            }
        break;
        case "deleteWalletPass":
            var argumentValue: String?

            guard let arguments = call.arguments as? [String : Any] else { result(false); return }

            if let value = arguments["expiredOrBySerial"] as? String {
                argumentValue = value;
            }
            if PKPassLibrary.isPassLibraryAvailable() {
                var foundOne: Bool = false;
                let passLibrary = PKPassLibrary()
                let passes = passLibrary.passes()

                for pass in passes {
                    if argumentValue != nil {
                        if argumentValue == "expired" && !isExpirationDatePast(expirationDateString: pass.userInfo?["expirationDate"] as? String) {
                            continue
                        }
                        if argumentValue != pass.serialNumber {
                            continue
                        }
                    }
                    passLibrary.removePass(pass)
                    foundOne = true
                }
                result(foundOne)
            } else {
                result(FlutterError(code: "PassKitNotAvailable", message: "PassKit is not available on this device", details: nil))
            }
        break;
        default:
            result(FlutterMethodNotImplemented);
        break;
    }
  }
}

