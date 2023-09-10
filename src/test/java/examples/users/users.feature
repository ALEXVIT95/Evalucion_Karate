Feature: Evaluacion de QA    
  
#Variables globales para los escenarios de
Background:
* url 'https://petstore.swagger.io/v2'
* def username = 'alexvit'
Scenario: crear y buscar usuario 
#Definimos la trama del JSON en una variable
    * def user =
  """
  {
    "id": 0,
    "username": "alexvit",
    "firstName": "Alejandro",
    "lastName": "Viteri",
    "email": "correo@prueba.com",
    "password": "password",
    "phone": "0963933465",
    "userStatus": 0
  }
  """
#Pocedemos a construir el ecenario de prueba para el POST
  Given path 'user'
  And request user
  When method Post
  Then status 200

  * def message = response.message
  * print 'created message is: ' + message
  
#Validamos que se haya hecho el POST exitosamente
  Given path 'user'
  And path user.username
  When method get
  Then status 200



Scenario: actualizar y buscar usuario
#Aquí  obtendremos el id y lo almacenamos en una variable para utilizarlo en la trama del json que vamos a usar en metodo PUT
  Given path 'user'
  And path username
  When method get
  Then status 200
  * def id = response.id
  * print 'el id es ' + id
# Definimos la trama para el metodo put y utilizamos la variable donde guardamos el id
  * def usernew =
  """
  {
    "id": #(id),
    "username": "alexvit",
    "firstName": "Rodrigo",
    "lastName": "Viteri",
    "email": "correo@cambio.com",
    "password": "password",
    "phone": "0963933465",
    "userStatus": 0
  }
  """
#Pocedemos a construir el ecenario de prueba para el PUT
  Given path 'user'
  And path username
  And request usernew
  When method put
  Then status 200

#Validamos que se haya hecho el PUT exitosamente
  Given path 'user'
  And path username
  When method get
  Then status 200
  And match response.firstName == 'Rodrigo'
  And match response.email == 'correo@cambio.com'

Scenario: eliminar usuario
#Aquí  obtendremos el username y lo almacenamos en una variable para utilizarlo en PATH que vamos a usar en metodo DELETE
  Given path 'user'
  And path username
  When method get
  Then status 200
  * def usname = response.username
#Pocedemos a construir el ecenario de prueba para el DELETE  
  Given path 'user'
  And path usname
  When method delete
  Then status 200
#Validamos que se haya hecho el DELETE exitosamente
  Given path 'user'
  And path username
  When method get
  Then status 404