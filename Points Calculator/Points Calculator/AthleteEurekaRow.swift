//
//  AthleteEurekaRow.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-12.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
/*import Eureka

private final class AthleteEurekaRow : Eureka._PushRow<AthleteCell>, RowType {
    public init(_ tag: String?, _ initializer: (AthleteEurekaRow) -> Void) {
        <#code#>
    }
    
    private typealias Cell = AthleteCell

    public override func updateCell() {
        <#code#>
    }
    
    public override func didSelect() {
        <#code#>
    }
    
    /*public override func validate() -> [ValidationError] {
        <#code#>
    }*/
    
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .Show(controllerProvider: ControllerProvider.Callback { return AddMusicViewController(){ _ in } }, completionCallback: { vc in vc.navigationController?.popViewControllerAnimated(true) })
        displayValueFor = {
            guard var musicTitle = $0 else { return "" }
            musicTitle = musicTemp!
            let representativeItem = musicTitle.representativeItem
            print("representativeItem = \(representativeItem)")
            let representativeItemTitle = representativeItem?.title
            return  "\(representativeItemTitle)"
        }
    }
}
*/
