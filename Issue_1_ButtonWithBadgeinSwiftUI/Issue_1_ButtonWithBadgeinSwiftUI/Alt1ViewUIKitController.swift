//
//  Alt1ViewUIKitViewController.swift
//  Issue_1_ButtonWithBadgeinSwiftUI
//
//  Created by Wataru Miyakoshi on 2024/07/22.
//

import UIKit
import SwiftUI

struct Alt1ViewUIKitView: UIViewControllerRepresentable {
  typealias UIViewControllerType = Alt1ViewUIKitViewController
  
  func makeUIViewController(context: Context) -> Alt1ViewUIKitViewController {
    return Alt1ViewUIKitViewController()
  }
  
  func updateUIViewController(_ uiViewController: Alt1ViewUIKitViewController, context: Context) {}
}

final class Alt1ViewUIKitViewController: UIViewController {
  override func loadView() {
    view = Alt1UIKitRootView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
