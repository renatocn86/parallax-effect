/// @func circuit_add_segment(_x1,_y1,_x2,_y2)
/// Adiciona um segmento ortogonal e detecta junções com os existentes.

/// @func circuit_init()
/// Garante que o grafo global existe. Idempotente.
function circuit_init() {
    if (!variable_global_exists("circuit")) {
        global.circuit = {
            segments:  [],
            junctions: []
        };
    }
}

/// Retorna o índice do segmento, ou -1 se inválido.
function circuit_add_segment(_x1, _y1, _x2, _y2) {
	circuit_init();
    if (_x1 == _x2 && _y1 == _y2) return -1;   // comprimento zero
    if (_x1 != _x2 && _y1 != _y2) return -1;   // não é ortogonal

    var seg = {
        x1: min(_x1, _x2),
        y1: min(_y1, _y2),
        x2: max(_x1, _x2),
        y2: max(_y1, _y2)
    };

    var idx = array_length(global.circuit.segments);
    array_push(global.circuit.segments, seg);

    // Testa contra todos os anteriores — O(n) por inserção, O(n²) no total.
    // Suficiente para centenas de fios. Otimizamos depois com spatial hash.
    for (var i = 0; i < idx; i++) {
        var p = circuit_segment_intersection(seg, global.circuit.segments[i]);
        if (p != undefined) {
            circuit_mark_junction(p.x, p.y, idx, i);
        }
    }

    return idx;
}

/// @func circuit_add_wire(_x1,_y1,_cx,_cy,_x2,_y2)
/// Adiciona um fio em L (dois segmentos).
function circuit_add_wire(_x1, _y1, _cx, _cy, _x2, _y2) {
    circuit_add_segment(_x1, _y1, _cx, _cy);
    circuit_add_segment(_cx, _cy, _x2, _y2);
}

/// @func circuit_segment_intersection(_a, _b)
/// Retorna { x, y } se os segmentos se cruzam, senão undefined.
function circuit_segment_intersection(_a, _b) {
    var a_h = (_a.y1 == _a.y2);
    var b_h = (_b.y1 == _b.y2);

    // Caso 1: ambos horizontais ou ambos verticais (paralelos)
    if (a_h == b_h) {
        if (a_h) {
            if (_a.y1 != _b.y1) return undefined;
            var lo = max(_a.x1, _b.x1);
            var hi = min(_a.x2, _b.x2);
            if (lo > hi) return undefined;
            return { x: lo, y: _a.y1 };
        } else {
            if (_a.x1 != _b.x1) return undefined;
            var lo = max(_a.y1, _b.y1);
            var hi = min(_a.y2, _b.y2);
            if (lo > hi) return undefined;
            return { x: _a.x1, y: lo };
        }
    }

    // Caso 2: um horizontal, um vertical (perpendicular)
    var h = a_h ? _a : _b;
    var v = a_h ? _b : _a;
    var px = v.x1;
    var py = h.y1;

    if (px >= h.x1 && px <= h.x2 &&
        py >= v.y1 && py <= v.y2) {
        return { x: px, y: py };
    }
    return undefined;
}

/// @func circuit_mark_junction(_x,_y,_i,_j)
/// Registra uma junção no ponto, agregando índices de segmentos sem duplicar.
function circuit_mark_junction(_x, _y, _i, _j) {
    var js = global.circuit.junctions;
    for (var k = 0; k < array_length(js); k++) {
        if (js[k].x == _x && js[k].y == _y) {
            if (!_array_has(js[k].segs, _i)) array_push(js[k].segs, _i);
            if (!_array_has(js[k].segs, _j)) array_push(js[k].segs, _j);
            return;
        }
    }
    array_push(js, { x: _x, y: _y, segs: [_i, _j] });
}

/// @func _array_has(_arr, _val)
function _array_has(_arr, _val) {
    for (var i = 0; i < array_length(_arr); i++) {
        if (_arr[i] == _val) return true;
    }
    return false;
}