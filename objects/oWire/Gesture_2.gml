// Ajusta o ponto inicial à grade mais próxima
start_x = (mouse_x div grid_size) * grid_size;
start_y = (mouse_y div grid_size) * grid_size;

// O ponto final começa igual ao inicial
end_x = start_x;
end_y = start_y;

corner_x = start_x;
corner_y = start_y;

is_dragging = true;