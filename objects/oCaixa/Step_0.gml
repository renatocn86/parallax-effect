// Aplica gravidade se não houver um sólido embaixo da caixa
if (!place_meeting(x, y + 2, oSolid)) {
    y += 5; // Ajuste este valor para controlar a velocidade de queda da caixa
}

// Garante que a caixa não fique presa no chão após cair (arredondamento)
if (place_meeting(x, y, oSolid)) {
    y -= 1;
}