//
//  ChatStyling.swift
//  Runner
//
//  Created by Eliseu Codinhoto on 07/01/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import ZDCChat

//  The converted code is limited to 2 KB.
//  Upgrade your plan to remove this limitation.
//
//  Converted to Swift 5.1 by Swiftify v5.1.28520 - https://objectivec2swift.com/
class ChatStyling {
    class func apply() {
        let primaryBlue = UIColor(red:0.13, green:0.27, blue:1.00, alpha:1.0)
        
        let visitorCell = ZDCVisitorChatCell.appearance()
        visitorCell.bubbleColor = primaryBlue
        visitorCell.bubbleBorderColor = primaryBlue
        visitorCell.textColor = .white
        
        let chatUI = ZDCChatUI.appearance()
        chatUI.tintColor = primaryBlue
        chatUI.chatBackgroundColor = primaryBlue
        chatUI.backgroundColor = primaryBlue
        
        ZDCChat.instance().overlay.setEnabled(false)
    }
}
