$fieldDiameter=10;
$fieldSeparator=5;
$boardHeight=7;
$fieldDepth=5;
$homeHeight=3;
$boardOffset=2.5;
$lidHeight=2;

module shape(x_dist, y_dist, h) {
polyhedron(points=[
[-x_dist, -y_dist, 0],
[-x_dist, y_dist, 0],
[-y_dist, x_dist, 0],
[y_dist, x_dist, 0],
[x_dist, y_dist, 0],
[x_dist, -y_dist, 0],
[y_dist, -x_dist, 0],
[-y_dist, -x_dist, 0],
[-x_dist, -y_dist, h],
[-x_dist, y_dist, h],
[-y_dist, x_dist, h],
[y_dist, x_dist, h],
[x_dist, y_dist, h],
[x_dist, -y_dist, h],
[y_dist, -x_dist, h],
[-y_dist, -x_dist, h]
], faces=[
[7, 6, 5, 4, 3, 2, 1, 0],
[8, 9, 10, 11, 12, 13, 14, 15],
[0, 1, 9, 8],
[1, 2, 10, 9],
[2, 3, 11, 10],
[3, 4, 12, 11],
[4, 5, 13, 12],
[5, 6, 14, 13],
[6, 7, 15, 14],
[7, 0, 8, 15]
]);
}

module lid() {
x_dist = $fieldDiameter*5.5+$fieldSeparator*6;
y_dist = $fieldDiameter*1.5+$fieldSeparator*2;

h=$boardHeight+10;

difference() {
shape(x_dist+$boardOffset, y_dist+$boardOffset, h);
translate([0,0,$lidHeight]) shape(x_dist, y_dist, h-$lidHeight);

translate([0, 0, h]) {
rotate([90, 0, 0])
cylinder(h=x_dist*2+$boardOffset*2, r=h-($boardHeight-$fieldDepth), center=true);
rotate([0, 90, 0])
cylinder(h=x_dist*2+$boardOffset*2, r=h-($boardHeight-$fieldDepth), center=true);
}

}
}

lid();