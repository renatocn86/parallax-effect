// Fios
draw_set_color(c_yellow);
var segs = global.circuit.segments;
for (var i = 0; i < array_length(segs); i++) {
    var s = segs[i];
    draw_line(s.x1, s.y1, s.x2, s.y2);
}

// Junções
draw_set_color(c_lime);
var js = global.circuit.junctions;
for (var i = 0; i < array_length(js); i++) {
    draw_circle(js[i].x, js[i].y, 4, false);
}