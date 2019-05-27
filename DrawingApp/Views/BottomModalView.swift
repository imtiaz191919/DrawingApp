//
//  BottomModalView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 27/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia


class BottomModalView: UIView {
  var dialogView = UIView()
  var titleLabel = UILabel()
  var screenSize = UIScreen.main.bounds
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.height(screenSize.height)
    self.width(screenSize.width)
    self.backgroundColor = UIColor(white: 0, alpha: 0.5)
    
    
    self.sv(dialogView)
    dialogView.sv(titleLabel)
    setupLayout()
    animateIn()
    
    let gesture = UITapGestureRecognizer(target: self,  action: #selector(dismissDialog))
    let dialogGesture = UITapGestureRecognizer(target: self,  action: #selector(doNothing))
    self.addGestureRecognizer(gesture)
    self.dialogView.addGestureRecognizer(dialogGesture)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  func setupLayout() {
    dialogView.height(300)
    dialogView.width(300)
    dialogView.centerHorizontally()
    dialogView.Bottom == safeAreaLayoutGuide.Bottom
    dialogView.layer.cornerRadius = 8
    dialogView.backgroundColor = .white
    
    titleLabel.text = "BOTTOM MODAL"
    titleLabel.centerVertically()
    titleLabel.centerHorizontally()
  }
  
  func animateIn() {
    self.dialogView.transform = CGAffineTransform.init(translationX: 0, y: screenSize.height)
    self.dialogView.alpha = 0
    self.alpha = 0
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
      self.dialogView.alpha = 1
      self.alpha = 1
      self.dialogView.transform = .identity
    })
  }
  
  func animateOut() {
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
      self.dialogView.alpha = 0
      self.alpha = 0
      self.dialogView.transform = CGAffineTransform.init(translationX: 0, y: self.screenSize.height)
    }) { (complete) in
      if complete {
        self.removeFromSuperview()
      }
    }
  }
  
  @objc func dismissDialog() {
    animateOut()
    let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
    navigationController.setNavigationBarHidden(false, animated: true)
  }
  
  @objc func doNothing() {
    // DO NOTHING
  }
}
