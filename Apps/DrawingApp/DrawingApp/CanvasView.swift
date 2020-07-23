//
//  CanvasView.swift
//  DrawingApp
//
//  Created by jsj on 2020/07/20.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

struct TouchedPointAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]
    
    init(color: UIColor, points: [CGPoint]) {
        self.color  = color
        self.points = points
    }
    
}




class CanvasView: UIView {
    var lines = [TouchedPointAndColor]()
    var strokeWidth: CGFloat = 1.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            for (index, path) in line.points.enumerated() {
                if index == 0 { // 시작점으로 그릴위치를 옮김
                    context.move(to: path)
                } else {
                    context.addLine(to: path)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    // 1. 처음 터치 했을때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchedPointAndColor(color: UIColor(), points: [CGPoint]()))
        
        
    }
    
    // 2. 터치한 상태로 움직였을때
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first?.location(in: nil) else {
//            return
//        }
        
        guard let touch = touches.first?.location(in: self) else {
            return
        }
        
        guard var lastPoint = lines.popLast() else { return }
        
        lastPoint.points.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lastPoint.opacity = strokeOpacity
        lines.append(lastPoint)
        
        setNeedsDisplay()
    }
    
    
    func clearCanvasView(){
        lines.removeAll()
        
        // 뷰에 반영하기 위해 호출
        setNeedsDisplay()
    }
    
    func undoDraw(){
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
    
}


extension UIView {
    
    func takeScreenShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        
        return UIImage()
    }
}
