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
	static let tracking = "tracking"
    static let allowFriendRequests = "allowFriendRequests"
}


struct PreferencesView: View {
    @AppStorage(AppPrefs.onlineMode) private var onlineMode = true
	@AppStorage(AppPrefs.tracking) private var allowTracking = true
    @AppStorage(AppPrefs.allowFriendRequests) private var allowFR = true
    
    var body: some View {
        onlineSettings
	}
    
    var onlineSettings: some View {
        
		Form {
			Section(header: Text("EnviroScanner")) {
				// master online mode toggle
				Toggle(isOn: $onlineMode) { Text("Online mode") }
				Text("Manage linked accounts")
				Text("View my data")
			}
			
			Section(header: Text("Friends")) {
				
				Text("Manage friends")
				
				// only show the rest of the online settings if the master one is enabled
				if onlineMode {
					Toggle(isOn: $allowFR) { Text("Allow friend requests") }
				}
				
			}
			
			Section(header: Text("Privacy")) {
				Text("Explore our privacy policy")
				Toggle(isOn: $allowTracking) { Text("Track shopping habits") }
			}
		}

    }
}


struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		PreferencesView()
    }
}
