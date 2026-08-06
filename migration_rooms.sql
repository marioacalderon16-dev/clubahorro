-- Tabla para registrar las salas creadas
CREATE TABLE sorteo_rooms (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  code VARCHAR(8) UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE sorteo_rooms ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Lectura publica" ON sorteo_rooms FOR SELECT USING (true);
CREATE POLICY "Insercion publica" ON sorteo_rooms FOR INSERT WITH CHECK (true);
CREATE POLICY "Eliminacion publica" ON sorteo_rooms FOR DELETE USING (true);
