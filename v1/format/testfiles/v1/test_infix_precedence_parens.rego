package format_test_infix_precedence

# issue repro 1: equal-precedence chains keep right-hand grouping
a := {"verdict": "vetoed"}
b := ["POST"]

body if {
	(a.verdict == "permitted") == (b[0] == "GET")
}

# issue repro 2: `in` binds looser than `==`, so the left operand needs parens
profile := "bb-block"

head := (profile in {"default", "bb-public"}) == false

# looser left operand: `in` under a relation, parens required
c if {
	(input.x in input.set) == input.y
}

# equal precedence on the right: parens required to keep grouping
d := input.a == (input.b == input.c)

# equal precedence on the left: redundant parens are dropped, grouping unchanged
e := (input.a == input.b) == input.c

# redundant parens dropped: left-associative chains stay flat
f := (input.a + input.b) + input.c

# parens kept: right operand of equal precedence
g := input.a - (input.b - input.c)

# parens kept: left operand binding looser than the parent
h := (input.a + input.b) * input.c

# `=` takes a full term on the right: no parens needed under it
i := input.a == input.b

j := input.a in input.set

# `in` on both sides: right-hand `in` keeps its parens
k if {
	input.x in (input.y in input.z)
}

# assignment form with an infix chain: parens where precedence demands them
l := (input.a + input.b) - (input.c * input.d)
