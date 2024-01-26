proc # args {}

#for {set x 1} {$x<=26} {incr x} {
#	set var "impl_$x"
#	set y "synth_$x" 
#	create_run $var -parent_run $y -flow {Vivado Implementation 2018}
#}



set var "impl_1 "
for {set x 2} {$x<=13} {incr x} {
	append var "impl_$x "
}
launch_runs $var -jobs 8