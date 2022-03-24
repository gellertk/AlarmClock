

var n: UInt16 = 65529

var reverse: Int = 0

while (n != 0) {
    reverse = reverse * 10
    reverse = reverse + Int(n) % 10
    n = n / 10
}

n = UInt16(reverse)
