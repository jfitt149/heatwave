import XCTest

class HeatwaveAnalyzerTests: XCTestCase {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func date(_ dateStr: String) -> Date {
        return dateFormatter.date(from: dateStr)!
    }
    
    func testMultipleHeatwaves() {
        let dailyTemperatures = [
            (date: date("2024-07-01"), temperature: 32.0),
            (date: date("2024-07-02"), temperature: 35.0),
            (date: date("2024-07-03"), temperature: 30.0),
            (date: date("2024-07-04"), temperature: 36.0),
            (date: date("2024-07-05"), temperature: 37.0),
            (date: date("2024-07-06"), temperature: 30.0),
            (date: date("2024-07-07"), temperature: 38.0),
            (date: date("2024-07-08"), temperature: 39.0)
        ]
        
        let result = analyzeHeatwaves(dailyTemperatures: dailyTemperatures, threshold: 31.0)
        
        XCTAssertEqual(result.longestStreak?.length, 2)
        XCTAssertEqual(result.longestStreak?.startDate, date("2024-07-04"))
        XCTAssertEqual(result.longestStreak?.endDate, date("2024-07-05"))
        XCTAssertEqual(result.averageHeatwaveLength, 2.0)
    }
    
    func testNoHeatwave() {
        let dailyTemperatures = [
            (date: date("2024-07-01"), temperature: 25.0),
            (date: date("2024-07-02"), temperature: 27.0)
        ]
        
        let result = analyzeHeatwaves(dailyTemperatures: dailyTemperatures, threshold: 31.0)
        
        XCTAssertNil(result.longestStreak)
        XCTAssertEqual(result.averageHeatwaveLength, 0.0)
        XCTAssertTrue(result.heatwaves.isEmpty)
    }
    
    func testSingleHeatwave() {
        let dailyTemperatures = [
            (date: date("2024-07-01"), temperature: 33.0),
            (date: date("2024-07-02"), temperature: 34.0),
            (date: date("2024-07-03"), temperature: 32.0),
            (date: date("2024-07-04"), temperature: 30.0)
        ]
        
        let result = analyzeHeatwaves(dailyTemperatures: dailyTemperatures, threshold: 31.0)
        
        XCTAssertEqual(result.longestStreak?.length, 3)
        XCTAssertEqual(result.longestStreak?.startDate, date("2024-07-01"))
        XCTAssertEqual(result.longestStreak?.endDate, date("2024-07-03"))
        XCTAssertEqual(result.averageHeatwaveLength, 3.0)
        XCTAssertEqual(result.heatwaves.count, 1)
    }
    
    func testEdgeCaseEmptyArray() {
        let dailyTemperatures: [(date: Date, temperature: Double)] = []
        
        let result = analyzeHeatwaves(dailyTemperatures: dailyTemperatures, threshold: 31.0)
        
        XCTAssertNil(result.longestStreak)
        XCTAssertEqual(result.averageHeatwaveLength, 0.0)
        XCTAssertTrue(result.heatwaves.isEmpty)
    }
}

// Running tests
HeatwaveAnalyzerTests.defaultTestSuite.run()
