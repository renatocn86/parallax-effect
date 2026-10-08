end_x = (mouse_x div grid_size) * grid_size;
end_y = (mouse_y div grid_size) * grid_size;

var dx = abs(end_x - start_x);
var dy = abs(end_y - start_y);

if (dx >= dy) {
    // Mais deslocamento horizontal → horizontal primeiro
    corner_x = end_x;
    corner_y = start_y;
} else {
    // Mais deslocamento vertical → vertical primeiro
    corner_x = start_x;
    corner_y = end_y;
}