-- ==============================================================================
-- SCRIPT DE INSTALACIÓN PARA SUPABASE - SD ALMERIA
-- Proyecto: https://qkvqoiszyhwfjkwsyotf.supabase.co
-- Instrucciones:
-- 1. Ve a tu panel de Supabase: https://supabase.com/dashboard/project/qkvqoiszyhwfjkwsyotf/sql/new
-- 2. Pega este contenido en el SQL Editor y pulsa RUN
-- ==============================================================================

-- ==============================================================================
-- 🚀 SOLUCIÓN COMPLETA PARA CORREGIR ERRORES (COLUMNA 'localidad' Y BUCKET 'jugadores')
-- Copia y pulsa RUN en: https://supabase.com/dashboard/project/qkvqoiszyhwfjkwsyotf/sql/new
-- ==============================================================================

-- 1. Añadir columnas que falten en la tabla 'jugadores':
ALTER TABLE public.jugadores ADD COLUMN IF NOT EXISTS localidad TEXT DEFAULT 'Almería';
ALTER TABLE public.jugadores ADD COLUMN IF NOT EXISTS foto TEXT;

-- 2. Crear el Bucket de Storage 'jugadores' (corrige 'Bucket not found'):
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'jugadores',
  'jugadores',
  true,
  5242880,
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/svg+xml']
)
ON CONFLICT (id) DO UPDATE SET public = true;

-- 3. Políticas de acceso público para el bucket 'jugadores':
DROP POLICY IF EXISTS "Lectura publica fotos jugadores" ON storage.objects;
CREATE POLICY "Lectura publica fotos jugadores"
  ON storage.objects FOR SELECT TO anon, authenticated
  USING (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Subida publica fotos jugadores" ON storage.objects;
CREATE POLICY "Subida publica fotos jugadores"
  ON storage.objects FOR INSERT TO anon, authenticated
  WITH CHECK (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Actualizar fotos jugadores" ON storage.objects;
CREATE POLICY "Actualizar fotos jugadores"
  ON storage.objects FOR UPDATE TO anon, authenticated
  USING (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Borrar fotos jugadores" ON storage.objects;
CREATE POLICY "Borrar fotos jugadores"
  ON storage.objects FOR DELETE TO anon, authenticated
  USING (bucket_id = 'jugadores');

-- 4. Rellenar fotos y localidades de los 20 jugadores iniciales:
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Móstoles') WHERE dorsal = 1;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'São Paulo') WHERE dorsal = 2;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Garça') WHERE dorsal = 3;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Camas (Sevilla)') WHERE dorsal = 4;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'La Pobla de Segur') WHERE dorsal = 5;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Terrassa') WHERE dorsal = 6;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Funchal (Madeira)') WHERE dorsal = 7;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Fuentealbilla') WHERE dorsal = 8;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Río de Janeiro') WHERE dorsal = 9;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Rosario') WHERE dorsal = 10;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1507591064344-4c6ce005b128?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Marsella') WHERE dorsal = 11;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Río de Janeiro') WHERE dorsal = 12;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1528892952291-009c663ce843?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Carrara') WHERE dorsal = 13;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Les Ulis (París)') WHERE dorsal = 14;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Porto Alegre') WHERE dorsal = 15;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Badia del Vallès') WHERE dorsal = 16;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Drongen (Gante)') WHERE dorsal = 17;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Greifswald') WHERE dorsal = 18;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Zadar') WHERE dorsal = 19;
UPDATE public.jugadores SET foto = 'https://images.unsplash.com/photo-1520409364224-63400afe26e5?auto=format&fit=crop&w=256&q=80', localidad = COALESCE(localidad, 'Arguineguín') WHERE dorsal = 20;

-- 5. Recargar la caché de esquemas de Supabase inmediatamente:
NOTIFY pgrst, 'reload schema';

-- ==============================================================================
-- SCRIPT COMPLETO DE DEFINICIÓN Y MIGRACIÓN
-- ==============================================================================

-- 2. CREACIÓN DE LA TABLA DE JUGADORES (CON CAMPO LOCALIDAD Y FOTO)
CREATE TABLE IF NOT EXISTS public.jugadores (
  dorsal INTEGER PRIMARY KEY,
  nombre TEXT NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  localidad TEXT DEFAULT 'Almería',
  foto TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Si la tabla ya fue creada previamente, asegurar que se añadan las columnas:
ALTER TABLE public.jugadores ADD COLUMN IF NOT EXISTS localidad TEXT DEFAULT 'Almería';
ALTER TABLE public.jugadores ADD COLUMN IF NOT EXISTS foto TEXT;

-- 3. ALMACENAMIENTO (STORAGE) EN SUPABASE PARA SUBIR FOTOS DE JUGADORES
-- Crear el bucket de almacenamiento público 'jugadores'
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'jugadores',
  'jugadores',
  true,
  5242880, -- 5 MB
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
)
ON CONFLICT (id) DO UPDATE
SET public = true,
    file_size_limit = 5242880,
    allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif'];

-- Políticas de Storage para lectura, subida, edición y borrado público de fotos
DROP POLICY IF EXISTS "Lectura publica de fotos de jugadores" ON storage.objects;
CREATE POLICY "Lectura publica de fotos de jugadores"
  ON storage.objects FOR SELECT
  TO anon, authenticated
  USING (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Subida publica de fotos de jugadores" ON storage.objects;
CREATE POLICY "Subida publica de fotos de jugadores"
  ON storage.objects FOR INSERT
  TO anon, authenticated
  WITH CHECK (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Edicion publica de fotos de jugadores" ON storage.objects;
CREATE POLICY "Edicion publica de fotos de jugadores"
  ON storage.objects FOR UPDATE
  TO anon, authenticated
  USING (bucket_id = 'jugadores');

DROP POLICY IF EXISTS "Borrado publico de fotos de jugadores" ON storage.objects;
CREATE POLICY "Borrado publico de fotos de jugadores"
  ON storage.objects FOR DELETE
  TO anon, authenticated
  USING (bucket_id = 'jugadores');

-- 4. CREACIÓN DE LA TABLA DE PARTIDOS (CON CAMPO RESULTADO)
CREATE TABLE IF NOT EXISTS public.partidos (
  id TEXT PRIMARY KEY,
  competicion TEXT NOT NULL,
  local TEXT NOT NULL,
  visitante TEXT NOT NULL,
  resultado TEXT DEFAULT '0 - 0',
  url_youtube TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Si la tabla partidos ya fue creada previamente sin 'resultado', asegurar que se añada la columna:
ALTER TABLE public.partidos ADD COLUMN IF NOT EXISTS resultado TEXT DEFAULT '0 - 0';

-- 4. HABILITACIÓN DE SEGURIDAD DE FILA (Row Level Security - RLS)
ALTER TABLE public.jugadores ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.partidos ENABLE ROW LEVEL SECURITY;

-- 5. POLÍTICAS DE ACCESO PARA LECTURA, INSERCIÓN, EDICIÓN Y BORRADO (ANON / PUBLIC)
DROP POLICY IF EXISTS "Permitir todo a jugadores" ON public.jugadores;
CREATE POLICY "Permitir todo a jugadores"
  ON public.jugadores
  FOR ALL
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Permitir todo a partidos" ON public.partidos;
CREATE POLICY "Permitir todo a partidos"
  ON public.partidos
  FOR ALL
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- 6. POBLADO INICIAL CON LOS 20 JUGADORES (INCLUYENDO LOCALIDAD Y FOTO)
INSERT INTO public.jugadores (dorsal, nombre, fecha_nacimiento, localidad, foto)
VALUES
  (1, 'Iker Casillas', '1981-05-20', 'Móstoles', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=256&q=80'),
  (2, 'Cafú', '1970-06-07', 'São Paulo', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=256&q=80'),
  (3, 'Roberto Carlos', '1973-04-10', 'Garça', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=256&q=80'),
  (4, 'Sergio Ramos', '1986-03-30', 'Camas (Sevilla)', 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=256&q=80'),
  (5, 'Carles Puyol', '1978-04-13', 'La Pobla de Segur', 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=256&q=80'),
  (6, 'Xavi Hernández', '1980-01-25', 'Terrassa', 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=256&q=80'),
  (7, 'Cristiano Ronaldo', '1985-02-05', 'Funchal (Madeira)', 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=256&q=80'),
  (8, 'Andrés Iniesta', '1984-05-11', 'Fuentealbilla', 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=256&q=80'),
  (9, 'Ronaldo Nazário', '1976-09-22', 'Río de Janeiro', 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=256&q=80'),
  (10, 'Lionel Messi', '1987-06-24', 'Rosario', 'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?auto=format&fit=crop&w=256&q=80'),
  (11, 'Zinédine Zidane', '1972-06-23', 'Marsella', 'https://images.unsplash.com/photo-1507591064344-4c6ce005b128?auto=format&fit=crop&w=256&q=80'),
  (12, 'Marcelo Vieira', '1988-05-12', 'Río de Janeiro', 'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?auto=format&fit=crop&w=256&q=80'),
  (13, 'Gianluigi Buffon', '1978-01-28', 'Carrara', 'https://images.unsplash.com/photo-1528892952291-009c663ce843?auto=format&fit=crop&w=256&q=80'),
  (14, 'Thierry Henry', '1977-08-17', 'Les Ulis (París)', 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=256&q=80'),
  (15, 'Ronaldinho Gaúcho', '1980-03-21', 'Porto Alegre', 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=256&q=80'),
  (16, 'Sergio Busquets', '1988-07-16', 'Badia del Vallès', 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=256&q=80'),
  (17, 'Kevin De Bruyne', '1991-06-28', 'Drongen (Gante)', 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=256&q=80'),
  (18, 'Toni Kroos', '1990-01-04', 'Greifswald', 'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4?auto=format&fit=crop&w=256&q=80'),
  (19, 'Luka Modrić', '1985-09-09', 'Zadar', 'https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&w=256&q=80'),
  (20, 'David Silva', '1986-01-08', 'Arguineguín', 'https://images.unsplash.com/photo-1520409364224-63400afe26e5?auto=format&fit=crop&w=256&q=80')
ON CONFLICT (dorsal) DO UPDATE
SET nombre = EXCLUDED.nombre,
    fecha_nacimiento = EXCLUDED.fecha_nacimiento,
    localidad = EXCLUDED.localidad,
    foto = EXCLUDED.foto;

-- 7. POBLADO INICIAL DE PARTIDOS (CON RESULTADO)
INSERT INTO public.partidos (id, competicion, local, visitante, resultado, url_youtube)
VALUES
  ('match-1', 'Liga', 'Real Madrid CF', 'Villarreal CF', '2 - 0', 'https://www.youtube.com/watch?v=a3ICNMQW7Ok'),
  ('match-2', 'Liga', 'Atlético de Madrid', 'FC Barcelona', '0 - 3', 'https://www.youtube.com/watch?v=9No-FiEInLA'),
  ('match-3', 'Copa', 'Athletic Club', 'RCD Mallorca', '1 - 1', 'https://www.youtube.com/watch?v=ScMzIvxBSi4'),
  ('match-4', 'Amistoso', 'Sevilla FC', 'Real Betis Balompié', '1 - 0', 'https://www.youtube.com/watch?v=fJ9rUzIMcZQ')
ON CONFLICT (id) DO UPDATE
SET competicion = EXCLUDED.competicion,
    local = EXCLUDED.local,
    visitante = EXCLUDED.visitante,
    resultado = EXCLUDED.resultado,
    url_youtube = EXCLUDED.url_youtube;
