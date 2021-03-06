//
//  PanGestureViewController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 24/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia

class BoxView: UIView {
  var lastLocation = CGPoint(x: 0, y: 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
    self.gestureRecognizers = [panRecognizer]
    self.hideElevation()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastLocation = self.center
    UIView.animate(withDuration: 0.3,
                   delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: .curveLinear,
                   animations: {
                    self.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
                    self.showElevation()
                    self.layoutIfNeeded()
    }, completion: {_ in
    })
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.onTouchEnded()
  }
  
  func onTouchEnded() {
    UIView.animate(withDuration: 0.1,
                   delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: .curveLinear,
                   animations: {
                    self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.hideElevation()
                    self.layoutIfNeeded()
    }, completion: {_ in
    })
  }
  
  @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
    if (recognizer.state == .ended) {
      self.onTouchEnded()
    }
    let translation  = recognizer.translation(in: self.superview)
    let pX = lastLocation.x + translation.x
    let pY = lastLocation.y + translation.y
    if pX > self.bounds.width / 2 && pY > self.bounds.height / 2 && pX < (self.superview?.bounds.size.width)! - self.bounds.width / 2 && pY < (self.superview?.bounds.size.height)! - self.bounds.height / 2 {
      self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
  }
  
  func showElevation() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 5.0
  }
  func hideElevation() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.layer.shadowOpacity = 0.2
    self.layer.shadowRadius = 1.0
  }
}

class PanGestureVC: UIViewController {
  let box = BoxView()
  let safeAreaContainer = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.fillContainer(20)
    self.view.backgroundColor = .white
    self.view.sv(safeAreaContainer)
    safeAreaContainer.Top == self.view.safeAreaLayoutGuide.Top
    safeAreaContainer.Bottom == self.view.safeAreaLayoutGuide.Bottom
    safeAreaContainer.fillContainer()
    safeAreaContainer.sv(box)
    box.height(100)
    box.width(100)
    box.backgroundColor = .yellow
    box.layer.cornerRadius = 10
    box.centerHorizontally()
    box.centerVertically()
  }
}
