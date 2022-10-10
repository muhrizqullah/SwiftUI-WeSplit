//
//  ContentView.swift
//  WeSplit
//
//  Created by Muhammad Rizqullah Akbar on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalAmount: Double {
        let tipSelected = Double(tipPercentage)
        let tipValue = checkAmount * tipSelected / 100
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        
        return amountPerPerson
    }
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency{
        return FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "IDR")
    }

    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amont", value: $checkAmount, format: currencyFormat)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2..<99) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("WANT LEAVE A TIP?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("AMOUNT PER PERSON")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "IDR"))
                } header: {
                    Text("GRAND TOTAL")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
