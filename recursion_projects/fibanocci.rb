def fib(n)
	if n == 0
		return [0]
	elsif n == 1
		return [1]
	end
	fib_arr = [0, 1]

	while fib_arr.length <= n
		next_val = fib_arr[fib_arr.length - 1] + fib_arr[fib_arr.length - 2]
		fib_arr << next_val
	end
	return fib_arr
end


def fib_rec(n)
	return [0] if n == 0
	return [0, 1] if n == 1

	a = fib_rec(n - 1) 
	a << a[-1] + a[-2]
end

p fib(8)
p fib_rec(8)