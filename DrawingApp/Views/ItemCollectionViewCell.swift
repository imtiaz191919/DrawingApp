//
//  ItemCollectionViewCell.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 20/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Stevia
import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
  
  var item: APODPicture!
  var collectionView: UICollectionView!
  let contentContainer = UIView()
  let descriptionLabel = UILabel()
  let imageView = UIImageView()
  
  let imageContainer = UIView()
  let dateLabel = UILabel()
  let closeIcon = UIButton(type:UIButton.ButtonType.contactAdd)
  let descriptionLabelContainer = UIView()
  
  var isOpen: Bool = false
  var frameWhileExpanding: CGRect!
  
  func setupView() {
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
    contentView.layer.shadowOpacity = 0.5
    contentView.layer.shadowRadius = 2.0
    
    self.contentView.sv(contentContainer)
    contentContainer.fillContainer()
    contentContainer.layer.cornerRadius = 10
    contentContainer.layer.masksToBounds = true
    contentContainer.backgroundColor = .white
    
    contentContainer.sv(imageContainer, descriptionLabelContainer)
    imageContainer.Top == contentContainer.Top
    imageContainer.height(50%)
    imageContainer.fillHorizontally()
    imageContainer.centerHorizontally()
    imageContainer.clipsToBounds = true
    imageContainer.backgroundColor = .white
    
    descriptionLabelContainer.Top == imageContainer.Bottom
    descriptionLabelContainer.height(50%)
    descriptionLabelContainer.fillHorizontally()
    descriptionLabelContainer.centerHorizontally()
  
    imageContainer.sv(imageView, dateLabel, closeIcon)
    dateLabel.Top == 20
    dateLabel.Left == 20
    dateLabel.textColor = UIColor.white
    
    imageView.fillContainer()
    imageView.contentMode = .scaleAspectFill
    
    closeIcon.Top == 20
    closeIcon.Right == 20
    closeIcon.isHidden = true
    closeIcon.tintColor = .white
    closeIcon.addTarget(self, action: #selector(swipeAction), for:.touchUpInside)
    closeIcon.transform = CGAffineTransform(rotationAngle: 22.5)
    
    descriptionLabelContainer.sv(descriptionLabel)
    descriptionLabel.fillContainer(20)
    descriptionLabel.numberOfLines = 0
    
    setContent()
  }
  
  func setContent() {
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
    gestureRecognizer.direction = [.down]
    self.addGestureRecognizer(gestureRecognizer)
    
    self.dateLabel.text = item.date
    
    // getting image from url
    if let url = URL(string: self.item.url ?? "") {
      self.imageView.sd_setImage(with: url, completed: nil)
    }
    
    descriptionLabel.text = item.explanation
  }
  
  func expand(bounds: CGRect) {
    self.frameWhileExpanding = self.frame
    closeIcon.isHidden = false
    self.superview?.bringSubviewToFront(self)
    UIView.animate(withDuration: 0.8,
                   delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: .curveLinear,
                   animations: {
                    self.isSelected = true
                    self.frame = bounds
                    self.contentContainer.layer.cornerRadius = 0
                    self.layoutIfNeeded()
    }, completion: {_ in
      self.isOpen = true
    })
  }
  
  func collapse() {
    closeIcon.isHidden = true
    UIView.animate(withDuration: 0.8,
                   delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: .curveLinear,
                   animations: {
                    self.isSelected = false
                    self.frame = self.frameWhileExpanding
                    self.contentContainer.layer.cornerRadius = 10
                    self.layoutIfNeeded()
    }, completion: { _ in
      self.isOpen = false
    })
  }
  
  func pressInAnimation() {
    if isOpen {
      return
    }
    UIView.animate(withDuration: 0.4, delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: .curveEaseInOut,
                   animations: {
                    self.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }, completion: nil)
  }
  
  func pressOutAnimation() {
    if isOpen {
      return
    }
    UIView.animate(withDuration: 0.1,
                   delay: 0.0,
                   usingSpringWithDamping: 0.3,
                   initialSpringVelocity: 0.3,
                   options: .curveEaseIn,
                   animations: {
                    self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }, completion: nil)
  }
  
  
  @objc func tapAction(sender: UITapGestureRecognizer){
    if !self.isOpen {
      self.expand(bounds: collectionView.bounds)
      collectionView.isScrollEnabled = false
    }
  }
  
  @objc func swipeAction(sender: UISwipeGestureRecognizer){
    if self.isOpen {
      self.collapse()
      collectionView.isScrollEnabled = true
    }
  }
}

