println("Enter first number: ")
a = parse(Float64, readline())

println("Enter operator (+, -, *, /): ")
op = readline()

println("Enter second number: ")
b = parse(Float64, readline())

if op == "+"
    println("Result: ", a + b)
elseif op == "-"
    println("Result: ", a - b)
elseif op == "*"
    println("Result: ", a * b)
elseif op == "/"
    if b == 0
        println("Error: division by zero")
    else
        println("Result: ", a / b)
    end
else
    println("Unknown operator")
end