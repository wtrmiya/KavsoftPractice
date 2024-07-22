//
//  Alt1UIKitRootView.swift
//  Issue_1_ButtonWithBadgeinSwiftUI
//
//  Created by Wataru Miyakoshi on 2024/07/22.
//

import UIKit

final class Alt1UIKitRootView: UIView {
  private var hierarchyReady = false
  
  private var value: Int = 0 {
    didSet {
      print("New value: \(value)")
      updateNotificationCountView()
    }
  }
  
  private lazy var incrementButton:UIButton = {
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = .black
    
    config.image = UIImage(systemName: "bell")!
      .applyingSymbolConfiguration(.init(pointSize: 26))
    
    // button
    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addAction(
      UIAction(handler: { [weak self] _ in
        guard let self else { return }
        self.incrementValue()
      })
      , for: .touchUpInside)
    button.backgroundColor = .gray
    button.layer.cornerRadius = 32
    return button
  }()
  
  private lazy var resetButton:UIButton = {
    var config = UIButton.Configuration.plain()
    let container = AttributeContainer([
      .font: UIFont.systemFont(ofSize: 16)
    ])
    config.attributedTitle = AttributedString("Reset count", attributes: container)
    
    let button = UIButton()
    button.configuration = config
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addAction(
      UIAction(handler: { [weak self] _ in
        guard let self else { return }
        self.resetValue()
      })
      , for: .touchUpInside)
    return button
  }()
  
  private lazy var notificationCountView: NotificationCountUIKitView = {
    let ncview = NotificationCountUIKitView()
    ncview.translatesAutoresizingMaskIntoConstraints = false
    return ncview
  }()
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard !hierarchyReady else { return }
    
    constructHierarchy()
    activateConstraints()
    
    hierarchyReady = true
  }
  
  private func constructHierarchy() {
    addSubview(incrementButton)
    addSubview(resetButton)
    addSubview(notificationCountView)
  }
  
  private func activateConstraints() {
    activateConstraintsIncrementButton()
    activateConstraintResetButton()
    activateConstraintsNotificationCounter()
  }
  
  private func activateConstraintsIncrementButton() {
    let centerX = incrementButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    let centerY = incrementButton.centerYAnchor.constraint(equalTo: centerYAnchor)
    let width = incrementButton.widthAnchor.constraint(equalToConstant: 64)
    let height = incrementButton.heightAnchor.constraint(equalToConstant: 64)
    NSLayoutConstraint.activate(
      [centerX, centerY, width, height]
    )
  }
  
  private func activateConstraintsNotificationCounter() {
    let topAnchor = notificationCountView.topAnchor.constraint(equalTo: incrementButton.topAnchor, constant: 20)
    let trailingAnchor = notificationCountView.trailingAnchor.constraint(equalTo: incrementButton.trailingAnchor, constant: -20)
    NSLayoutConstraint.activate(
      [topAnchor, trailingAnchor]
    )
  }
  
  private func activateConstraintResetButton() {
    let top = resetButton.topAnchor.constraint(equalTo: incrementButton.bottomAnchor)
    let centerX = resetButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate(
      [top, centerX]
    )
  }
  
  private func incrementValue() {
    print(#function)
    value += 1
  }
  
  private func resetValue() {
    print(#function)
    value = 0
  }
  
  private func updateNotificationCountView() {
    print(#function)
    notificationCountView.updateValue(value)
  }
}

final class NotificationCountUIKitView: UIView {
  private let size: CGFloat = 16.0
  private var capsuleWidthConstraint: NSLayoutConstraint?
  private lazy var capsuleWidth: CGFloat = size
  private lazy var capsuleHeight: CGFloat = size

  private let foreground: UIColor = .white
  private let background: UIColor = .red
  
  private var value: Int = 0
  
  private let capsuleView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.layer.cornerRadius = 8
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let countLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    isHidden = true
    constructHierarchy()
    activateConstraints()
  }
  
  private func constructHierarchy() {
    addSubview(capsuleView)
    addSubview(countLabel)
  }
  
  private func activateConstraints() {
    activateConstraintsCapsuleView()
    activateConstraintsCountLabel()
  }
  
  private func activateConstraintsCapsuleView() {
    let centerX = capsuleView.centerXAnchor.constraint(equalTo: centerXAnchor)
    let centerY = capsuleView.centerYAnchor.constraint(equalTo: centerYAnchor)
    capsuleWidthConstraint = capsuleView.widthAnchor.constraint(equalToConstant: capsuleWidth)
    guard let width = capsuleWidthConstraint else { return }
    let height = capsuleView.heightAnchor.constraint(equalToConstant: capsuleHeight)
    NSLayoutConstraint.activate(
      [centerX, centerY, width, height]
    )
  }
  
  private func  activateConstraintsCountLabel() {
    let centerX = countLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    let centerY = countLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    NSLayoutConstraint.activate(
      [centerX, centerY]
    )
  }

  func updateValue(_ newValue: Int) {
    print(#function)
    value = newValue
    
    if value == 0 {
      isHidden = true
    } else {
      isHidden = false
      
      if value < 100 {
        countLabel.text = "\(value)"
        if let capsuleWidthConstraint {
          capsuleWidthConstraint.constant = size * CGFloat(widthMultiplier())
        }
      } else {
        countLabel.text = "99+"
        if let capsuleWidthConstraint {
          capsuleWidthConstraint.constant = size * CGFloat(widthMultiplier())
        }
      }
    }
    
    layoutIfNeeded()
  }
  
  private func widthMultiplier() -> Double {
    if value < 10 {
      return 1.0
    } else if value < 100 {
      return 1.5
    } else {
      return 2.0
    }
  }
}
