//
//  UnrecognisedScans.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct UnrecognisedScansPrompt: View {
	
	@State var isReviewPresented: Bool = false
	@Binding var count: Int
	
	var body: some View {
		
		Button(action: {
			self.isReviewPresented.toggle()
		}) {
			StandardSection {
				
				HStack {
				
					Image(systemName: "questionmark.circle")
						.font(.system(size: 24, weight: .light))
						.padding()
					
					VStack(alignment: .leading, spacing: 4) {
						
						Text("You have \(count) unrecognised scans")
							.font(.headline)
						
						Text("Tap here to review these scans and enter the items manually.")
					
					}
					
				}
				
			}.padding()
			.background(Color("themeLight"))
			.foregroundColor(.primary)
			
		}.sheet(isPresented: $isReviewPresented, onDismiss: {count = 0}) {
			
			UnrecognisedScansReview(isShown: $isReviewPresented)
			
		}
			
		
	}
	
}

struct UnrecognisedScansReview: View {
	
	@Binding var isShown: Bool
	
	var body: some View {
		
		StandardSection {
			
			Button(action: {
				
				self.isShown.toggle()
				
			}) {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(.secondary)
					.font(.system(size: 32, weight: .light))
					.padding()
			}.frame(maxWidth: .infinity, alignment: .leading)
			
			Spacer()
			
			Text("Thanks for finding me.\n\nUnfortunately, this feature isn't yet available in the prototype version :(\n\nLet's just say that the devs will sort out your \"unrecognised scans\" for you.\n\nJust swipe back down to dismiss this sheet.")
				.padding()
			
			Spacer()
			
		}
		
	}
	
}
