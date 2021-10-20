//
//  RHSViews.swift
//  EnviroScanner
//
//  Views from the RHS of the Miro board
//  Sam's job
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

// the review scene body
struct ReviewSceneBody: View {
	
	@State var preferredVisualisation: Int = 1;
	@State var numUnlinkedScans: Int = 2;
	
	var body: some View {
		
		VStack(spacing: 16) {
			
			VisualisationContainer(currentVisualisation: $preferredVisualisation)
			
			// prompt to link scans, if there are any outstanding unliked scans
			if(numUnlinkedScans > 0) {
				UnrecognisedScansPrompt(count: $numUnlinkedScans)
			}
			
			SmallTip(title: "Sponsored tip", message: "Beach Road Milk is 10 mins away by bike and offers milk in reusable glass bottles. Tap to learn more.", cta: "+ 2 points")
			
			HistoryView()
		
		}.padding(16)
		
	}
	
}

struct RHSViews: View {
    var body: some View {
		VStack {
			
			VStack{
				
				ScanPreview()
					.padding(16)
			
				ScanDetails()
					.padding(16)
				
			}
			.background(Color("lightGreen"))
		
			SmallTip(title: "Today's tip",
					 message: "Consider bringing a 2L plastic container to this afternoon’s Countdown shop to grab your oats from the bulk bin.",
					 cta: "+ 1 point increase to good products")
				.padding(16)
			
		}
    }
}

struct SmallTip: View {
	
	var title: String = ""
	var message: String = ""
	var cta: String = ""
	
	var body: some View {
		
		StandardSection {
			
			if(title != "") {
				
				Text(title)
					.font(.headline)
				
			}
				
			if(message != "") {
				
				Text(message)
					.padding(.vertical, 2)
				
			}
			
			if(cta != "") {
				
				Text(cta)
					//.foregroundColor(Color("lightGreen"))
					.frame(maxWidth: .infinity, alignment: .trailing)
				
			}
			
		}
		
	}
	
}

struct ScanPreview: View {
	
	@State var cartCount: Int = 1
	
	var body: some View {
		
		VStack(alignment: .leading) {
			
			Title(text: "Watties Spaghetti")
				.frame(maxWidth: .infinity,
					   alignment: .leading)
			
			HStack {
				
				Image(systemName: "barcode")
					.renderingMode(.original)
				
				Text("987654321")
				
			}//.foregroundColor(Color("darkGreen"))
			
			Stepper(value: $cartCount, in: 0 ... 100) {
				
				QuantityPrompt(count: $cartCount, rating: "average")
				
			}
		
		}
	}
	
}

struct ScanDetails: View {
	
	@State var signalErrMsg: String = "Signal an error"
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 12) {
			
			Text("This item recieved a rating of average based on the following data maintained by the community.")
			
			DatabaseRow(key: "Packaging type", value: "Tin-plated steel can")
			DatabaseRow(key: "Packaging size", value: "Standard for 400g can")
			
			Button {
				
				signalErrMsg = "Feature doesn't exist yet :("
				
			} label: {
				
				Text(signalErrMsg)
					.foregroundColor(Color("mediumGreen"))
				
			}
			
			Text("Item purchase history")
				.padding(.top, 16)
				.font(.headline)
			
			Text("This is the first time you've bought this.")
		
		}.frame(maxWidth: .infinity, alignment: .leading)
		
	}
	
}

struct DatabaseRow: View {
	
	var key: String
	var value: String = "true"
	
	var body: some View {
		
		HStack {
			Text(key)
			Text(value)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}.padding(.horizontal, 16)
		
	}
	
}

struct QuantityPrompt: View {
	
	@Binding var count: Int
	var rating: String
	
	var message: String = ""
	
	var body: some View {
		
		// create the message
		if(count > 0) {
			
			ResetableCouterText(count: $count, text: "\(count) \(rating.lowercased())-rated \(count > 1 ? "items" : "item")")
			
		} else {
			
			ResetableCouterText(count: $count, text: "\(rating.capitalized)-rated item removed")
			
		}
	}
	
}

struct ResetableCouterText: View {
	
	@Binding var count: Int
	var text: String
	var resetValue: Int = 1
	
	var body: some View {
		
		Button {
			
			count = resetValue;
			
		} label: {
			
			Text(text)
				.foregroundColor(.black)
			
		}
		
	}
	
}

struct VisualisationContainer: View {
	
	@Binding var currentVisualisation: Int

	var body: some View {
		PagerView(pageCount: 3, currentIndex: $currentVisualisation) {
			ZStack {
				Color.red
				Text("Area for visualisation 1")
			}
			ZStack {
				Color.green
				Text("Visualisation 2")
			}
			ZStack {
				Color.blue
				Text("Visualisation 3")
			}
		}
		.foregroundColor(.white)
		.frame(height: 300)
	}
	
}

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
		
		VStack {
			
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

struct HistoryView: View {
	
	var body: some View {
		
		StandardSection {
			Text("History view goes here")
				.font(.headline)
		}
		
	}
	
}

struct StandardSection<Content: View>: View {
	
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		
		self.content = content()
		
	}
	
	var body: some View {
			
		VStack(alignment: .leading) {
			self.content
		}
		.multilineTextAlignment(.leading)
		.frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
		
	}
	
}

struct RHSViews_Previews: PreviewProvider {
    static var previews: some View {
        ReviewSceneBody()
    }
}
