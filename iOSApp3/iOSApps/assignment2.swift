let students: [(name: String, grade: Float)] = [
    (name: "Amy", grade: 92.0),
    (name: "Brandon", grade: 76.5),
    (name: "Charlie", grade: 84.0),
    (name: "David", grade: 68.0),
    (name: "Elizabeth", grade: 95.0)
]

func gradeSummary(_ data: [(name: String, grade: Float)]) -> (min: Float, max: Float, average: Float) {
    var minGrade = data[0].grade
    var maxGrade = data[0].grade
    var total: Float = 0.0
    
    for item in data {
        if item.grade < minGrade { minGrade = item.grade }
        if item.grade > maxGrade { maxGrade = item.grade }
        total += item.grade
    }
    
    return (min: minGrade, max: maxGrade, average: total / Float(data.count))
}

func filterStudents(_ data: [(name: String, grade: Float)], using condition: ((name: String, grade: Float)) -> Bool) -> [(name: String, grade: Float)] {
    return data.filter(condition)
}

let summary = gradeSummary(students)
let filtered = filterStudents(students) { $0.grade > 70 }

print("Summary:")
print("  Min: \(summary.min)")
print("  Max: \(summary.max)")
print("  Average: \(summary.average)")

print("Filtered students (grade > 70):")
for s in filtered {
    print("  \(s.name): \(s.grade)")
}