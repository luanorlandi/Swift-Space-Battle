function near(a, b, c)
	-- check if 2 numbers ('a' and 'b') are close, between the limit 'c'
	if a > b then
		local aux = a
		a = b
		b = aux
	end
	
	return b - c <= a and a + c >= b
end