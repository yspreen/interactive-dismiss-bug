//
//  ContentView.swift
//  interactive-dismiss-bug
//
//  Created by Nick on 8/16/23.
//

import SwiftUI

extension Int: Identifiable { public var id: Int { self } }

struct ContentView: View {
	enum Variant: String, CaseIterable {
		case A, B
	}

	@State var variant = Variant.allCases[0]

	var body: some View {
		content
			.overlay(alignment: .top) {
				Picker("Variant", selection: $variant) {
					ForEach(Variant.allCases, id: \.self) {
						Text("Variant \($0.rawValue)")
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.padding()
				.background(.white)
			}
			.preferredColorScheme(.light)
	}

	@ViewBuilder
	var content: some View {
		switch variant {
		case .A:
			VariantA()
		case .B:
			VariantB()
		}
	}
}

struct VariantA: View {
	@State var text = ""

	var body: some View {
		VStack(spacing: 0) {
			ScrollView {
				LazyVStack {
					ForEach(Array(1...100)) {
						Text("\($0)")
					}
				}
			}
			.scrollDismissesKeyboard(.interactively)
			TextField("Input", text: $text)
				.padding()
				.background {
					Color.init(white: 0.9).ignoresSafeArea()
				}
		}
	}
}

struct VariantB: View {
	@State var text = ""

	var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(Array(1...100)) {
					Text("\($0)")
				}
			}
		}
		.scrollDismissesKeyboard(.interactively)
		.safeAreaInset(edge: .bottom) {
			TextField("Input", text: $text)
				.padding()
				.background {
					Color.init(white: 0.9).ignoresSafeArea()
				}
		}
	}
}
