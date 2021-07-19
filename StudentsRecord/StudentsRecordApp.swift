//
//  StudentsRecordApp.swift
//  StudentsRecord
//
//  Created by Abdullah Alnutayfi on 19/07/2021.
//

import SwiftUI

@main
struct StudentsRecordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStoreViewModel())
        }
    }
}
