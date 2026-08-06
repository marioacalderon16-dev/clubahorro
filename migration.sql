-- Tabla para almacenar los jugadores del sorteo por sala
CREATE TABLE sorteo_players (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  room_code VARCHAR(8) NOT NULL,
  name VARCHAR(50) NOT NULL,
  score INTEGER NOT NULL CHECK (score >= 0 AND score <= 999),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Un participante solo puede jugar una vez por sala (case-insensitive)
CREATE UNIQUE INDEX idx_sorteo_room_name ON sorteo_players (room_code, LOWER(name));

-- Un numero no se puede repetir en la misma sala
CREATE UNIQUE INDEX idx_sorteo_room_score ON sorteo_players (room_code, score);

-- Indice para consultas por sala
CREATE INDEX idx_sorteo_room ON sorteo_players (room_code);

-- RLS: permitir lectura e insercion publica (juego abierto)
ALTER TABLE sorteo_players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Lectura publica" ON sorteo_players
  FOR SELECT USING (true);

CREATE POLICY "Insercion publica" ON sorteo_players
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Eliminacion publica" ON sorteo_players
  FOR DELETE USING (true);

-- Habilitar Realtime para sincronizacion en vivo
ALTER PUBLICATION supabase_realtime ADD TABLE sorteo_players;
