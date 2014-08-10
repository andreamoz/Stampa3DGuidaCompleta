module bordino_x (dim_tel, spessore){
	translate([
		0, 
		dim_tel[1] / 2 - spessore / 2, 
		dim_tel[2] / 2 + spessore / 2])
	cube([dim_tel[0] * 8 / 10, spessore, spessore], center = true);
}

module bordino_y (dim_tel, spessore){
	translate([
		dim_tel[0] / 2 - spessore / 2, 
		0, 
		dim_tel[2] / 2 + spessore / 2])
	cube([spessore, dim_tel[1] * 8 / 10, spessore], center = true);
}

module bordini(dim_tel, spessore){
	bordino_x(dim_tel, spessore);
	mirror([0, 1, 0])
	bordino_x(dim_tel, spessore);

	bordino_y(dim_tel, spessore);
	mirror([1, 0, 0])
	bordino_y(dim_tel, spessore);
}

module roundedBox(dim_tel, curvatura)
{
	cube(dim_tel - [2 * curvatura, 0, 0], true);
	cube(dim_tel - [0,2 * curvatura, 0], true);
	for (
		x = [curvatura - dim_tel[0]/2, - curvatura + dim_tel[0]/2],
		y = [curvatura - dim_tel[1]/2, - curvatura + dim_tel[1]/2]) {
			translate([x,y,0]) 
			cylinder(r = curvatura, h = dim_tel[2], center = true);
	}
}

module corpo(dim_tel, spessore, curvatura) {
	difference() {
		roundedBox([
			dim_tel[0] + 2 * spessore,
			dim_tel[1] + 2 * spessore,
			dim_tel[2] + 2 * spessore], 10);
		translate([0, 0, spessore])
		roundedBox(dim_tel, curvatura);
	}
}

module custodia(dim_tel, spessore, curvatura) {
	corpo(dim_tel, spessore, curvatura);
	bordini(dim_tel, spessore);
}

// utilizzo: 

 //spessore = 1;
 //dim_tel = [58.55, 115.15, 9.4];

 //custodia(dim_tel, spessore, 20);


