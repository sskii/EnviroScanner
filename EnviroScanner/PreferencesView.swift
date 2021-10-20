//
//  PreferencesView.swift
//  EnviroScanner
//
//  Created by Pradyun Setti on 20/10/21.
//

import SwiftUI

public struct AppPrefs {
    private init(){}
    static let onlineMode = "onlineMode"
    static let allowFriendRequests = "allowFriendRequests"
}


struct PreferencesView: View {
    @AppStorage(AppPrefs.onlineMode) private var onlineMode = true
    @AppStorage(AppPrefs.allowFriendRequests) private var allowFR = true
    
    var body: some View {
        Form {
            onlineSettings
		}
	}
    
    var onlineSettings: some View {
        Section(header: Text("Online")) {
            // master online mode toggle
            Toggle(isOn: $onlineMode) { Text("Enable Online Features") }
            
            // only show the rest of the online settings if the master one is enabled
            if onlineMode {
                Toggle(isOn: $allowFR) { Text("Allow Friend Requests") }
            }
        }

    }
}


struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		PreferencesView()
    }
}
