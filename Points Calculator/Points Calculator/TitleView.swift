//
//  TitleView.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-01.
//  Copyright © 2018 Reid. All rights reserved.
//

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

import Foundation
import UIKit
import SnapKit

class TitleView: UIView {
    let newButton = UIButton()
    let height:CGFloat = 30.0
    let summary = UIButton()
    var title: String = "Hep/Dec"
    
    init(_ title: String) {
        //self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        newButton.snp.makeConstraints { (make) in
           make.top.height.leading.equalTo(safeAreaLayoutGuide)
        }
        let newImage = UIImage(contentsOfFile: "add.png")!
        let scale = height/newImage.size.height
        let newWidth = scale * newImage.size.width
        let logo = newImage.scaleImage(toSize: CGSize(width: newWidth, height: height))
        newButton.setImage(logo, for: UIControl.State.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
