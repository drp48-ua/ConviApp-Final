Add-Type -Path "C:\Users\danir\.gemini\antigravity\scratch\ConviApp-Final\lib\SQLite\System.Data.SQLite.dll"
$con = New-Object System.Data.SQLite.SQLiteConnection("Data Source=C:\Users\danir\.gemini\antigravity\scratch\ConviApp-Final\ConviAppWeb\conviapp.db;Version=3;")
$con.Open()
$cmd = $con.CreateCommand()

$tables = @(
    "CREATE TABLE IF NOT EXISTS Incidencia (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descripcion TEXT, estado TEXT, prioridad TEXT, fecha_reporte TEXT, reportada_por_id INTEGER, piso_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Mensaje (id INTEGER PRIMARY KEY AUTOINCREMENT, contenido TEXT, fecha_envio TEXT, leido INTEGER, emisor_id INTEGER, receptor_id INTEGER, piso_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Contrato (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, start_date TEXT, end_date TEXT, monthly_rent NUMERIC, deposit_amount NUMERIC, status TEXT, notes TEXT, commission_rate NUMERIC, property_id INTEGER, user_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Documento (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, file_path TEXT, upload_date TEXT, category TEXT, type TEXT, contract_id INTEGER, uploaded_by_id INTEGER, property_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Gasto (id INTEGER PRIMARY KEY AUTOINCREMENT, concepto TEXT, importe NUMERIC, fecha TEXT, pagado INTEGER, descripcion TEXT, registrado_por_id INTEGER, piso_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Tarea (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descripcion TEXT, fecha_creacion TEXT, fecha_vencimiento TEXT, estado TEXT, completada INTEGER, asignada_a_id INTEGER, piso_id INTEGER);",
    "CREATE TABLE IF NOT EXISTS Notificacion (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, mensaje TEXT, tipo TEXT, leida INTEGER, fecha_creacion TEXT, fecha_lectura TEXT, usuario_id INTEGER);"
)

foreach ($sql in $tables) {
    $cmd.CommandText = $sql
    $cmd.ExecuteNonQuery()
}

$con.Close()
Write-Host "Todas las tablas han sido creadas exitosamente."
