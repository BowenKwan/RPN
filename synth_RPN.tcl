proc # args {}

#set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-generic {TAP=1 SEED=799}} -objects [get_runs synth_1]

set k_list {1 3 5 10}

#for {set x 2} {$x<=26} {incr x} {
#	set var "synth_$x" 
#	create_run -flow {Vivado Synthesis 2018} $var
#}

#for {set x 1} {$x<=1} {incr x} {
#	set var "synth_$x"
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=5 k=100 R=100} -mode out_of_context" -objects [get_runs $var]
#}

#for {set x 2} {$x<=5} {incr x} {
#	set var "synth_$x"
#	set y [lindex $k_list [expr $x-2]]
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=5 k=$y R=100} -mode out_of_context" -objects [get_runs $var]
#}

#for {set x 6} {$x<=9} {incr x} {
#	set var "synth_$x"
#	set y [lindex $k_list [expr $x-6]]
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=5 k=$y R=10} -mode out_of_context" -objects [get_runs $var]
#}

#for {set x 10} {$x<=13} {incr x} {
#	set var "synth_$x"
#	set y [lindex $k_list [expr $x-10]]
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=5 k=$y R=50} -mode out_of_context" -objects [get_runs $var]
#}


for {set x 14} {$x<=14} {incr x} {
	set var "synth_$x"
	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=10 k=100 R=100} -mode out_of_context" -objects [get_runs $var]
}

for {set x 16} {$x<=18} {incr x} {
	set var "synth_$x"
	set y [lindex $k_list [expr $x-15]]
	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=10 k=$y R=100} -mode out_of_context" -objects [get_runs $var]
}

for {set x 20} {$x<=22} {incr x} {
	set var "synth_$x"
	set y [lindex $k_list [expr $x-19]]
	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=10 k=$y R=10} -mode out_of_context" -objects [get_runs $var]
}

for {set x 24} {$x<=26} {incr x} {
	set var "synth_$x"
	set y [lindex $k_list [expr $x-23]]
	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {N=10 k=$y R=50} -mode out_of_context" -objects [get_runs $var]
}

#for {set x 13} {$x<=24} {incr x} {
#	set var "synth_$x"
#	set y [expr $x-12]
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {BAW=4 LAW=$y} -mode out_of_context" -objects [get_runs $var]
#}

#for {set x 25} {$x<=36} {incr x} {
#	set var "synth_$x"
#	set y [expr $x-24]
#	set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value "-generic {BAW=6 LAW=$y} -mode out_of_context" -objects [get_runs $var]
#}

#for {set x 1} {$x<=36} {incr x} {
#	set var "synth_$x"
#	reset_run -noclean_dir $var
#}


set var "synth_14 "

for {set x 14} {$x<=26} {incr x} {
	append var "synth_$x "
}
launch_runs $var -jobs 8

