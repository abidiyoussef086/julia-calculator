using Plots
using Symbolics
using QuadGK

# -------------------------
# Helper: safely evaluate f(x)
# -------------------------
function build_function(expr)
    return x -> eval(:(let x=$x; $expr end))
end

# -------------------------
# NUMBER CALCULATOR
# -------------------------
function number_mode()
    println("Enter first number:")
    a = parse(Float64, readline())

    println("Enter operator (+, -, *, /):")
    op = readline()

    println("Enter second number:")
    b = parse(Float64, readline())

    if op == "+"
        println("Result: ", a + b)
    elseif op == "-"
        println("Result: ", a - b)
    elseif op == "*"
        println("Result: ", a * b)
    elseif op == "/"
        println(b == 0 ? "Error: division by zero" : "Result: $(a / b)")
    else
        println("Unknown operator")
    end
end

# -------------------------
# FUNCTION EVALUATION
# -------------------------
function function_mode()
    println("Enter f(x):")
    expr = Meta.parse(readline())

    println("Enter x value:")
    xval = parse(Float64, readline())

    f = build_function(expr)
    println("Result: ", f(xval))
end

# -------------------------
# DERIVATIVE (symbolic)
# -------------------------
function derivative_mode()
    @variables x

    println("Enter f(x):")
    expr = Meta.parse(readline())

    f = eval(expr)
    df = Differential(x)(f)

    println("Derivative: ", df)
end

# -------------------------
# INTEGRAL (numerical)
# -------------------------
function integral_mode()
    println("Enter f(x):")
    expr = Meta.parse(readline())

    f = build_function(expr)

    println("Lower bound:")
    a = parse(Float64, readline())

    println("Upper bound:")
    b = parse(Float64, readline())

    result, _ = quadgk(f, a, b)
    println("Integral result: ", result)
end

# -------------------------
# GRAPHING
# -------------------------
function graph_mode()
    println("Enter f(x):")
    expr = Meta.parse(readline())

    f = build_function(expr)

    println("xmin:")
    xmin = parse(Float64, readline())

    println("xmax:")
    xmax = parse(Float64, readline())

    x_vals = xmin:0.1:xmax
    y_vals = [f(x) for x in x_vals]

    plot(x_vals, y_vals,
        label="f(x)",
        linewidth=2,
        title="Graph of f(x)",
        xlabel="x",
        ylabel="f(x)")
end

# -------------------------
# MAIN MENU
# -------------------------
function main()
    println("\n=== SUPER CALCULATOR ===")
    println("Choose mode:")
    println("1 → number")
    println("2 → function")
    println("3 → derivative")
    println("4 → integral")
    println("5 → graph")

    mode = readline()

    if mode == "1"
        number_mode()
    elseif mode == "2"
        function_mode()
    elseif mode == "3"
        derivative_mode()
    elseif mode == "4"
        integral_mode()
    elseif mode == "5"
        graph_mode()
    else
        println("Invalid option")
    end
end

main()
