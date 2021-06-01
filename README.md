# Ecommerce PayPal

Ecommerce creado en Rails con PayPal como pasarela de pago.

El proyecto consiste en un Ecommerce básico, con autenticación de usuario y proceso de pago utilizando PayPal, además, permite ver gráficos con la distribución de productos.

## Dependencias

* Chartkick
* Highcharts
* ActiveMerchant
* RSpec

Se ha utilizado ActiveMerchant para el manejo de los pagos, en reemplazo de paypal-sdk, el cual ya no tiene soporte y no cuenta con certificados SSL actualizados, aunque es posible editar los SSL existentes para realizar la actualización.

Se han añadido test en modelos y controladores para las funcionalidades básicas utilizando RSpec.

## Puesta en marcha

1. Clona este repositorio
2. Instala las dependencias con `bundle install` y `yarn install` 
3. Crea la base de datos con `rails db:setup`
4. Levanta el servidor con `rails s`

## Testing

Para ejecutar los test, puedes ejecutar en el terminal `rspec ruta_del_test`, donde "ruta_del_test" es la ruta del test a ejecutar, ejemplo: 
`rspec spec/user_spec.rb`