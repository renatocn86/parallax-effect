#region Variáveis de Movimento Padrão
// Configurações básicas de movimentação e física do personagem
move_speed = 5;
jump_speed = 12;
gravity_force = 1;      // Força da gravidade por frame
max_fall_speed = 10;    // Velocidade máxima de queda

move_x = 0;
move_y = 0;
facing = 1;             // 1 = Direita, -1 = Esquerda (utilizado para o visual)
#endregion

#region Variáveis de Pulo Duplo
// Variáveis responsáveis por controlar a quantidade de pulos no ar
jumps_max = 2;          // Número total de pulos permitidos (chão + 1 extra no ar)
jumps_current = 0;      // Contador de quantos pulos o jogador já usou
#endregion

#region Variáveis de Dash
// Configurações da mecânica de impulso rápido (Dash)
dash_speed = 15;        // Velocidade horizontal durante o dash (bem maior que move_speed)
dash_duration = 10;     // Quantos frames o dash dura (10 frames a 60 FPS é rápido)
dash_cooldown_max = 60; // Tempo de espera antes de usar o dash novamente (em frames, ex: 1 segundo)

dash_current_frame = 0; // Contador interno para controlar a duração atual do dash
dash_cooldown_timer = 0;// Contador interno para controlar o cooldown (tempo de recarga)
#endregion

#region Sistema de Máquina de Estados
// Definimos os estados possíveis usando um 'enum' (uma lista de nomes para números).
// Isso evita uso de "números mágicos" e deixa o código mais legível.
enum STATES {
    NORMAL,             // Estado padrão de andar, pular e cair
    DASHING             // Estado onde o jogador está no meio do impulso
}

state = STATES.NORMAL;  // O jogador sempre começa no estado normal
#endregion