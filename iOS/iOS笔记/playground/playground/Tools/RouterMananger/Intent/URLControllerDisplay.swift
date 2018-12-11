//
//  URLControllerDisplay.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

public protocol ControllerDisplaydelegate {
    func displayViewController(from source: UIViewController, to destination: UIViewController) -> Void
}

public enum IntentDisplayType {
    case push
    
    case present
    
    func fetchDisplayer() -> ControllerDisplaydelegate {
        switch self {
        case .push:
            return ControllerPushDisplay()
        case .present:
            return ControllerPresentDisplay()
        }
    }
}

class ControllerPushDisplay: ControllerDisplaydelegate {
    func displayViewController(from source: UIViewController, to destination: UIViewController) {
        if let navigationController = source.navigationController {
            navigationController.pushViewController(destination, animated: true)
        }
    }
}


class ControllerPresentDisplay: ControllerDisplaydelegate {
    func displayViewController(from source: UIViewController, to destination: UIViewController) {
        let nav = UINavigationController.init(rootViewController: destination)
        source.present(nav, animated: true, completion: nil)
    }
}
