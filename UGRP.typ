#import "@preview/unequivocal-ams:0.1.1": ams-article, theorem, proof
#import "@preview/cetz:0.2.2": canvas,draw,tree,decorations
#set text(
  font:"Times New Roman",
  size: 12pt
)
#set par(
  justify: false,
  leading: 2.0em
)
#show: ams-article.with(
  bibliography: bibliography("refs.bib"), 
)
#set math.equation(numbering: "(1)")
#align(center)[
  *Abstract*\
]

#let jinguo(txt) = {
  text(blue)[JG: #txt]
}
//basic shapes
#let blackbox((x,y),r,name) = draw.rect(
  (x,y),
  (rel:(r,r)),
  fill: black,
  name:name,
)
#let horizontal-line(x1,x2,y,size) = draw.line((x1 - size*0.5,y + size*.7),(x2 + size*1.5,y + size*.7),stroke:3pt)
#let horizontal-carry-line(x1,x2,y,size,name) = draw.line((x1 - size*0.5,y + size*.3),(x2 + size*1.5,y + size*.3),name:name,stroke:1pt)
#let vertical-line(y1,y2,x,size) = draw.line((x + size*0.5,y1 - size*0.5),(x + size*0.5,y2 + size*1.5),stroke:3pt)
#let diaonal-sum-line(x1,y1,x2,y2,size,name) = draw.line((x1 - size*0.5,y1 + size*1.5),(x2 + size*1.5,y2 - size*0.5),name:name,stroke:1pt)
#let carry-bezier(x,y1,y2,size) = draw.bezier-through((x - size*0.5,y1 + size*.3),(x - size *1,y1),(x - size*0.5,y2 + size*1.5),stroke:1pt)
#let p-input(x,y,text,size) = draw.content((x + size*0.5,y + size*1.7),text,anchor:"south")
#let q-input(x,y,text,size) = draw.content((x + size*1.6,y + size*.8),text,anchor:"west")
#let diagonal-io(x,y,text,size,type)= if type == "i" {
  draw.content((x - size*0.5,y + size*1.5),text,anchor:"south-east")
  } else if type == "o"{
  draw.content((x + size*1.5,y - size*0.5),text,anchor:"north-west")
  }
#let horizontal-io(x,y,text,size,type)= if type == "i" {
  draw.content(((x + size*1.6,y + size*.3)),text,anchor:"west")
  } else if type == "o"{
  draw.content((x - size*0.6,y + size*.3),text,anchor:"east")
  }
#let andgate(x,y,size,name) = {draw.rect(
  (x,y),//the start of output line
  (rel:(size,size)),
  radius: (south:100%),
  name:name,
  stroke: 1pt
)
draw.line((name:name,anchor:120deg),(x+ 0.2*size,y + 1.5*size),stroke:1pt)//input 1
draw.line((name:name,anchor:60deg),(x+ 0.8*size,y + 1.5*size),stroke:1pt)//input 2
draw.line((name:name,anchor:"south"),(x + 0.5*size,y - 0.5 * size),stroke:1pt) //output 
}
#let circontent(x,y,text,size,name) = {
  draw.circle((x,y),radius:size,name:name)
  draw.content((x,y),text)
}
#let recontent(x,y,text,size,name) = {
  draw.rect((x,y),(rel:(size,size)),name:name)
  draw.content((x + 0.5* size,y + 0.5* size),text)
}
#let pin(name, direction) = {
  if direction == "rt" {
    return (name: name, anchor: 20deg)
  } else if direction == "lt" {
    return (name: name, anchor: 160deg)
  } else if direction == "rb" {
    return (name: name, anchor: 340deg)
  } else if direction == "lb" {
    return (name: name, anchor: 200deg)
  } else if direction == "t" {
    return (name: name, anchor: 90deg)
  } else if direction == "tl" {
    return (name: name, anchor: 135deg)
  } else if direction == "b" {
    return (name: name, anchor: 270deg)
  } else if direction == "br" {
    return (name: name, anchor: 315deg)
  }
}
  
= Introduction: Encryption system and the factoring problem

Introduce Ising model that is used for optimization problem and conclude that it could lead to breakthroughs in analyze the vuneralbilities of RSA system since it's based on the hardness of factoring problem. Then conclude that reduce other problems into optimization problem is important since that we could then use ising machine to deal with that problem. So we develop a Julia package to help reduce problems of different types into your target problem

#jinguo([please add a main figure])

#jinguo([Introduction to hardware.])

#jinguo("Image: Ising machine. Cite one from the article. Cite in the caption.")

#jinguo([Closest lattice vector as a future step.
1. Schnorr, Claus Peter. "Fast factoring integers by SVP algorithms, corrected." Cryptology ePrint Archive (2021).
2. Micciancio, Daniele. "The hardness of the closest vector problem with preprocessing." IEEE Transactions on Information Theory 47.3 (2001): 1212-1215.
])

= Computational hardness and problem reductions



#jinguo("Add Diagram: P, NP problem, NP-complete problem, circles, problems and reductions")

#align(center)[
  #canvas({ 
    import draw: *
    circle((),radius:3,name:"NP",)
    content("NP.north-west","NP",anchor:"south-east")
    catmull((-1,0.4),(-2,1),(-1,2),(0,1),(0,0),(-1,0.4),name:"P")
    content((-1,1),"P")
    catmull((-1,-2),(-0.5,-2),(1.5,-1.7),(1,-1),(-1,-1),(-1,-2),name:"NP-complete")
    content((0.3,-1.5),"NP-complete")
    rect((0.6,0.4),(rel:(1.5,0.5)),name:"Factoring")
    content((1.35,0.65),"Factoring")
    line((name:"Factoring",anchor:"south"),(1,-1),mark:(end:"straight"))
    }
  )
]
#align(left)[
  Figure 1: P, NP, and NP-complete problems (citation). The circle represents the class of problems. The arrow represents the reduction from factoring to problems in the class of NP-complete. 

#jinguo([curves too ugly.])

#jinguo([Pleaes add problems in the package to the above diagram.])
]

= From factoring to Ising machine
== Factoring problem and array multiplier
Factoring, a problem of decomposing an $n$-bit composite integer $m=p q$ into its prime factors $p$ and $q$. To specify it, we use the binary representation for the integer $m= sum_(i=0)^(n-1) 2^i m_i $, with $m_i ∈ {0, 1}$, $p=sum_(i=0)^(k-1)2^i p_i$ for the $k$-bit integer, and $q=sum_(i=0)^(n-k-1)2^i q_i$ for the $(n-k)$-bit integer. The factoring problem thus amounts to finding the unknown bits $p_i$ and $q_i$ such that $ sum_(i=0)^(n-1)2^i m_i = sum_(i=0)^(k-1) sum_(j=0)^(n-k-1)2^(i+j)p_i q_j. $ Note that k is a priori unknown since we just want to consider this specific problem. However, one could consider this problem for any $k=1,2,...,n/2$ @nguyen2023quantum.

Array multiplier is used for multiplication of unsigned numbers with full adders and half adders connected as building blocks @asha2016performance. To clarify it, we consider a simple multiplication of 3-bits binary numbers

$ 5 times 7 = 35 arrow 111 times 101 = 100011, $
the graphical representation of its vertical calculation and array multiplier is shown in Figure 1.

#align(figure(scale(canvas(length: 1cm, {
  import draw: *
  import decorations: *
  /// vertical calculation
  content((0,1.5),[$1$])
  content((0.5,1.5),[$1$])
  content((1,1.5),[$1$])
  content((0.5,1),[$0$])
  content((1,1),[$1$])
  content((0,1),[$1$])
  content((-0.5,1),[$times$])
  line((-.8,0.7),(1.2,.7))
  content((0,0.5),[$1$])
  content((0.5,0.5),[$1$])
  content((1,0.5),[$1$])
  content((0.5,0),[$0$])
  content((0,0),[$0$])
  content((-0.5,0),[$0$])
  content((0,-0.5),[$1$])
  content((-0.5,-0.5),[$1$])
  content((-1,-0.5),[$1$])
  line((-1.7,-0.7),(1.2,-0.7))
  content((0,-1),[$0$])
  content((0.5,-1),[$1$])
  content((1,-1),[$1$])
  content((-0.5,-1),[$0$])
  content((-1,-1),[$0$])
  content((-1.5,-1),[$1$])
  //caption
  content((0,-1.5),"(a)vertical calculation")
  



  ///array multiplier
  set-origin((5.5,-6))
  blackbox((0,0),1,"a")
  blackbox((3,0),1,"b")
  blackbox((6,0),1,"c")
  blackbox((0,3),1,"d")
  blackbox((3,3),1,"e")
  blackbox((6,3),1,"f")
  blackbox((0,6),1,"g")
  blackbox((3,6),1,"h")
  blackbox((6,6),1,"i")
  // p and sum input
  horizontal-line(0,6,6,1)
  horizontal-line(0,6,3,1)
  horizontal-line(0,6,0,1)
  horizontal-line(0,6,0,1)
  horizontal-carry-line(0,6,6,1,"1C")
  horizontal-carry-line(0,6,3,1,"2C")
  horizontal-carry-line(0,6,0,1,"3C")
  // q input 
  vertical-line(0,6,0,1)
  vertical-line(0,6,3,1)
  vertical-line(0,6,6,1)
  //carry input
  diaonal-sum-line(0,6,6,0,1,"1S")
  diaonal-sum-line(3,6,6,3,1,"2S")
  diaonal-sum-line(0,3,3,0,1,"3S")
  diaonal-sum-line(0,0,0,0,1,"4S")
  diaonal-sum-line(6,6,6,6,1,"5S")
  carry-bezier(0,6,3,1)
  carry-bezier(0,3,0,1)
  //content
  p-input(6,6,$p_0$,1)
  p-input(3,6,$p_1$,1)
  p-input(0,6,$p_2$,1)
  q-input(6,6,$q_0$,1)
  q-input(6,3,$q_1$,1)
  q-input(6,0,$q_2$,1)
  diagonal-io(0,6,$0$,1,"i")
  diagonal-io(3,6,$0$,1,"i")
  diagonal-io(6,6,$0$,1,"i")
  diagonal-io(6,6,$m_0$,1,"o")
  diagonal-io(6,3,$m_1$,1,"o")
  diagonal-io(6,0,$m_2$,1,"o")
  diagonal-io(3,0,$m_3$,1,"o")
  diagonal-io(0,0,$m_4$,1,"o")
  horizontal-io(6,6,$0$,1,"i")
  horizontal-io(6,3,$0$,1,"i")
  horizontal-io(6,0,$0$,1,"i")
  horizontal-io(0,0,$m_5$,1,"o")
  content("1C.0%",$c_(2,0)$,anchor:"north")
  content("1C.30%",$c_(1,0)$,anchor:"north")
  content("1C.70%",$c_(0,0)$,anchor:"north")
  content("2C.1%",$c_(2,1)$,anchor:"north-east")
  content("2C.30%",$c_(1,1)$,anchor:"north")
  content("2C.70%",$c_(0,1)$,anchor:"north")
  content("3C.30%",$c_(1,2)$,anchor:"north")
  content("3C.70%",$c_(0,2)$,anchor:"north")
  content("1S.30%",$s_(2,0)$,anchor:"east")
  content("2S.50%",$s_(1,0)$,anchor:"east")
  content("1S.70%",$s_(1,1)$,anchor:"east")
  content("3S.50%",$s_(2,1)$,anchor:"east")
  content("3S.0%",$s_(3,0)$,anchor:"east")
  content("4S.3%",$s_(3,1)$,anchor:"east")
  //caption
  content((4,-1),"(b)array multiplier")

  ///blackbox
  set-origin((-8,-2))
  set-style(
    line: (stroke: (dash: "dashed")),
    rect: (fill: none,stroke:(dash: "dashed")),
  )
  rect((7.7,4.8),(9.3,6.2),name:"blackbox")
  rect((-.5,1),(rel:(5.9,5)),name:"design")
  line((name:"blackbox",anchor:135deg),(name:"design",anchor:45deg))
  line((name:"blackbox",anchor:227deg),(name:"design",anchor:315deg))
  
  andgate(3.5,4.3,0.7,"and1")
  content((3.5+0.2*0.7,4.3+1.8*0.7),$p_2$,anchor:"south")
  content((3.5+0.8*0.7,4.3+1.8*0.7),$q_1$,anchor:"south")
  content((3.5+0.5*0.7,4.3-0.5),$p_2 q_1$,anchor:"south")
  
  rect((1.5,2),(rel:(1.618*1.2,1.2)),name:"fulladder",stroke:1pt)
  content((1.5+0.48*1.618*1.2,2+1.2*0.4)," Full Adder",anchor:"south")

  line((3.4,4.3-0.5),(3,4.3-0.5),(name:"fulladder",anchor:61deg),stroke:1pt)
  line((1.4,4.5),(2.1,3.8),(name:"fulladder",anchor:110deg),stroke:1pt)
  line((4,2.6),"fulladder.east",stroke:1pt)
  line("fulladder.west",(1,2.6),stroke:1pt)
  line("fulladder.south",(2.47,1.5),stroke:1pt)
  
  content((1.4,4.6),"sum-in",anchor:"south-east")
  content((4.1,2.65),"carry-in", anchor: "west")
  content((1,2.65),"carry-out", anchor: "east")
  content((2.47,1.3),"sum-out")
  content((2.5,0.7),"(c)design of blackbox",anchor:"north")
  //blackbox((0,0),0.5,"a")
  //brace((1.2,-2),(1.2,2.5),name:"brace")
  //content((1.3,-1.6),"nihao",anchor:"west")
}), x: 60%, y:60%, reflow: true),
caption: [
  (a) Vertical calculation of 3-bits binary numbers. 
  (b) Array multiplier @nguyen2023quantum. Each horizontal layer represents one bit of multiplicand times every bit of multiplier to obtain the partial product. Note that the elements on one thick line are the same and they are not the outputs of blackbox.
  (c) Design of blackbox. A blackbox is constructed of an AND gate and a full adder. The four inputs of blackbox are respectively: one bit of mulpicand and one bit of multiplier, the carry-in and sum-in. Outputs are the carry-out and sum-out.
]


))

#linebreak()
#linebreak()
Observing the array multiplier and blackbox in Figure 2, it is obvious that each blackbox contains several constraints to its input. Here, for such a $n times n$ multiplier, we could define the constraint for each blackbox as:
$ s_(i,j) + 2c_(i,j) = p_i q_j + c_(i-1,j) + s_(i+1,j-1) $  <blackbox>

$ c_(-1,j) = s_(i,-1) = 0 $

for $i,j in {0,1,dots,n}$, let $c_(i j)$ and $s_(i j)$ represent the carry-out and sum-out, $p_i$ and $q_j$ denote the $i$th bit of the multiplicand and the $j$th bit of the multiplier, and $c_(i-1,j)$ and $s_(i,j-1)$ refer to carry-in and sum-in, where $i-1$ and $j-1$ simply indicates that each blackbox receives carry-out from the last blackbox in the same row, and sum-out from the  upper-left blackbox(which, in vertical calculation corresponds to the previous column) @nguyen2023quantum.
Using the array multiplier shown in Fig 2.(a), we could efficently reduce a factoring problem to a circuit satisfaction problem.

== Factoring $arrow$ Circuit Satisfaction

A boolean circuit is a directed graph with source nodes(inputs) and one or more sink nodes(output). The internal nodes, known as "gate", produce logical function of inputs. One could devide a circuit into a series of layers of gates and the gates from each layer receive inputs from the layer above them @moore2011nature. In fact, the constraints are extracted from the truth table of AND gate and full adder and it elegantly simulates the logical operations in array multiplier through a system of these equations. Given these constraint equations, one could reduce factoring problem to circuit sat problem by putting the constraints of factoring problem into corresponding layers in the circuit. 
== Circuit Satisfaction $arrow$ QUBO

Firstly, we give a formal definition of the Quadratic Unconstrained Binary Optimization (QUBO) model. Definition: The QUBO model is expressed by the optimization problem:
$ "QUBO: minimize/maximize" y=x^t Q x $ where x is a vector of binary decision variables and Q is a square matrix of constants.
For constrained optimization problems, quadratic penalties are introduced to simulate the constraints so that the constraints problems could be re-formulated into QUBO problems effectively @glover2022quantum. As an example, we consider the logical operations and their corresponding QUBO penalties in Table 1.

#align(center)[
  #table(
    columns: 2,
    table.header(
      [*Logical Operation*],[*QUBO Penalty*]
    ),
    [$z = not x$],[$2x z-x-z+1$],
    [$z = x_1 or x_2$],[$x_1 x_2 + (x_1 + x_2)(1-2z)+ z$], 
    [$z = x_1 and x_2$],[$x_1x_2-2(x_1+x_2)z+3z$],
    [$z = x_1 xor x_2$],[$2x_1x_2-2(x_1+x_2)z-4(x_1+x_2)a+4a z+x_1+x_2+z+4a$]
  )
  Table 1:  QUBO Penalties for Logical Operations @noauthor_reformulating_nodate
  $ z = not x arrow y = (x space z) mat(-1,1;
  1,-1;delim: "[") mat(x;
  z;delim: "[") $
  QUBO expression of $z= not x$
]
In Table 1, all the variables are intended to be binary value and note that in that case, we have $ x_i^2 = x_i $ and thereby we could transform the linear part into quadratic one @glover2022quantum. For each truth assignment of the variables, the penalty would be 0 if the logical operation is satisfied and be larger than 0 otherwise. By checking whether the penalty is 0, we could determine whether the logical operation is satisfied. Given this penalties gadgets, we process by considering a simple conjunction of two gedgets. Given a circuit sat example

#align(center)[#canvas(length: 1cm,{  
  import draw: *
  circontent(-.6,0,$x_1$,0.5,"x1")
  circontent(1.4,0,$x_2$,0.5,"x2")
  recontent(-1,-2,"AND",0.8,"and1")
  recontent(1,-2,"OR",0.8,"or1")
  recontent(0,-3.5,"AND",0.8,"and2")
  circontent(0.4,-4.4,$z$,0.5,"z")
  line("x1","and1",mark:(end:"straight"))
  line("x2","and1",mark:(end:"straight"))
  line("x1","or1",mark:(end:"straight"))
  line("x2","or1",mark:(end:"straight"))
  line("and1","and2",mark:(end:"straight"),name:"y1")
  line("or1","and2",mark:(end:"straight"),name:"y2")
  line("and2","z",mark:(end:"straight"))
  content("y2.mid",$y_2$,anchor:"north-west")
  content("y1.mid",$y_1$,anchor:"north-east")
  content((3,-2.5),"(a)")
})
]
In (a), there is a simple conjuction of an AND gate and an OR gate. The output of them, $y_1$ and $y_2$, is then connected to the AND gate in the next layer as inputs. The conjuction of the two gates in the first layer is given by:
$ z = y_1y_2 -2(y_1+y_2)z+3z $ <conjunction>
So by simply change the literals in the QUBO penalty, we could simulate the conjuction of two gadgets and therby the circuit sat problem. The whole reduction of (a), from circuit sat to QUBO, is givenm by:
$ y_1 = x_1x_2-2(x_1+x_2)y_1+3y_1 $   $ y_2 = x_1 x_2 + (x_1 + x_2)(1-2y_2)+ y_2 $  #align(center)[and @conjunction]

 

== QUBO $arrow$ Spin glass and Ising machine

The problem of spin glasses is of great interest both in solid state physics and in statistical physics. Magnetic alloys such as Au and Cu where 1% of magnetic impurities are embeed are studied in spin glass problem. In spin glss, there is an energy interaction between spins of the two impurities
$ H_12 = J_12 sigma_1 sigma_2 $
where $sigma_1$ and $sigma_2$ are the spins of the two impurities and $J_12$ is the interaction @barahona1982computational. For a configuration $sigma ={sigma_1,sigma_2,...,sigma_n} $ where $sigma_i = {+1,-1}$, the energy of the configuration is given by Hamiltonian

$ H = sum_(i,j) J_(i j) sigma_i sigma_j + sum_(i) h_i sigma_i. $ <spinglass-energy>
The parameters $J$ and $h$ correspond to the energies associated with spins' interactions with other spins and the external field, respectively. Note that in @spinglass-energy we set the sign to be positive to keep consistent with QUBO's penalty rules. For a ferromagnet, $J$ is positive and a configuration with most interacting spins having parallel moments ($sigma_i = sigma_j$) has lower energy.



= Code Implementation

== Julia programming language

Julia is a modern, open-source, high performance programming language for technical computing. It was born in 2012 in MIT. Though Julia is new, it has a large number of packages and a strong and fresh community(JuliaHub Inc). And the features of Julia, such as multiple dispatch, just-in-time compilation, and parallelism, makes Julia a good choice for scientific computing even if it's a dynamic programming language @bezanson2017julia. See Appendix @Julia for more details of Julia.
== ProblemReductions.jl

In this section, we will introduce how to use `ProblemReductions.jl`(See Appendix @ProblemReductions.jl). The main function of the package is problem reduction. It defines a set of computational hard problem(`models`) and provides feasible interface(`reduction_graph` and `reduceto`)  to reduce one to another. Here is an example of reduce a factoring problem to a spin glass problem through the package.

Consider factoring problem: $6 = p times q$, note that in the package, the parameters for factoring problem is `m`, `n` and `input` where `m` and `n` is the number of bits for the factors and `input` is the number to be factored. Open a Julia REPL and run the following code:
```julia
julia> using ProblemReductions  #import the package

julia> factoring = Factoring(2, 2, 6) # 3 bits factors and 6 as input
Factoring(2, 2, 6)
```
The outcome would be an instance of `Factoring` model. Then we use `reduction_graph` and `reduction_path` to find the path from factoring to spin glass problem.

```julia
julia> g = reduction_graph(); # get the reduction graph

julia> path = reduction_paths(Factoring, SpinGlass)
1-element Vector{Vector{Type}}:
 [Factoring, CircuitSAT, SpinGlass]

julia> reduction_result = implement_reduction_path(path[1], factoring);

julia> target = target_problem(reduction_result)
SpinGlass{HyperGraph, Vector{Int64}}(HyperGraph(90, [[1, 2], [1, 3], [2, 3], [1], [2], [3], [4], [3, 4], [3, 5], [3, 6]  …  [84, 88], [82, 88], [88], [83, 89], [63, 89], [89], [88, 89], [88, 90], [89, 90], [90]]), [1, -2, -2, 3, 3, 0, 0, 1, -1, -2  …  -2, -2, -3, -2, -2, -3, 1, -2, -2, 1])

julia> import GenericTensorNetworks  # solver

julia> gtn_problem = GenericTensorNetworks.SpinGlass(target.graph.n, target.graph.edges, target.weights)

julia> result = GenericTensorNetworks.solve(GenericTensorNetwork(gtn_problem), SingleConfigMin())[]
(-92.0, ConfigSampler{44, 1, 1}(10000000000000110101000001010010000011010000))ₜ

julia> extract_solution(reduction_result, 1 .- 2 .* Int.(read_config(result)))
4-element Vector{Int64}:
 1
 1
 0
 1
```
The result is $p = 3$ and $q = 2$ which is the correct factors of 6. The code above shows how to reduce a factoring problem to a spin glass problem and solve it using the `GenericTensorNetworks` package. The `GenericTensorNetworks` package is a solver for the Ising machine and it provides a set of solvers for the Ising machine. The `SingleConfigMin` is a solver that finds the minimum energy configuration of the Ising machine. The `extract_solution` function is used to extract the solution from the result of the solver. The solution is then used to find the factors of the input number.

*Code not yet been tested*

= CONCLUSIONS AND OUTLOOK

Conclude the work and try to find the shortcomings: not complete reduction graph would lead to bad reduction complexity(bad scalability); existing solver `BruteForce` is bad, we need a better solvers that may simulate the Ising machine in order to realize this idea.

= Acknowledgements
#jinguo([Thank XXX for the help in the project.])

= Appendix

== Julia <Julia>

- Official website: #link("https://julialang.org/")[JuliaLang]

- Julia Introduction: #link("https://benlauwens.github.io/ThinkJulia.jl/latest/book.html")[ThinkJulia.jl], #link("https://book.jinguo-group.science/stable/")[Scientific Computing for Physicists]

== Package Website <ProblemReductions.jl>

- #link("https://github.com/GiggleLiu/ProblemReductions.jl")[ProblemReductions.jl]

== My Contributions to the Package

My contribution the the package as _c-allergic_ during the summer vacation:
-  #link("https://github.com/GiggleLiu/ProblemReductions.jl/graphs/contributors")[Code Contributions]

#jinguo([please list the PRs])


- #link("https://github.com/GiggleLiu/ProblemReductions.jl/pulls?q=author%3Ac-allergic")[Pull Requests]