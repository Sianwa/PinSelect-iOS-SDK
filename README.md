# PinOnMobile iOS Library

A secure iOS library designed for handling PIN change operations, integrating a web view for 3D Secure (3DS) authentication and utilizing MQTT for secure communication.

## Features

  * Initiates PIN change workflows.
  * Integrates a web view for 3D Secure (3DS) / Cardinal Commerce interactions.
  * Uses MQTT for asynchronous, real-time communication with backend services.
  * Environment configuration (Production vs. UAT) determined by the backend response.

## Installation

`PinOnMobile` is distributed as a pre-built `XCFramework`. Follow these steps to integrate it into your iOS project:

1.  **Obtain XCFrameworks:**
    Ensure you have the following `XCFrameworks`:

      * `PinOnMobileLib.xcframework`
      * `CocoaMQTT.xcframework`
      * `MQTTCocoaAsyncSocket.xcframework`
      * `Starscream.xcframework`

2.  **Add to Xcode Project:**

      * Open your Xcode project.
      * Drag and drop all four `.xcframework` bundles (listed above) into your Xcode project's Project Navigator (e.g., into a `Frameworks` group).
      * In the dialog that appears, ensure "Copy items if needed" is checked and "Add to targets" is selected for your application target.

3.  **Configure Build Settings:**

      * Select your application target in the Project Navigator.
      * Go to the **"General"** tab.
      * Scroll down to **"Frameworks, Libraries, and Embedded Content"**.
      * Verify that all four frameworks (`PinOnMobileLib.xcframework`, `CocoaMQTT.xcframework`, `MQTTCocoaAsyncSocket.xcframework`, `Starscream.xcframework`) are listed.
      * For each of these frameworks, ensure the **"Embed"** setting is set to **"Embed & Sign"**. This is essential for dynamic frameworks.

## Dependencies

`PinOnMobile` relies on the following third-party libraries. These must be linked alongside `PinOnMobileLib.xcframework`:

  * [CocoaMQTT](https://github.com/emqtt/CocoaMQTT) (MQTT client library)
  * [MQTTCocoaAsyncSocket](https://www.google.com/search?q=https://github.com/emqtt/MQTTCocoaAsyncSocket) (Underlying socket library for CocoaMQTT)
  * [Starscream](https://github.com/daltoniam/Starscream) (WebSocket client library, likely used by CocoaMQTT's underlying mechanisms or directly by your implementation)

## Usage

### 1\. Initialize and Configure

`PinOnMobile` uses a singleton pattern. You interact with its shared `instance`. The MQTT host URL is determined by the `isProdEnvironment` flag you pass to `changePin`.

```swift
import PinOnMobile // Your library module
// ... other imports

// In your app's code, where you initiate the PIN change flow.
// This example assumes you've received initializationResponseObject from your backend.

// Example InitializationResponseModel (replace with your actual model)
struct InitializationResponseModel {
    let responseCode: String
    let responseMessage: String
    let callbackUrl: String
    let id: Int
    let instid: Int
    let uuid: String
}

// ...
```

### 2\. Perform PIN Change

Call the `changePin` method, passing the `InitializationResponseModel`, the environment flag, and the current `UIViewController` for presentation.

```swift
// Example in a UIViewController:

class MyViewController: UIViewController, PinOnMobileDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        PinOnMobile.instance.PinOnMobileDelegate = self // Set the delegate
    }

    func initiatePinChangeFlow() {
        Task {
            do {
                // 1. Prepare your InitializationResponseModel
                //    (Ideally, this comes from your backend)
                let respObj = InitializationResponseModel(
                    responseCode: "0",
                    responseMessage: "true",
                    callbackUrl: "https://pom-test.interswitch-ke.com/c713b770-e845-4854-b34b-05a2977427ef?callbackUrl=www.google.com",
                    id: 0,
                    instid: 0,
                    uuid: "c713b770-e845-4854-b34b-05a2977427ef"
                )

                // 2. Determine the environment (e.g., from your backend's response)
                let isProductionEnvironment: Bool = false // Example: Set to 'true' for Prod, 'false' for UAT.
                                                         
                // 3. Call the changePin method
                try PinOnMobile.instance.changePin(
                    initializationResponseObject: respObj,
                    isProdEnvironment: isProductionEnvironment, // Pass the environment flag
                    previousUIViewController: self // The current UIViewController
                ) { completionMessage in
                    // This completion block is triggered when the MQTT transaction is done.
                    self.showResponse(message: completionMessage)
                }
            } catch PinOnMobile.NetworkError.invalidData {
                self.showResponse(message: "Value passed is incorrect. Please verify and try again")
            } catch {
                self.showResponse(message: error.localizedDescription)
            }
        }
    }

    private func showResponse(message: String) {
        // Implement your UI logic to display the response message
        print("PIN Change Response: \(message)")
        // e.g., Display an alert, update a label, etc.
    }

    // ... other UIViewController code
}
```

### 3\. Handle Responses (Delegate)

Implement the `PinOnMobileDelegate` protocol in your presenting `UIViewController` to receive payload information during the 3DS process (if applicable).

```swift
// In your UIViewController, conform to the delegate protocol:
extension MyViewController: PinOnMobileDelegate {
    func launchUIPayload(_ message: String) {
        // This method will be called when the library needs to provide a UI payload.
        // Implement your logic here to handle this message, e.g., to display a web view.
        print("Received UI Payload: \(message)")
    }
}
```

## Important Notes

### UIViewController Presentation

  * The `changePin` method requires a `previousUIViewController` to present the 3DS web view. Ensure this `UIViewController` is capable of presenting modal views and has a `UINavigationController` if popping is expected.
