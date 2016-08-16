function near(a, b, c)
	-- checa se 2 numeros ('a' e 'b') estao proximos, mas dentro do limite 'c'
	if a > b then
		local aux = a
		a = b
		b = aux
	end
	
	return b - c <= a and a + c >= b
end