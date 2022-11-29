//
//  NodataViewController.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import UIKit
import MaltDesignSystem

class NodataViewController: UIViewController {
    @IBOutlet var containerView: HeaderView!
    private var designSystem: DesignSystem?
    private var nodataViewModel: NodataViewModel?
    
    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let header = HeaderViewModel(onBack: onBack)
        if let designSystem = self.designSystem {
            containerView.set(viewModel: header, designSystem: designSystem)
        }
        
        setStyle()
        updateUI()
    }
    
    func updateUI() {
        button.setTitle(String(localized:"no_date_view_button"), for: .normal)
        descriptionLabel.text = String(localized: "no_date_view_description")
        largeTitleLabel.text = String(localized: "no_date_view_title")
    }
    
    func setStyle() {
        descriptionLabel.textColor = designSystem?.colorToken.title
        descriptionLabel.font = designSystem?.fontToken.subTitle
        
        largeTitleLabel.textColor = designSystem?.colorToken.title
        largeTitleLabel.font = designSystem?.fontToken.title

        self.view.backgroundColor = designSystem?.colorToken.background
        
        button.setStyle(buttonStyle: .primary)
    }

    func set(viewModel: NodataViewModel, designSystem:DesignSystem) {
        self.nodataViewModel = viewModel
        self.designSystem = designSystem
    }
    
    @IBAction func backAction(_ sender: Any) {
        nodataViewModel?.goBack()
    }
    
    func onBack() {
        nodataViewModel?.goBack()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
