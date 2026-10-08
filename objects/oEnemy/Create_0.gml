#region Atributos do Inimigo
move_speed = 2;         // Inimigos geralmente são um pouco mais lentos que o player
gravity_force = 1;      // Mesma gravidade do cenário
max_fall_speed = 10;

move_x = 0;
move_y = 0;
facing = 1;             // 1 = Direita, -1 = Esquerda (para virar o sprite)
#endregion

#region Configurações de IA (Inteligência Artificial)
aggro_range = 200;      // Distância em pixels para o inimigo "enxergar" o jogador
is_chasing = false;     // Define se ele está perseguindo ou parado
#endregion