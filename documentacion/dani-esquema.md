# Esquema de Base de Datos y Credenciales

## Esquema de la Base de Datos

A continuación se presenta el modelo Entidad-Relación actualizado de la base de datos de ConviApp, reflejando todas las entidades añadidas a lo largo del desarrollo (Contratos, Documentos, Reservas, Notificaciones, etc.):

```mermaid
erDiagram
    Usuario {
        INTEGER id PK
        TEXT nombre
        TEXT apellidos
        TEXT email
        TEXT password_hash
        TEXT telefono
        TEXT fecha_registro
        INTEGER activo
        TEXT rol
    }
    Piso {
        INTEGER id PK
        TEXT direccion
        TEXT ciudad
        TEXT codigo_postal
        INTEGER numero_habitaciones
        INTEGER numero_banos
        REAL precio_total
        TEXT descripcion
        INTEGER disponible
    }
    Gasto {
        INTEGER id PK
        TEXT concepto
        REAL importe
        TEXT fecha
        INTEGER pagado
        TEXT descripcion
        INTEGER registrado_por_id FK
        INTEGER piso_id FK
    }
    Tarea {
        INTEGER id PK
        TEXT titulo
        TEXT descripcion
        TEXT estado
        TEXT prioridad
        TEXT fecha_creacion
        TEXT fecha_limite
        INTEGER creada_por_id FK
        INTEGER asignada_a_id FK
        INTEGER piso_id FK
    }
    Incidencia {
        INTEGER id PK
        TEXT titulo
        TEXT descripcion
        TEXT estado
        TEXT prioridad
        TEXT fecha_reporte
        INTEGER reportada_por_id FK
        INTEGER piso_id FK
    }
    Mensaje {
        INTEGER id PK
        TEXT contenido
        TEXT fecha_envio
        INTEGER leido
        INTEGER emisor_id FK
        INTEGER receptor_id FK
        INTEGER piso_id FK
    }
    Contrato {
        INTEGER id PK
        TEXT type
        TEXT start_date
        TEXT end_date
        NUMERIC monthly_rent
        NUMERIC deposit_amount
        TEXT status
        TEXT notes
        NUMERIC commission_rate
        INTEGER property_id FK
        INTEGER user_id FK
    }
    Notificacion {
        INTEGER id PK
        TEXT titulo
        TEXT mensaje
        TEXT tipo
        INTEGER leida
        TEXT fecha_creacion
        TEXT fecha_lectura
        INTEGER usuario_id FK
    }
    Documento {
        INTEGER id PK
        TEXT file_name
        BLOB file_data
        TEXT content_type
        INTEGER file_size
        TEXT type
        TEXT description
        TEXT upload_date
        INTEGER property_id FK
        INTEGER user_id FK
    }
    Reserva {
        INTEGER id PK
        TEXT fecha_inicio
        TEXT fecha_fin
        TEXT estado
        TEXT motivo
        INTEGER usuario_id FK
        INTEGER zona_comun_id FK
    }

    Usuario ||--o{ Gasto : "registra"
    Piso ||--o{ Gasto : "tiene"
    Usuario ||--o{ Tarea : "crea"
    Usuario ||--o{ Tarea : "es asignado"
    Piso ||--o{ Tarea : "tiene"
    Usuario ||--o{ Incidencia : "reporta"
    Piso ||--o{ Incidencia : "tiene"
    Usuario ||--o{ Mensaje : "envia/recibe"
    Piso ||--o{ Mensaje : "pertenece a"
    Usuario ||--o{ Contrato : "firma"
    Piso ||--o{ Contrato : "asociado a"
    Usuario ||--o{ Notificacion : "recibe"
    Usuario ||--o{ Documento : "sube/asociado"
    Piso ||--o{ Documento : "asociado a"
    Usuario ||--o{ Reserva : "realiza"
```

## Usuarios y Contraseñas de Prueba

Para probar el correcto funcionamiento de la aplicación, se pueden utilizar las siguientes credenciales que ya están presentes en la base de datos por defecto:

### Administrador
- **Email:** `admin@conviapp.com`
- **Contraseña:** `admin123`
- **Rol:** Admin (Da acceso al panel de administración y control total).

### Usuario Básico (Ejemplo)
- **Email:** `daniramonpoveda@gmail.com`
- **Contraseña:** `1234`
- **Rol:** Básico (Da acceso a las vistas estándar de inquilino/propietario).
