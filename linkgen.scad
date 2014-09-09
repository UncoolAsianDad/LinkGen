module chainHalf(r,gap) {
	translate([-gap,0,0])
	difference() {
		chain(r,gap);
		translate([-gap-r,0,0])
		cube([(gap+r)*2-0.5, (gap+r)*3, (gap+r)*2], center=true);
	}
}

module chain(r, gap) {
   $fn=30;

	module sidebar(radius, gap) {
		rotate([ 90, 0, 90 ])
		translate([gap,0,0])
		linear_extrude(gap*2, center=true)
		circle(r = radius);

		rotate([ 90, 0, 90 ])
		translate([-gap,0,0])
		linear_extrude(gap*2, center=true)
		circle(r = radius);

		rotate([ 90, 00, 00 ])
		linear_extrude(gap*2, center=true)
		circle(r = radius);
	}

	module donut(radius, gap) {
		rotate_extrude()
		translate([gap, 0, 0])
		circle(r = radius);
	}

	// putting all together
	union() {
		translate([gap,0,0]) donut(r, gap);
		translate([-gap,0,0]) donut(r, gap);
      sidebar(r, gap);
	}
}

module chainlink(num, radius, gap, center = false) {
	offset = (center == true?([-(num)*gap,0,0]):([0,0,0]));
	translate(offset)
		for ( i = [0:num-1] ) {
			rotate( i*90, [1, 0, 0])
			translate( [i*gap*3, 0, 0] ) 
			chain(radius, gap);
	}
}

chainlink(5, 2, 5, center=true);