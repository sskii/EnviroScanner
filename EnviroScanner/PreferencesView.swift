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
		NavigationView {
			Form {
				envrioSettings
				friendsSettings
				privacySettings
			}
			.navigationBarHidden(true)
			.onAppear { UITableView.appearance().backgroundColor = .clear } // removes the grey background on forms to make it fit in with the rest of the app
			// .onDisappear { UITableView.appearance().backgroundColor = .systemGroupedBackground }
		}
	}
	
	var envrioSettings: some View {
		Section(header: Text("EnviroScanner")) {
			// master online mode toggle
			Toggle(isOn: $onlineMode) { Text("Online mode") }
			
			NavigationLink { Text("Linked Accounts")} label: {
				Text("Manage Linked Accounts")
			}
		}
	}
	
	
	var friendsSettings: some View {
		Section(header: Text("Friends")) {
			Text("Manage friends")
			// only show the rest of the online settings if the master one is enabled
			if onlineMode {
				Toggle(isOn: $allowFR) { Text("Allow friend requests") }
			}
		}
	}
	
	var privacySettings: some View {
		Section(header: Text("Privacy")) {
			Toggle(isOn: $allowTracking) { Text("Track shopping habits") }
			
			NavigationLink {Text( "Privacy Policy") } label: {
				Text("Explore our Privacy Policy")
			}
			NavigationLink { Text("data") } label: {
				Text("View your Data")
			}
		}
	}
}



struct PreferencesView_Previews: PreviewProvider {
	static var previews: some View {
		PreferencesView()
	}
}
