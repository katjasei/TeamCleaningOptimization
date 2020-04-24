//
//  UIResponderExtension.swift
//  TeamCleaningOptimisation
//
//  Created by iosdev on 24.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//
import UIKit

extension UIResponder {
    func removeUndoRedoOptions() {
        //Removes Undo, Redo, Copy & Paste options
        inputAssistantItem.leadingBarButtonGroups = []
        inputAssistantItem.trailingBarButtonGroups = []
    }
}
