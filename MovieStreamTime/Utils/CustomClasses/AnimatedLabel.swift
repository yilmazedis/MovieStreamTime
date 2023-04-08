//
//  AnimatedLabel.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

class AnimatedLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startScrolling()
    }
    
    private func startScrolling() {
        let scrollDuration: Double = 10.0 // Adjust as needed
        let labelWidth = frame.width
        let textWidth = text!.size(withAttributes: [.font: font!]).width
        let scrollDistance = labelWidth - textWidth
        
        // Only scroll if the text is wider than the label
        //guard scrollDistance < 0 else { return }
        
        // Create a CABasicAnimation to animate the transform property
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = scrollDuration
        animation.fromValue = CATransform3DIdentity
        animation.toValue = CATransform3DMakeTranslation(CGFloat(scrollDistance), 0, 0)
        animation.repeatCount = .infinity
        
        // Add the animation to the layer
        layer.add(animation, forKey: "scrollAnimation")
    }
}
