//
//  ScanHistory.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct HistorySummary: View {
	
	@State var expandedHistory: Bool = false
	@State var period: Int = 3		// current history period (to be graphed etc)
	
	var body: some View {
		
		StandardSection {
			
			HStack {
				
				Text("Recent activity periods")
					.font(.headline)
				
				Spacer()
				
				Button {
					expandedHistory.toggle()
				} label: {
					Text("review history")
				} .sheet(isPresented: $expandedHistory) {
					
					DetailedHistory()
					
				}
			}
			
			HistoryEntry(period: 0, score: 2, current: $period)
			HistoryEntry(period: 1, score: 3, current: $period)
			HistoryEntry(period: 2, score: 2, current: $period)
			HistoryEntry(period: 3, score: 1, current: $period)
			HistoryEntry(period: 4, score: 1, current: $period)
			
//			Text("That's all we've got.")
//				.padding(.top, 16)
			
		}
		
	}
	
}

struct HistoryEntry/*<Content: View>*/: View {
	
	//let content: Content
	let period: Int
	let score: Int
	@Binding var current: Int
	
	let accents: [Color] = [
		Color.primary,
		Color("poorMed"),		// score 1
		Color("averageMed"),	// score 2
		Color("themeMed")		// score 3
	]
	
	let periodNames: [String] = [
		"Today",
		"Yesterday",
		"Last week",
		"This last month",
		"This last year"
	]
	
	/*init(heading: String, score: Int, accent: Color, @ViewBuilder content: () -> Content) {
		self.heading = heading
		self.score = score
		self.accent = accent
		self.content = content()
	}*/
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 4) {
		
			HStack(spacing: 0) {
				
				StarRating(score: score)
				Spacer().frame(maxWidth: 16)
				
				Text(periodNames[period])
					.font(.system(size: 16, weight: .bold))
					.foregroundColor(accents[score])
				
				Spacer()
				
				if(period == current) { Image(systemName: "eyes") }
				
			}.foregroundColor(accents[score])
				
			
		}.padding(.horizontal, 16)
		.padding(.vertical, period == current ? 16 : 4)
		.background(period == current ? accents[score].opacity(0.2) : .clear)
		.cornerRadius(10)
		.onTapGesture {
			// switch the current period to be the one represented by this ticker
			current = period
		}.animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.15))
		
	}
	
}

struct DetailedHistory: View {
	
	@State var selectionUUID: UUID? = nil
	
	var body: some View {
		
		NavigationView {
			
			VStack {
				
				List {
					
					Section(header: Text("This afternoon")) {
						
						DetailedHistoryEntry(name: "Sanitarium Weet-Bix", rating: 2, selectionUUID: $selectionUUID)
						DetailedHistoryEntry(name: "Pic's Peanut Butter", qty: 2, rating: 3, selectionUUID: $selectionUUID)
						DetailedHistoryEntry(name: "Nestle Nutella", rating: 1, selectionUUID: $selectionUUID)
						DetailedHistoryEntry(name: "Bluebird Ready Salted", rating: 1, selectionUUID: $selectionUUID)
						
					}
					
					Section(header: Text("This morning")) {
						
						DetailedHistoryEntry(name: "Number 8 Hammer", rating: 2, selectionUUID: $selectionUUID)
						
					}
					
					Section(header: Text("Yesterday")) {
						
						DetailedHistoryEntry(name: "Impact 1B8 Recycled", rating: 3, selectionUUID: $selectionUUID)
						DetailedHistoryEntry(name: "WS Toner", rating: 2, selectionUUID: $selectionUUID)
						
					}
					
				}.navigationTitle("Your history")
				
			}
			
		}
		
	}
	
}

struct DetailedHistoryEntry: View {
	
	let name: String
	@State var qty: Int = 1
	let rating: Int
	
	@Binding var selectionUUID: UUID?
	let myUUID: UUID? = UUID()
	
	var body: some View {
		
		VStack(alignment: .leading) {
			
			HStack(spacing: 4) {
				Text(name)
				Spacer()
				if(myUUID != selectionUUID) {
					if(qty > 1) {
						Text(String(qty))
						Image(systemName: "multiply")
							.font(.system(size: 12))
					}
				}
				StarRating(score: rating)
			}
			.font(myUUID == selectionUUID ? .system(size: 24, weight: .bold) : .body)
			.foregroundColor(myUUID == selectionUUID ? History.accents[rating] : .primary)
			.contentShape(Rectangle())
			.onTapGesture {
				selectionUUID = selectionUUID == myUUID ? nil : myUUID
			}
			
			if(myUUID == selectionUUID) {
				Text("Added by barcode: 987654321")
				
				Spacer().frame(maxHeight: 16)
				
				QuantityPrompt(count: $qty)
				ScanDetails()
				
				Spacer().frame(maxHeight: 16)
			}
			
		}.listRowBackground(myUUID == selectionUUID ? History.accents[rating].opacity(0.1) : .white)
		
	}
	
}

struct History {
	
	static let accents: [Color] = [
		Color.primary,
		Color("poorMed"),		// score 1
		Color("averageMed"),	// score 2
		Color("themeMed")		// score 3
	]
	
	static let periodNames: [String] = [
		"Today",
		"Yesterday",
		"Last week",
		"This last month",
		"This last year"
	]
	
}

struct ScanHistory2_Previews: PreviewProvider {
    static var previews: some View {
        HistorySummary()
    }
}
