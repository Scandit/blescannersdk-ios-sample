//
//  ViewController.swift
//  BLEScannerSDKSample
//
//  Created by Giuseppe Boi on 02/05/25.
//

import UIKit
import BLEScannerSDK

class ViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textView: UITextView!

    private var host: WedgeHost?

    override func viewDidLoad() {
        super.viewDidLoad()

        host = WedgeHost(
            hostName: "My Host Name",
            projectCode: "---INSERT-YOUR-PROJECT-CODE-HERE---",
            baseUrl: "https://express.scandit.com/bluetooth",
            eventCallback: { [weak self] event in
                guard let self else {
                    return
                }

                let text = "Event: \(event.eventType), \(String(describing: event.data))\n"
                textView.text = textView.text + text
                print(text)
            }
        )

        imageView.image = try? host?.makeQRCode().generateQRCode()
    }
}

