
module sidebar(radius, gap) {

  rotate([ 90, 0, 90 ])
  translate([gap,0,0])
  linear_extrude(gap*2, center=true)
  circle(r = radius);

  rotate([ 90, 0, 90 ])
  translate([-gap,0,0])
  linear_extrude(gap*2, center=true)
  circle(r = radius);

}

module donut(radius, gap) {
	$fn=20;
	rotate_extrude()
	translate([gap, 0, 0])
	circle(r = radius);
}


module chain(r, gap) {
	union() {
      sidebar(r, gap);
		translate([gap,0,0]) donut(r, gap);
		translate([-gap,0,0]) donut(r, gap);
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


chainlink(3, 7, 20, center=true);