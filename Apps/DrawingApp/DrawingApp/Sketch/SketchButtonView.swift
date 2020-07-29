//
//  SketchButtonView.swift
//  DrawingApp
//
//  Created by jsj on 2020/07/29.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

protocol SketchButtonViewDelegate: class {
    func tapPenButton()
    func tapEraserButton()
    func tapUndoButton()
    func tapRedoButton()
    func tapClearButton()
    func tapPaletteButton()
    func tapFillButton()
    func tapStampButton()
    func tapFigureButton()
    func tapFilterButton()
    func tapCameraButton()
}

class SketchButtonView: UIView {
    weak var delegate: SketchButtonViewDelegate?
    
    
    class func instanceFromNib(_ delegate: SketchButtonViewDelegate?) -> SketchButtonView {
        let buttonView : SketchButtonView = UINib(
            nibName: "SketchButtonView",
            bundle: Bundle.main
            ).instantiate(
                withOwner: self,
                options: nil
            ).first as! SketchButtonView
        
        buttonView.delegate = delegate
        
        return buttonView
    }
    
    
    // Tap pen Button
    @IBAction func tapPenButton(_ sender: Any) {
        delegate?.tapPenButton()
    }
    
    // Tap Eraser Button
    @IBAction func tapEraserButton(_ sender: Any) {
        delegate?.tapEraserButton()
    }
    
    // Tap Undo Buddon
    @IBAction func tapUndoButton(_ sender: Any) {
        delegate?.tapUndoButton()
    }
    
    // Tap Redo Button
    @IBAction func tapRedoButton(_ sender: Any) {
        delegate?.tapRedoButton()
    }
    
    // Tap Clear Button
    @IBAction func tapClearButton(_ sender: Any) {
        delegate?.tapClearButton()
    }
    
    // Tap Palette Button
    @IBAction func tapPaletteButton(_ sender: Any) {
        delegate?.tapPaletteButton()
    }
    
    // Tap Fill Button
    @IBAction func tapFillButton(_ sender: Any) {
        delegate?.tapFillButton()
    }
    //
    @IBAction func tapStampButton(_ sender: Any) {
        delegate?.tapStampButton()
    }
    
    @IBAction func tapFigureButton(_ sender: Any) {
        delegate?.tapFigureButton()
    }
    
    @IBAction func tapFilterButton(_ sender: Any) {
        delegate?.tapFilterButton()
    }
    
    @IBAction func tapCameraButton(_ sender: Any) {
        delegate?.tapCameraButton()
    }
    
}

