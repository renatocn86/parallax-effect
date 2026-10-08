if (is_dragging) {
    draw_set_color(c_yellow);

    // Segmento 1: start → corner
    draw_line(start_x, start_y, corner_x, corner_y);
    // Segmento 2: corner → end
    draw_line(corner_x, corner_y, end_x, end_y);

    // Extremidades
    draw_set_color(c_white);
    draw_circle(start_x, start_y, 4, false);
    draw_circle(end_x,   end_y,   4, false);
}