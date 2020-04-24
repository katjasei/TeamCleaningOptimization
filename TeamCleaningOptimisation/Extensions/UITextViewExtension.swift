//
//  UITextViewExtension.swift
//  TeamCleaningOptimisation
//
//  Created by iosdev on 24.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

extension UITextView {
    func hideSuggestions() {
        // Removes suggestions only
        autocorrectionType = .no
        //Removes Undo, Redo, Copy & Paste options
        removeUndoRedoOptions()
    }
}
