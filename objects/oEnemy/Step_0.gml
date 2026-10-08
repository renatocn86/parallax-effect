#region Inteligência Artificial (Seguir o Player)

// 1. REGRA DE OURO: Sempre verifique se o player existe antes de procurar por ele!
// Se o player morrer/for destruído e o inimigo tentar procurá-lo, o jogo vai crashar.
if (instance_exists(oPlayer)) {
    
    // Calcula a distância exata entre o inimigo e o player
    var _dist = distance_to_object(oPlayer);
    
    // Se o player entrar no raio de visão, começa a perseguição
    if (_dist <= aggro_range) {
        is_chasing = true;
    } 
    // Opcional: Se o player fugir para muito longe, ele desiste
    else if (_dist > aggro_range * 1.5) {
        is_chasing = false;
    }
    
    // --- COMPORTAMENTO ---
    if (is_chasing) {
        // A Mágica Matemática:
        // (oPlayer.x - x) descobre a diferença de posição.
        // sign() transforma qualquer resultado nisso em 1 (Direita), -1 (Esquerda) ou 0 (Mesmo lugar).
        var _dir_x = sign(oPlayer.x - x);
        
        move_x = _dir_x * move_speed;
    } else {
        // Se não está perseguindo, fica parado (ou você pode adicionar uma patrulha aqui depois)
        move_x = 0;
    }
    
} else {
    // Se o player não existe na room, o inimigo fica parado
    move_x = 0;
    is_chasing = false;
}

#endregion

#region Física e Gravidade
// Verifica se NÃO está no chão para aplicar a gravidade
if (!place_meeting(x, y + 2, oSolid)) {
    if (move_y < max_fall_speed) {
        move_y += gravity_force;
    }
} else {
    // Tocou no chão
    move_y = 0; 
}
#endregion

#region Aplicação de Colisão
// Usa o mesmo sistema de colisão robusto que configuramos para o Player
move_and_collide(move_x, move_y, oSolid, 4, 0, 0, move_speed, -1);
#endregion

#region Controle Visual (Virar o Sprite)
// Vira o inimigo para a direção que ele está andando
if (move_x != 0) {
    facing = sign(move_x);
}
#endregion