$fa = 0.1; $fs = 0.1; 

$fieldDiameter=10;
$fieldDepth=5;

$pawnDiameter=$fieldDiameter-0.3;
$pawnHeight=$fieldDepth*2.6;
$pawnOuterDiameter=$fieldDiameter+2;

module pawn(fn=0) {
cylinder(d=$pawnDiameter, h=$fieldDepth);
cylinder(d=$pawnDiameter/2, h=$pawnHeight);
translate([0, 0, $fieldDepth])
resize([0, 0, $fieldDepth*2])
sphere(d=$pawnDiameter);
translate([0, 0, $fieldDepth])
cylinder(d1=0, d2=$pawnOuterDiameter, h=$pawnHeight*0.95-$fieldDepth, $fn=fn);
translate([0, 0, $pawnHeight*0.95])
cylinder(d=$pawnOuterDiameter, h=$pawnHeight*0.05, $fn=fn);
}

rs=[0,3,4,6];

for( i = [0:3]) {
for( j = [0:3]) {
translate([i*15, j*15])
pawn(rs[i]);
}
}