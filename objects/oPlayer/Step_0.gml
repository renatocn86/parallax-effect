#region Máquina de Estados (Controle de Inputs e Comportamentos)
// Toda a lógica de input e movimento é separada por estado para evitar conflitos e bugs.
switch (state) {
    
    // ==========================================
    case STATES.NORMAL:
    #region ESTADO: NORMAL (Andar, Pular e Iniciar Dash)
        
        // --- 1. INPUTS DE MOVIMENTO HORIZONTAL ---
        // Direita (1) - Esquerda (1). O resultado será -1, 0 ou 1.
        var _dir_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
        
        // Sobrescreve o move_x para este frame (não acumula ao infinito, evita crash de NaN)
        move_x = _dir_x * move_speed;
        
        
        // --- 2. LÓGICA DE FÍSICA E PULOS (Duplo Incluído) ---
        // Verifica se está tocando no chão
        if (place_meeting(x, y + 2, oSolid)) {
            jumps_current = 0; // No chão, reseta o contador de pulos
            move_y = 0;
        } 
        // Se estiver no ar, aplica a gravidade
        else if (move_y < max_fall_speed) { 
            move_y += gravity_force; 
        }

        // Tenta pular (pressionar espaço)
        // keyboard_check_pressed só ativa UM frame, ideal para não "voar" ao segurar o botão
        if (keyboard_check_pressed(vk_space)) {
            // Verifica se ainda tem pulos disponíveis
            if (jumps_current < jumps_max) {
                move_y = -jump_speed;  // Aplica a força do pulo para cima (y negativo)
                jumps_current += 1;    // Conta o pulo usado
            }
        }
        
        
        // --- 3. ATIVAÇÃO DO DASH ---
        // Decrementa o timer do cooldown (recarga) do dash
        if (dash_cooldown_timer > 0) {
            dash_cooldown_timer -= 1;
        }

        // Tenta usar o dash pressionando Shift ou K
        var _try_dash = keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("K"));
        
        // Condições para o Dash: Tecla pressionada E Cooldown terminou E Está se movendo para um dos lados
        if (_try_dash && dash_cooldown_timer <= 0 && _dir_x != 0) {
            
            state = STATES.DASHING;                 // Muda para o estado de Dash
            dash_current_frame = 0;                 // Zera o contador de duração
            move_x = sign(_dir_x) * dash_speed;     // Aplica a alta velocidade na direção que está andando
            move_y = 0;                             // Zera a gravidade momentaneamente para voar reto
            dash_cooldown_timer = dash_cooldown_max;// Inicia o bloqueio de recarga
        }

    #endregion
    break; // Fim do estado NORMAL


    // ==========================================
    case STATES.DASHING:
    #region ESTADO: DASHING (Execução do Impulso Rápido)
        
        // Incrementa o contador de frames do dash a cada passo da engine
        dash_current_frame += 1;
        
        // Ignora gravidade (move_y) e inputs (move_x) neste estado
        // A velocidade e direção (move_x) já foram definidas ao entrar no estado NORMAL
        move_y = 0; 
        
        // Verifica se o tempo limite do dash foi alcançado
        if (dash_current_frame >= dash_duration) {
            state = STATES.NORMAL;  // Devolve o controle ao jogador
            move_x = 0;             // Zera a velocidade horizontal para cortar o impulso secamente
        }
        
    #endregion
    break; // Fim do estado DASHING
    
}
#endregion

#region Aplicação de Física e Colisões
// A função move_and_collide sempre ocorre fora do Switch para que as paredes funcionem em QUALQUER estado.
move_and_collide(move_x, move_y, oSolid, 4, 0, 0, move_speed, -1);
#endregion

#region Controle Visual e Direção
// Atualiza a variável visual 'facing' baseada na direção do movimento horizontal.
// Isso evita modificar o image_xscale nativo e distorcer a máscara de colisão nas paredes.
// IMPORTANTE: Deve ser usado junto com 'draw_sprite_ext' no evento Draw.
if (move_x != 0) {
    facing = sign(move_x); 
}
#endregion

#region Sistema de Slopes (Declives)
// Permite subir ladeiras suavemente. Se não há parede a frente na altura dos pés (y+2), 
// mas HÁ uma elevação mais baixa (y+10), ele ajusta o move_y para compensar.
if (!place_meeting(x + move_x, y + 2, oSolid) && place_meeting(x + move_x, y + 10, oSolid)) {
    move_y = abs(move_x);
    move_x = 0; 
}
#endregion

#region Parallax (Versão BAHIA)
// Sistema de Parallax otimizado. Desloca os fundos (Background_1 até Background_11) 
// com velocidades independentes de acordo com a câmera.

var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);
var _spd_layer = 1; // Variável local temporária para evitar vazamento de memória

for (var i = 1; i <= 11; i++) { 
    layer_x("Background_" + string(i), camX * _spd_layer); 
    layer_y("Background_" + string(i), camY * _spd_layer); 
    _spd_layer -= 0.1; // Decrementa a velocidade para criar profundidade
}
#endregion