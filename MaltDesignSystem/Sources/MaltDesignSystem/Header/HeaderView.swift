//
//  HeaderView.swift
//  
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import UIKit

public class HeaderView: UIView {
    static let identifier = "HeaderView"
    
    @IBOutlet weak var separator: UIView!
    private var viewModel:HeaderViewModel?
    private var designSystem:DesignSystem?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    public init() {
        super.init(frame: .zero)
        loadNib()
    }
    
    public func set(viewModel:HeaderViewModel, designSystem: DesignSystem) {
        self.viewModel = viewModel
        self.designSystem = designSystem
        setStyle()
    }
    
    func setStyle() {
        separator.backgroundColor = designSystem?.colorToken.divider
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.viewModel?.onBack()
    }

    private func loadNib() {
        let nib = UINib(nibName: HeaderView.identifier, bundle: .module)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(contentView)
    }
}
