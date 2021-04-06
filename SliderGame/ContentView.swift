//
//  ContentView.swift
//  SliderGame
//
//  Created by Nikita Benin on 06.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentValue: Double = 50
    @State private var targetValue: Int = 0
    @State private var computedScore: Int = 0
    @State private var showAlert = false
    @State private var color = UIColor.red
    
    var body: some View {
        VStack(spacing: 20){
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
                .font(.callout)
            HStack {
                Text("0")
                ColorUISlider(value: $currentValue, color: color)
                    .onChange(of: currentValue, perform: { value in
                        updateColor()
                    })
                Text("100")
            }
            Button("Проверь меня!", action: checkScore)
            Button("Начать заново", action: restart)
        }
        .padding()
        .onAppear(perform: {
            restart()
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Your score"), message: Text("\(computedScore)"))
        })
    }
}

extension ContentView {
    private func restart() {
        targetValue = Int.random(in: 0...100)
        updateColor()
    }
    
    private func updateColor() {
        let alpha: CGFloat = CGFloat(computeScore()) / 100
        color = UIColor(red: 1, green: 0, blue: 0, alpha: alpha)
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func checkScore() {
        computedScore = computeScore()
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
