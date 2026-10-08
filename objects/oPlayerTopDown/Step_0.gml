var move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var move_y = keyboard_check(vk_down) - keyboard_check(vk_up);
move_and_collide(move_x * my_speed, move_y * my_speed, oCaixa);