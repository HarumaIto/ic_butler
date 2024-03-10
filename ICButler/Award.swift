//
//  Award.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import Foundation
import RealmSwift

class Award: Object {
    @Persisted var number: Int
    @Persisted var label: String
    @Persisted var level: Int
    @Persisted var isUnlocked: Bool
    @Persisted var isObscure: Bool
}
