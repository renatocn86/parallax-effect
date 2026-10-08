// Descarta fios nulos
if (start_x == end_x && start_y == end_y) {
    instance_destroy();
    exit;
}
show_debug_message("circuit: " + string(global.circuit));
circuit_add_wire(start_x, start_y, corner_x, corner_y, end_x, end_y);
show_debug_message("circuit: " + string(global.circuit));
