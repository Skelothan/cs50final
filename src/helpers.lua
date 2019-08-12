function distance(x1, x2, y1, y2)
	return math.abs(math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2)))
end

function rand_choice(tbl)
	return tbl[math.random(#tbl)]
end