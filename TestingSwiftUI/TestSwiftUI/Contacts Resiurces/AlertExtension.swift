//
//  AlertExtensiin.swift
//  ContactBook
//
//  Created by Nato Egnatashvili on 15.01.22.
//

import SwiftUI

class AlertExtension {
    static let shared = AlertExtension()
    func alert(_  action:  @escaping (String, String) -> Void) {
        var txtField = UITextField()
        var txtField2 = UITextField()
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        alert.addTextField() { textField in
            txtField = textField
            textField.placeholder = "Enter some text"
        }
        alert.addTextField() { textField in
            txtField2 = textField
            textField.placeholder = "Enter some mobile nom"
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
            action(txtField.text ?? "",
                   txtField2.text ?? "")
        })
        showAlert(alert: alert)
    }

    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }

    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }

}
