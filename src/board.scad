$fieldDiameter=10;
$fieldSeparator=5;
$boardHeight=7;
$fieldDepth=5;
$homeHeight=3;
$boardOffset=2.5;

module home() {
translate([0, $fieldDiameter/2+$fieldSeparator, 0]) {
translate([-$fieldDiameter/2-$fieldSeparator/2, 0, 0])
cube([$fieldDiameter+$fieldSeparator, $fieldDiameter*4+$fieldSeparator*3, $homeHeight]);
resize([$fieldDiameter+$fieldSeparator, $fieldSeparator, 0])
cylinder(d=$fieldSeparator, h=$homeHeight);
translate([0, $fieldDiameter*4+$fieldSeparator*3, 0])
resize([$fieldDiameter+$fieldSeparator, $fieldSeparator, 0])
cylinder(d=$fieldSeparator, h=$homeHeight);
}
}

module crossHomes() {
home();
rotate([0, 0, -90]) home();
rotate([0, 0, 180]) home();
rotate([0, 0, 90]) home();
}

module fieldsPart() {
znormal=-$fieldDepth;
zhome=+$homeHeight-$fieldDepth;
for( i = [-1:1]) {
for( j = [1:5]) {
x=($fieldSeparator+$fieldDiameter)*i;
y=($fieldSeparator+$fieldDiameter)*j;
z=(i==0&&j<=4)?zhome:znormal;
translate([x,y,z])
cylinder(d=$fieldDiameter, h=$fieldDepth);
}
}
}

module crossFields() {
fieldsPart();
rotate([0, 0, -90]) fieldsPart();
rotate([0, 0, 180]) fieldsPart();
rotate([0, 0, 90]) fieldsPart();
}

module start() {
x_dist = $fieldDiameter*5.5+$fieldSeparator*6;
y_dist = $fieldDiameter*1.5+$fieldSeparator*2;
a = sqrt((y_dist-x_dist)^2+(x_dist-y_dist)^2);
l=a/sqrt(2);
d=l-$fieldDiameter-$fieldDiameter/2-$fieldSeparator;
ofs=$fieldDiameter+$fieldSeparator;
translate([0, ofs, 0]) {
translate([0, d, -$fieldDepth]) {
o=$fieldSeparator/2+$fieldDiameter/2;
translate([-o, 0, 0]) cylinder(d=$fieldDiameter, h=$fieldDepth);
translate([0, o, 0]) cylinder(d=$fieldDiameter, h=$fieldDepth);
translate([o, 0, 0]) cylinder(d=$fieldDiameter, h=$fieldDepth);
translate([0, -o, 0]) cylinder(d=$fieldDiameter, h=$fieldDepth);
}
}
}

module crossStarts() {
rotate([0, 0, 45]) start();
rotate([0, 0, -45]) start();
rotate([0, 0, -135]) start();
rotate([0, 0, 135]) start();
}

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

module board() {
x_dist = $fieldDiameter*5.5+$fieldSeparator*6;
y_dist = $fieldDiameter*1.5+$fieldSeparator*2;

difference() {
union() {
shape(x_dist, y_dist, $boardHeight);
shape(x_dist+$boardOffset, y_dist+$boardOffset, $boardHeight-$fieldDepth);

translate([0, 0, $boardHeight]) crossHomes();

}

translate([0, 0, $boardHeight]) crossFields();
translate([0, 0, $boardHeight]) crossStarts();
}
}

module microBoard() {
d = $fieldDiameter*5.5+$fieldSeparator*6;
h=$boardHeight+$homeHeight;
difference() {
board();
cube([d, d, h]);
translate([-d, 0, 0]) cube([d, d, h]);
translate([-d, -d, 0]) cube([d, d, h]);
}
}

board();