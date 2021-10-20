//
//  ScanHistory.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct HistoryView: View {
	
	@State var expandedHistory: Bool = false
	
	var body: some View {
		
		StandardSection {
			
			HStack {
				
				Text("Recent activity")
					.font(.headline)
				
				Spacer()
				
				Button {
					expandedHistory.toggle()
				} label: {
					Text("view more")
				} .sheet(isPresented: $expandedHistory) {
					
					StandardSection {
						Text("Huh, this doesn't exist yet either")
						Text("Keep lookin' around though :)")
					}
					
				}
			}
			
			HistoryGroup(heading: "Today", score: 2, accent: Color("averageMed")) {
				
				HistoryItem(name: "Pams Oats", value: "Poor")
				HistoryItem(name: "Loose Cabbage", value: "Good")
				
			}
			
			HistoryGroup(heading: "Yesterday", score: 1, accent: Color("poorMed")) {
				
				HistoryItem(name: "Cadbury Dairy Milk", value: "Poor")
				HistoryItem(name: "Nestle Kit-Kat", value: "Poor")
				
			}
			
			HistoryGroup(heading: "Last week", score: 3, accent: Color("themeMed")) {
				
				HistoryItem(name: "Watties Spaghetti", value: "Good")
				HistoryItem(name: "Pams Baked Beans", value: "Good")
				HistoryItem(name: "Earthwise Laundry Powder", value: "Good")
				HistoryItem(name: "Sanitarium Weet-Bix", value: "Average")
				
			}
			
//			Text("That's all we've got.")
//				.padding(.top, 16)
			
		}
		
	}
	
}

struct HistoryGroup<Content: View>: View {
	
	let content: Content
	let heading: String
	let score: Int
	let accent: Color
	
	init(heading: String, score: Int, accent: Color, @ViewBuilder content: () -> Content) {
		self.heading = heading
		self.score = score
		self.accent = accent
		self.content = content()
	}
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 4) {
		
			HStack(spacing: 0) {
				GroupTitle(text: heading, accent: self.accent)
				Spacer()
				
				ForEach(1...score, id:\.self) { _ in
					Image(systemName: "star.fill")
						.font(.system(size: 14))
				}
				ForEach(score..<3, id:\.self) { _ in
					Image(systemName: "star")
						.font(.system(size: 14))
				}
				
			}.foregroundColor(accent)
			
//			Rectangle()
//				.frame(maxHeight: 2)
//				.foregroundColor(accent)
			
			ZStack {
				
				Rectangle()
					.foregroundColor(accent.opacity(0.2))
					.cornerRadius(10)
				
			
				VStack {
					self.content
						.padding(.vertical, 2)
				}
				.padding(.horizontal, 8)
				.padding(.vertical, 12)
				
			}.padding(.horizontal, -8)
				
				
	
			
		}.padding(.top, 16)
		
	}
	
}

struct GroupTitle: View {
	
	let text: String
	let accent: Color
	
//	init(text: String) {
//		self.text = text
//	}
	
	var body: some View {
		
		Text(text.uppercased())
			.font(.system(size: 14, weight: .bold))
			.kerning(1.5)
			.foregroundColor(accent)
		
	}
	
}

struct HistoryItem: View {
	
	let name: String
	let value: String
	
	init(name: String, value: String) {
		
		self.name = name
		self.value = value
		
	}
	
	var body: some View {
		
		VStack {
			HStack {
				
				Text(name)
				
				Spacer()
				
				Text(value)
				
			}
		}
		
	}
	
}

struct ScanHistory_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
