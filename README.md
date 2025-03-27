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
