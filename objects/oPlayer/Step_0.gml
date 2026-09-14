key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_space)

x -= (key_left - key_right)*5

if(place_meeting(x, y+1, oSolid)){
	vsp = 0
	if(key_jump){
		vsp = -2
	}
}

//move_and_collide(hsp, vsp, oSolid)

y += 1

var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

// Script para deslocamento versão BAHIA. Entrega o mesmo resultado da bersão NOOB, mas com menos trabalho:

spd = 1 // Velocidade padrão, é resetada quando o personagem para
for(i = 1; i <= 11; i++){ // O laço for repete o processo para os 11 backgrounds
	layer_x("Background_"+string(i), camX * spd); // Desloca o layer. Fiz a concatenação do 'i' com 'Background_' para acessar o background certo
	layer_y("Background_"+string(i), camY * spd); // O mesmo deslocamento, mas agora para o eixo y
	spd -= 0.1 // Decrementa a velocidade a cada iteração, deixando cada layer em sua velocidade ideal
}


