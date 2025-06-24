//
//  ViewController.swift
//  BLEScannerSDKSample
//
//  Created by Giuseppe Boi on 02/05/25.
//

import UIKit
import BLEScannerSDK

class ViewController: UIViewController {
    private enum Consts {
        static let reuseIdentifier = "tableViewCell"
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!

    private var host: WedgeHost?
    private var events: [WedgeHostEvent] = []

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

                let text = "Event: \(event.eventType), \(event.data ?? "-")\n"
                print(text)
                events.insert(event, at: 0)
                tableView.insertRows(
                    at: [.init(row: 0, section: 0)],
                    with: .automatic)
            }
        )

        imageView.image = try? host?.makeQRCode().generateQRCode()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Consts.reuseIdentifier,
            for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(events[indexPath.row].eventType)"
        content.secondaryText = events[indexPath.row].data
        cell.contentConfiguration = content
        return cell
    }
}
