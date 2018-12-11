//
//  SettingsCell.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import SSExteionComponents

// 预览协议
enum SettingsCellPreview {
    case none
    case text(String)
    case image(UIImage)
    case color(UIColor)
}

// settings cell的协议
protocol SettingsCellType: class {
    var titleText: String { get set }
    var preview: SettingsCellPreview { get set }
    var titleColor: UIColor { get set }
    var cellColor: UIColor? { get set }
    var descriptor: SettingsCellDescriptorType? { get set }
}

// settings base cell conform SettingsCellType protocol
class SettingsTableCell: UITableViewCell, SettingsCellType {
    var descriptor: SettingsCellDescriptorType?
    
    public let cellNameLabel: UILabel = {
        let label = UILabel()
        label.font = .normalLightFont
        return label
    }()
    
    let valueLabel = UILabel()
    let imagePreview = UIImageView()
    
    var titleText: String = "" {
        didSet {
            cellNameLabel.text = titleText
        }
    }
    
    var preview: SettingsCellPreview = .none {
        didSet {
            switch preview {
            case .text(let string):
                valueLabel.text = string
                imagePreview.image = .none
                imagePreview.backgroundColor = UIColor.clear
                imagePreview.accessibilityValue = nil
                imagePreview.isAccessibilityElement = false
            case .color(let color):
                valueLabel.text = ""
                imagePreview.image = .none
                imagePreview.backgroundColor = color
                imagePreview.accessibilityValue = "color"
                imagePreview.isAccessibilityElement = true
            case .image(let image):
                valueLabel.text = ""
                imagePreview.image = image
                imagePreview.backgroundColor = UIColor.clear
                imagePreview.accessibilityValue = "image"
                imagePreview.isAccessibilityElement = true
            case .none:
                valueLabel.text = ""
                imagePreview.image = .none
                imagePreview.backgroundColor = UIColor.clear
                imagePreview.accessibilityValue = nil
                imagePreview.isAccessibilityElement = false
            }
        }
    }
    
    var titleColor: UIColor = UIColor.white {
        didSet {
            cellNameLabel.textColor = titleColor
        }
    }
    
    var cellColor: UIColor? {
        didSet {
            backgroundColor = cellColor
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        updateBackgroundColor()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        preview = .none
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        backgroundView = UIView()
        selectedBackgroundView = UIView()
        
        imagePreview.clipsToBounds = true
        imagePreview.layer.cornerRadius = 12
        imagePreview.contentMode = .scaleAspectFill
        imagePreview.accessibilityIdentifier = "imagePreview"
        contentView.addSubview(imagePreview)
        contentView.addSubview(cellNameLabel)
        contentView.addSubview(valueLabel)
        
        cellNameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20.0)
            make.width.lessThanOrEqualTo(200.0)
            make.bottom.equalToSuperview().offset(-10.0)
        }
        
        valueLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.cellNameLabel.snp.right).offset(10.0)
            maker.top.height.equalTo(self.cellNameLabel)
            maker.right.lessThanOrEqualTo(self.imagePreview.snp.left)
        }
        
        imagePreview.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.0)
            maker.centerY.equalToSuperview()
            maker.left.equalTo(self.valueLabel.snp.right)
        }
    }
    
    func setupAccessibilityElements() {
        var currentElements = accessibilityElements ?? []
        currentElements.append([cellNameLabel, valueLabel, imagePreview])
        accessibilityElements = currentElements
    }
    
    func updateBackgroundColor() {
        if let _ = cellColor {
            return
        }
        if isHighlighted && selectionStyle != .none {
            backgroundColor = UIColor(white: 0, alpha: 0.2)
        }else {
            backgroundColor = UIColor.clear
        }
    }
    
}


@objcMembers class SettingsTextCell: SettingsTableCell, UITextFieldDelegate {
    var textInput: UITextField!
    
    override func setup() {
        super.setup()
        selectionStyle = .none
        
        textInput = UITextField.init(frame: .zero)
        textInput.delegate = self
        textInput.textAlignment = .left
        textInput.textColor = UIColor.lightGray
        textInput.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        contentView.addSubview(textInput)
        
        createConstraints()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCellSelected(_:)))
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func createConstraints() {
        let textInputSpaceing = CGFloat(16)
        let trailingBoundaryView = accessoryView ?? contentView
        textInput.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalTo(trailingBoundaryView).inset(textInputSpaceing)
        }
        cellNameLabel.snp.makeConstraints {
            $0.trailing.equalTo(textInput.snp.leading).inset(textInputSpaceing)
        }
    }
    
    override func setupAccessibilityElements() {
        super.setupAccessibilityElements()
        var currentElements = accessibilityElements ?? []
        currentElements.append(textInput)
        accessibilityElements = currentElements
    }
    
    @objc func onCellSelected(_ tap: UITapGestureRecognizer) {
        if !textInput.isFirstResponder {
            textInput.becomeFirstResponder()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: CharacterSet.newlines) != .none {
            textField.resignFirstResponder()
            return false
        }else { return true }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textInput.text {
            descriptor?.select(SettingsPropertyValue.string(value: text))
        }
    }
}
