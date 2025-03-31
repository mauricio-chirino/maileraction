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
