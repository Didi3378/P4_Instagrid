//
//  UIView.swift
//  Instagrid
//
//  Created by Diewo Wandianga on 21/09/2020.
//  Copyright © 2020 Diewo Wandianga. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func convertedImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
        
    
}
