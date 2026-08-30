key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))

x -= (key_left - key_right)*5

var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

//Script para deslocamento dos layers, versão NOOB (recomendo a versão mais abaixo)

layer_x("Background_1", camX); // Deslocamento no eixo X
layer_y("Background_1", camY); // Deslocamento no eixo Y

layer_x("Background_2", camX * 0.9);
layer_y("Background_2", camY * 0.9);

layer_x("Background_3", camX * 0.8);
layer_y("Background_3", camY * 0.8);

layer_x("Background_4", camX * 0.7);
layer_y("Background_4", camY * 0.7);

layer_x("Background_5", camX * 0.6);
layer_y("Background_5", camY * 0.6);

layer_x("Background_6", camX * 0.5);
layer_y("Background_6", camY * 0.5);

layer_x("Background_7", camX * 0.4);
layer_y("Background_7", camY * 0.4);

layer_x("Background_8", camX * 0.3);
layer_y("Background_8", camY * 0.3);

layer_x("Background_9", camX * 0.2);
layer_y("Background_9", camY * 0.2);

layer_x("Background_10", camX * 0.1);
layer_y("Background_10", camY * 0.1);

layer_x("Background_11", camX * 0.0);
layer_y("Background_11", camY * 0.0);
// fim da versão NOOB

// Script para deslocamento versão BAHIA. Entrega o mesmo resultado da bersão NOOB, mas com menos trabalho:

spd = 1 // Velocidade padrão, é resetada quando o personagem para
for(i = 1; i <= 11; i++){ // O laço for repete o processo para os 11 backgrounds
	layer_x("Background_"+string(i), camX * spd); // Desloca o layer. Fiz a concatenação do 'i' com 'Background_' para acessar o background certo
	layer_y("Background_"+string(i), camY * spd); // O mesmo deslocamento, mas agora para o eixo y
	spd -= 0.1 // Decrementa a velocidade a cada iteração, deixando cada layer em sua velocidade ideal
}


