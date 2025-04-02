<<<<<<< HEAD
# maileraction
=======
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
>>>>>>> 588b03b (Inicialización del proyecto MailerAction)

# 📬 Modelo EmailLog

El modelo `EmailLog` representa los registros de envíos de correos electrónicos realizados por campañas en MailerAction.

## 🧱 Asociaciones

- `belongs_to :campaign`
- `belongs_to :email_record`

## ✅ Campos relevantes

| Campo              | Tipo     | Descripción                                                |
|-------------------|----------|------------------------------------------------------------|
| `status`          | string   | Estado del envío (`success`, `error`, `delivered`)         |
| `credit_refunded` | boolean  | Indica si se devolvió el crédito (para planes prepagos)    |

## 🚦 Enum: `status`

Este campo usa un `enum` con valores:

```ruby
enum status: {
  success: "success",
  error: "error",
  delivered: "delivered"
}



## 🧠 Recuento automático de correos por industria

MailerAction actualiza automáticamente el número de correos públicos asociados a cada industria utilizando el campo `email_count` en el modelo `Industry`.

### 🔄 ¿Cómo funciona?

Cada vez que se crea o elimina un `PublicEmailRecord`, el campo `email_count` se actualiza gracias al uso de `counter_cache: true`:

```ruby
belongs_to :industry, counter_cache: true



En caso de que necesites sincronizar los contadores (por ejemplo, luego de importar datos masivamente o eliminar registros), podés usar una de las siguientes opciones:

✅ Opción 1: Desde consola Rails
bash
Copiar
Editar
bin/rails console
ruby
Copiar
Editar
Industry.find_each do |industry|
  Industry.reset_counters(industry.id, :public_email_records)
end
✅ Opción 2: Ejecutar job en segundo plano
MailerAction incluye un Job que puede ejecutarse en segundo plano para recalcular los contadores:

ruby
Copiar
Editar
ResetIndustryEmailCountsJob.perform_later
También podés dispararlo mediante un endpoint autenticado:

http
Copiar
Editar
POST /api/v1/admin/industries/reset_counts
📌 Requisitos: asegurarse de tener configurado SolidQueue como adaptador para ActiveJob:

ruby
Copiar
Editar
config.active_job.queue_adapter = :solid_queue
css
Copiar
Editar

¿Querés que te genere la versión en inglés también por si lo vas a subir a GitHub como proyecto público?





## 📘 API - Endpoints Disponibles

| Ruta                                        | Método         | Descripción                                           |
|---------------------------------------------|----------------|-------------------------------------------------------|
| /login                                      | POST           | Inicia sesión y crea una cookie de sesión             |
| /logout                                     | DELETE         | Cierra la sesión actual del usuario                   |
| /up                                         | GET            | Ruta de verificación de estado (health check)         |
| /api/v1/admin/industries/reset_counts       | POST           | Reinicia los contadores de correos por industria      |
| /api/v1/templates                           | GET/POST       | Listar, crear templates de email                      |
| /api/v1/templates/:id                       | GET/PUT/DELETE | Ver, actualizar o eliminar un template                |
| /api/v1/me                                  | GET            | Devuelve los datos del usuario autenticado            |
| /api/v1/credit_account                      | GET            | Muestra los créditos disponibles del usuario          |
| /api/v1/credit_accounts/assign_initial      | POST           | Asigna créditos iniciales a un usuario                |
| /api/v1/credit_accounts/consume             | POST           | Descuenta créditos al enviar una campaña              |
| /api/v1/credit_accounts/consume_campaign    | POST           | Descuenta créditos por una campaña completa           |
| /api/v1/webhooks/aws_ses                    | POST           | Recibe webhooks de AWS SES                            |
| /api/v1/webhooks/aws_ses_tracking           | POST           | Recibe eventos de seguimiento de AWS SES              |
| /api/v1/support_requests                    | GET/POST       | Crea o lista solicitudes de soporte                   |
| /api/v1/support_requests/:id                | GET/PUT        | Ver o actualizar solicitud de soporte                 |
| /api/v1/industries                          | GET            | Lista todas las industrias                            |
| /api/v1/industries/:id                      | GET            | Muestra detalles de una industria                     |
| /api/v1/scrape                              | POST           | Inicia el scraping de una URL de empresa              |
| /api/v1/public_email_records                | GET/POST       | Lista o crea correos públicos scrapeados              |
| /api/v1/public_email_records/:id            | GET            | Muestra un correo público específico                  |
| /api/v1/public_email_records/by_industry    | GET            | Filtra correos por industria                          |
| /api/v1/public_email_records/by_region      | GET            | Filtra correos por región                             |
| /api/v1/public_email_records/search         | GET            | Busca correos con filtros avanzados                   |
| /api/v1/campaigns                           | GET/POST       | Lista o crea campañas de email                        |
| /api/v1/campaigns/:id                       | GET/PUT/DELETE | Ver, actualizar o eliminar una campaña                |
| /api/v1/campaigns/:id/stats                 | GET            | Muestra estadísticas de una campaña                   |
| /api/v1/campaigns/:id/send_campaign         | POST           | Envía una campaña                                     |
| /api/v1/campaigns/:id/cancel                | POST           | Cancela una campaña programada                        |
| /api/v1/transactions                        | GET/POST       | Lista o crea registros de transacciones               |
| /api/v1/email_logs                          | GET            | Lista registros de correos enviados                   |
| /api/v1/email_logs/:id                      | GET            | Muestra detalles de un envío de email                 |
| /api/v1/bounces                             | GET            | Lista rebotes de emails                               |
| /api/v1/bounces/:id                         | GET            | Muestra detalle de un rebote                          |
| /api/v1/emails/available_count/:industry_id | GET            | Muestra cuántos correos hay disponibles por industria |
| /api/v1/webhooks/:provider                  | POST           | Recibe webhooks de Stripe, MercadoPago, etc.          |



## ✅ Rutas clave para Testing Funcional

| Ruta                                     | Método   | Requiere Login   | ¿Qué probar?                                         |
|------------------------------------------|----------|------------------|------------------------------------------------------|
| /login                                   | POST     | ❌               | Login con credenciales válidas e inválidas           |
| /logout                                  | DELETE   | ✅               | Cerrar sesión y validar que la cookie se invalide    |
| /api/v1/me                               | GET      | ✅               | Obtener información del usuario autenticado          |
| /api/v1/credit_account                   | GET      | ✅               | Consultar los créditos disponibles del usuario       |
| /api/v1/credit_accounts/consume          | POST     | ✅               | Descontar créditos de forma manual                   |
| /api/v1/credit_accounts/consume_campaign | POST     | ✅               | Descontar créditos simulando una campaña             |
| /api/v1/scrape                           | POST     | ✅               | Iniciar scraping con una URL válida e inválida       |
| /api/v1/public_email_records             | GET      | ✅               | Listar correos scrapeados                            |
| /api/v1/public_email_records/search      | GET      | ✅               | Buscar correos por filtros (industria, ciudad, etc.) |
| /api/v1/industries                       | GET      | ❌               | Listar industrias disponibles (con o sin login)      |
| /api/v1/campaigns                        | POST     | ✅               | Crear una campaña de email                           |
| /api/v1/campaigns/:id/send_campaign      | POST     | ✅               | Enviar campaña y verificar consumo de créditos       |
| /api/v1/campaigns/:id/stats              | GET      | ✅               | Ver estadísticas de una campaña                      |
| /api/v1/admin/industries/reset_counts    | POST     | ✅ (admin)       | Recalcular contadores de emails por industria        |




Querés correr scraping masivo con: ProcessScrapeTargetsJob.perform_later




## 🌐 Gestión de Sitios Web para Scraping

MailerAction permite administrar un listado de sitios web desde los cuales se extraerán correos electrónicos públicos mediante el modelo `ScrapeTarget`.

### 🧱 Modelo `ScrapeTarget`

Este modelo actúa como cola de scraping. Los campos clave son:

| Campo            | Tipo      | Descripción                                      |
|------------------|-----------|--------------------------------------------------|
| `url`            | `string`  | Sitio web objetivo para scraping                |
| `status`         | `string`  | Estado del scraping (`pending`, `done`, `failed`) |
| `last_attempt_at`| `datetime`| Fecha del último intento de scraping            |

---

### 🚀 Formas de cargar sitios para scrapear

#### ✅ Opción 1: Seed inicial (`db/seeds.rb`)

Ideal para entorno local o pruebas iniciales:

                ```ruby
                [
                  "https://empresa1.cl",
                  "https://empresa2.cl",
                  "https://empresa3.cl"
                ].each do |url|
                  ScrapeTarget.find_or_create_by(url: url) do |t|
                    t.status = "pending"
                  end
                end

                bin/rails db:seed


Opción 2: Script personalizado (lib/scripts/import_scrape_targets.rb)
                Útil para cargas masivas desde archivos .txt o .csv:


                # lib/scripts/import_scrape_targets.rb
                urls = File.readlines(Rails.root.join("lib", "data", "urls.txt")).map(&:strip)

                urls.each do |url|
                  ScrapeTarget.find_or_create_by(url: url) do |t|
                    t.status = "pending"
                  end
                end

                bin/rails runner lib/scripts/import_scrape_targets.rb



Opción 3: Endpoint API
            Permite agregar sitios desde otras apps o un panel admin:

          POST /api/v1/scrape_targets
          Content-Type: application/json

          {
            "url": "https://empresa4.cl"
          } 

           Procesamiento automático
            Los sitios pendientes se procesan con el job:

            ProcessScrapeTargetsJob.perform_later

📌 Recomendación:

Usar seed o script para carga inicial

Usar el endpoint /scrape_targets para integraciones externas

Ejecutar el job periódicamente con Solid Queue



Scraping de Correos Públicos con DuckDuckGo

  MailerAction utiliza un servicio automatizado para buscar y extraer correos públicos desde sitios web chilenos a través de búsquedas avanzadas en DuckDuckGo.

  Proceso de Búsqueda
  Se realiza una búsqueda en DuckDuckGo con una query específica por industria:

    DuckDuckGoSearchScraperService.new("contacto@ logistica site:.cl", 1).scrape

  Esto busca sitios chilenos con correos visibles relacionados a la industria de logística.


  Se recorren los primeros resultados y se visita cada URL.

  En cada sitio web, se realiza scraping con Nokogiri para obtener la siguiente información:


## Campos extraídos por el Scraper de Correos Públicos

| Campo           | Tipo      | ¿Se obtiene automáticamente? | Fuente en el sitio web                                |
|------------------|-----------|------------------------------|------------------------------------------------------|
| email           | string    | ✅ Sí                        | Extraído desde enlaces mailto:                       |
| website         | string    | ✅ Sí                        | URL del sitio visitado desde DuckDuckGo              |
| company_name    | string    | ✅ Sí                        | Título de la página o etiqueta `<meta property="og:site_name">` |
| address         | string    | ⚠️ Parcial                   | Texto visible con patrones como “Av.”, “Calle”, etc. |
| municipality    | string    | ⚠️ Parcial                   | A través del contenido si se encuentra explícitamente |
| city            | string    | ⚠️ Parcial                   | Detectado por patrones de texto o ubicación          |
| country         | string    | ✅ Fijo                      | Siempre asignado como "Chile"                        |
| description     | text      | ✅ Sí                        | `<meta name="description">` o contenido del sitio    |
| industry_id     | integer   | ✅ Sí                        | Asignado automáticamente según el keyword de búsqueda |
| source_keyword  | string    | ✅ Sí                        | Palabra clave usada para buscar (ej. logistica, salud) |





## 🧠 Mejora automática de registros de correos públicos

MailerAction incluye un job llamado `EnhancePublicEmailRecordsJob` que **visita automáticamente los sitios web extraídos durante el scraping inicial**, con el objetivo de recolectar información faltante, como:

- Dirección (`address`)
- Ciudad (`city`)
- Comuna (`municipality`)
- Descripción (`description`)
- Nombre de empresa (`company_name`)

### 🛠 Cómo ejecutarlo manualmente

```bash
bin/rails runner 'EnhancePublicEmailRecordsJob.perform_now'









🔐 Acceso a Registros Públicos de Correos (PublicEmailRecord)
El acceso a la API de registros públicos de correos (/api/v1/public_email_records) está protegido por una política de autorización basada en roles, utilizando Pundit.

✅ Roles autorizados
Solo los siguientes roles tienen permiso para acceder a los registros públicos de correos:

admin

campaign_manager

designer

analyst

user

collaborator

Los roles con acceso limitado o de solo visualización como observer, usuario_prepago, colaborador_prepago y observador_prepago no tienen acceso a esta funcionalidad por defecto.

🧠 Lógica de autorización
Implementada en app/policies/public_email_record_policy.rb:

ruby
Copiar
Editar
class PublicEmailRecordPolicy < ApplicationPolicy
  def index?
    allowed_roles = %w[admin campaign_manager designer analyst user collaborator]
    allowed_roles.include?(user.role)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end








🔍 API: Buscar y Filtrar Correos Públicos
📥 Endpoint
bash
Copiar
Editar
GET /api/v1/public_email_records
✅ Requiere Autenticación
Sí. Solo roles autorizados pueden acceder. Ver acceso autorizado por roles.

🎯 Parámetros de Filtro Soportados
Parámetro	Tipo	Descripción
industry_id	Integer	Filtra por ID de industria
industry	String	Filtra por nombre de industria
city	String	Filtra por nombre de ciudad
status	String	Filtra por estado del correo: verified, unverified, rejected
page	Integer	Número de página (por defecto: 1)
per_page	Integer	Registros por página (máximo sugerido: 100)
🧪 Ejemplo de uso en Postman
📘 Headers
http
Copiar
Editar
Authorization: Bearer TU_TOKEN_AQUI
Content-Type: application/json
📗 Request
bash
Copiar
Editar
GET /api/v1/public_email_records?industry=Veterinarias&city=Santiago&status=verified&page=1&per_page=20
📙 Respuesta esperada
json
Copiar
Editar
{
  "public_email_records": [
    {
      "id": 123,
      "email": "info@clinicaveterinaria.cl",
      "company_name": "Clínica Veterinaria Santiago",
      "city": "Santiago",
      "status": "verified",
      "industry": {
        "id": 8,
        "name": "Veterinarias"
      }
    },
    ...
  ],
  "meta": {
    "page": 1,
    "per_page": 20,
    "total_pages": 3,
    "total_count": 45
  }
}
📄 Notas Técnicas
La paginación está implementada usando la gema kaminari.

Por defecto, solo se muestran correos con estado verified si no se especifica el parámetro status.

Si no se encuentra la industria o ciudad, se devuelve una lista vacía.









🔎 API: Búsqueda Rápida por Industria
📥 Endpoint
bash
Copiar
Editar
GET /api/v1/public_email_records/search
✅ Requiere Autenticación
Sí. Sólo accesible para usuarios autenticados.

🎯 Parámetros Requeridos
Parámetro	Tipo	Descripción
industry	String	Nombre exacto de la industria (como figura en /api/v1/industries)
limit	Integer	(Opcional) Número máximo de resultados a retornar (por defecto: 100)
🧪 Ejemplo de uso en Postman
📘 Headers
http
Copiar
Editar
Authorization: Bearer TU_TOKEN_AQUI
Content-Type: application/json
📗 Request
bash
Copiar
Editar
GET /api/v1/public_email_records/search?industry=Veterinarias&limit=10
📙 Respuesta esperada
json
Copiar
Editar
[
  {
    "id": 201,
    "email": "contacto@veterinariafeliz.cl",
    "company_name": "Veterinaria Feliz",
    "city": "Valparaíso",
    "status": "verified",
    "industry_id": 8,
    "website": "https://veterinariafeliz.cl"
  },
  ...
]
💡 Consideraciones
Este endpoint es útil para integraciones rápidas o pruebas.

No incluye paginación ni estructura de meta.

Solo devuelve registros cuya industria coincide exactamente con el nombre enviado.

La cantidad máxima de resultados puede ser limitada para evitar cargas innecesarias al sistema.










🔎 API: Búsqueda Rápida por Industria
📥 Endpoint
bash
Copiar
Editar
GET /api/v1/public_email_records/search
✅ Requiere Autenticación
Sí. Sólo accesible para usuarios autenticados con token válido.

🎯 Parámetros
Parámetro	Tipo	Requerido	Descripción
industry	String	✅	Nombre exacto de la industria (según /api/v1/industries)
limit	Integer	❌	Cantidad máxima de resultados. Por defecto: 100
📘 Headers Requeridos
pgsql
Copiar
Editar
Authorization: Bearer TU_TOKEN_AQUI
Content-Type: application/json
🧪 Ejemplo de uso en Postman
bash
Copiar
Editar
GET /api/v1/public_email_records/search?industry=Veterinarias&limit=10
📟 Ejemplo con cURL
bash
Copiar
Editar
curl -X GET "https://maileraction.com/api/v1/public_email_records/search?industry=Veterinarias&limit=10" \
  -H "Authorization: Bearer TU_TOKEN_AQUI" \
  -H "Content-Type: application/json"
📦 Respuesta esperada
json
Copiar
Editar
[
  {
    "id": 201,
    "email": "info@veterinariafeliz.cl",
    "company_name": "Veterinaria Feliz",
    "address": "Av. Los Leones 456",
    "city": "Santiago",
    "municipality": "Providencia",
    "country": "Chile",
    "description": "Clínica veterinaria para mascotas",
    "industry_id": 8,
    "website": "https://veterinariafeliz.cl",
    "status": "verified"
  },
  ...
]
💡 Notas importantes
Sólo se incluyen registros verificados (status: "verified").

Si el nombre de la industria no coincide, se retorna un mensaje de error.

Los correos electrónicos no se muestran directamente para proteger la plataforma.

El industry_id puede ser usado para búsquedas más avanzadas en otros endpoints.

🤖 Sugerencias para Integraciones Externas
Plataforma / Cliente	Recomendación de uso
Python (requests)	Usa el header Authorization y convierte la respuesta con .json()
JavaScript (Axios)	Ideal para integrar en apps React/Vue que consumen esta API
Zapier / Make	Configura un Webhook con método GET y headers personalizados
PostgREST / Supabase	Puedes construir wrappers si necesitas integraciones SQL-like



*******************INTEGRACIONES *************************************************



🔗 Ruby (con net/http)
ruby
Copiar
Editar
require 'net/http'
require 'json'
require 'uri'

uri = URI("https://maileraction.com/api/v1/public_email_records/search?industry=Veterinarias&limit=10")
req = Net::HTTP::Get.new(uri)
req["Authorization"] = "Bearer TU_TOKEN_AQUI"

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(req)
end

puts JSON.pretty_generate(JSON.parse(res.body))
🐍 Python (con requests)
python
Copiar
Editar
import requests

headers = {
    "Authorization": "Bearer TU_TOKEN_AQUI",
    "Content-Type": "application/json"
}

response = requests.get(
    "https://maileraction.com/api/v1/public_email_records/search?industry=Veterinarias&limit=10",
    headers=headers
)

print(response.json())
🅰️ Angular (con HttpClient)
typescript
Copiar
Editar
this.http.get('/api/v1/public_email_records/search', {
  params: { industry: 'Veterinarias', limit: '10' },
  headers: { Authorization: 'Bearer TU_TOKEN_AQUI' }
}).subscribe({
  next: data => console.log(data),
  error: err => console.error(err)
});
⚛️ React (con axios)
jsx
Copiar
Editar
import axios from 'axios';

axios.get('https://maileraction.com/api/v1/public_email_records/search', {
  params: {
    industry: 'Veterinarias',
    limit: 10
  },
  headers: {
    Authorization: 'Bearer TU_TOKEN_AQUI'
  }
}).then(response => {
  console.log(response.data);
}).catch(error => {
  console.error(error);
});
🐘 PHP (con curl)
php
Copiar
Editar
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, "https://maileraction.com/api/v1/public_email_records/search?industry=Veterinarias&limit=10");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "Authorization: Bearer TU_TOKEN_AQUI",
    "Content-Type: application/json"
]);

$response = curl_exec($ch);
curl_close($ch);

$data = json_decode($response, true);
print_r($data);
🌐 Node.js (con axios)
javascript
Copiar
Editar
const axios = require('axios');

axios.get('https://maileraction.com/api/v1/public_email_records/search', {
  params: { industry: 'Veterinarias', limit: 10 },
  headers: { Authorization: 'Bearer TU_TOKEN_AQUI' }
}).then(response => {
  console.log(response.data);
}).catch(error => {
  console.error(error.response.data);
});










