import UIKit
func fibonacci (limit: Int)
{
var first = -1 , second=1
var sum=0
for _ in 0...limit
  {
    sum=first+second
    first=second
    second=sum
    print(sum)
  }
}
fibonacci (limit:10)

