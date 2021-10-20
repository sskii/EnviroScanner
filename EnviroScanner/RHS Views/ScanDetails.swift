//
//  ScanDetails.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct ScanPreview: View {
	
	@State var cartCount: Int = 1
	
	var body: some View {
		
		VStack(alignment: .leading) {
			
			HStack {
				Title(text: "Watties Spaghetti")
				Spacer()
				StarRating(score: 3)
			}
			
			HStack {
				
				Image(systemName: "barcode")
					.renderingMode(.original)
				
				Text("987654321")
				
			}//.foregroundColor(Color("darkGreen"))
			
			QuantityPrompt(count: $cartCount, rating: "average")
				
		}
	}
	
}

struct ScanDetails: View {
	
	@State var signalErrMsg: String = "Improve this data"
	
	var body: some View {
		
		StandardSection() {
			
			Text("About this product")
				.padding(.top, 16)
				.font(.headline)
			
			Text("This item recieved a rating of average based on the following data maintained by the community.")
			
			DatabaseRow(key: "Packaging type", value: "Tin-plated steel can")
			DatabaseRow(key: "Packaging size", value: "Standard for 400g can")
			
			Button {
				
				signalErrMsg = "Feature doesn't exist yet :("
				
			} label: {
				
				Text(signalErrMsg)
					.foregroundColor(Color("themeMed"))
				
			}
			
		}
		
		StandardSection {
			
			Text("Product purchase history")
				.padding(.top, 16)
				.font(.headline)
			
			Text("This is the first time you've bought this.")
		
		}
		
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
			
			//ResetableCouterText(count: $count, text: "\(count) \(rating.lowercased())-rated \(count > 1 ? "items" : "item")")
			
			
				ResetableCouterText(count: $count, text: "I'm buying \(count)")
			
			
		} else {
			
			
				ResetableCouterText(count: $count, text: "I've put it back")
			
			
		}
	}
	
}

struct ResetableCouterText: View {
	
	@Binding var count: Int
	@State var enterQty: Bool = false
	@State var entryString: String = ""
	var text: String
	var resetValue: Int = 1
	
	var body: some View {
		
		HStack {
			
			if(enterQty) {
				
				
				TextField("Enter a quantity", text: $entryString)
					.frame(alignment: .leading)
					.keyboardType(.decimalPad)
				
				Spacer()
				
				Button {
					
					count = Int(entryString) ?? count
					enterQty = false
					
				} label: {
					Text("Update")
				}

			} else {
				
				Stepper(value: $count, in: 0 ... 100) {
					
					Button {
						
						if(count != resetValue)
						{
							
							count = resetValue
							
						} else {
							
							entryString = ""
							enterQty = true
							
						}
						
					} label: {
						
						if(!enterQty) {
							
							Text(text)
								.foregroundColor(.black)
							
						}
						
					}
					
				}
				
			}
			
		}.frame(minHeight: 32)
		
	}
	
}

struct ScanDetails_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			ScanPreview()
			ScanDetails()
		}
		
    }
}
