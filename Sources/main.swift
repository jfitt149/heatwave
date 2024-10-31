import Foundation

struct HeatwaveStreak {
    let startDate: Date
    let endDate: Date
    let length: Int
}

func analyzeHeatwaves(dailyTemperatures: [(date: Date, temperature: Double)], threshold: Double) -> (longestStreak: HeatwaveStreak?, averageHeatwaveLength: Double, heatwaves: [HeatwaveStreak]) {
    var currentStreak: [Date] = []
    var heatwaves: [HeatwaveStreak] = []
    
    for entry in dailyTemperatures {
        if entry.temperature > threshold {
            currentStreak.append(entry.date)
        } else if !currentStreak.isEmpty {
            heatwaves.append(HeatwaveStreak(startDate: currentStreak.first!, endDate: currentStreak.last!, length: currentStreak.count))
            currentStreak.removeAll()
        }
    }

    // Capture any ongoing streak if the array ends with a heatwave
    if !currentStreak.isEmpty {
        heatwaves.append(HeatwaveStreak(startDate: currentStreak.first!, endDate: currentStreak.last!, length: currentStreak.count))
    }
    
    let longestStreak = heatwaves.max(by: { $0.length < $1.length })
    let averageHeatwaveLength = heatwaves.isEmpty ? 0.0 : Double(heatwaves.map { $0.length }.reduce(0, +)) / Double(heatwaves.count)
    
    return (longestStreak, averageHeatwaveLength, heatwaves)
}
