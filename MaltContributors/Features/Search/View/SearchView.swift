//
//  SearchView.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import UIKit
import MaltDesignSystem

public final class SearchView: UIView {
    static let identifier = "SearchView"

    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    private var designSystem: DesignSystem?
    private var viewModel: SearchViewModel?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    public init() {
        super.init(frame: .zero)
        loadNib()
    }
    
    func set(viewModel:SearchViewModel, designSystem: DesignSystem) {
        self.designSystem = designSystem
        self.viewModel = viewModel
        
        setStyle()
        updateUI()
    }
    
    func setStyle() {
        self.layer.cornerRadius = 35.0
        self.layer.borderColor = designSystem?.colorToken.border.cgColor
        self.layer.borderWidth = CGFloat(2)

        validateButton.setStyle(buttonStyle: .primary)
    }
    
    func updateUI() {
        textField.placeholder = viewModel?.placeholder
        validateButton.setTitle(viewModel?.buttonLabel, for: .normal)
    }

    @IBAction func validateAction(_ sender: Any) {
        guard let text = textField.text else { return }
        viewModel?.onValidate(text)
    }

    private func loadNib() {
        let nib = UINib(nibName: SearchView.identifier, bundle: .main)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(contentView)
    }
    
}
