
func swapMe<T>(a: inout T, b: inout T) {
    (a, b) = (b, a)
}
