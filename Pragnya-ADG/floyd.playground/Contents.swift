import UIKit
func floyd (rows: Int)
{
    var rows=5
var n=1
for i in 1...rows
{
    for j in 1...i
    {
        print(n, terminator:" ")
        n += 1
    }
    print()
}
}
floyd (rows:5)
