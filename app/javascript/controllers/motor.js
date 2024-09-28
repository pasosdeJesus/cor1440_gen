
export default class Cor1440Gen__Motor {
  /* 
   * Librería de funciones comunes.
   * Aunque no es un controlador lo dejamos dentro del directorio
   * controllers para aprovechar método de msip para compartir controladores
   * Stimulus de motores.
   *
   * Como su nombre no termina en _controller no será incluido en 
   * controllers/index.js
   *
   * Desde controladores stimulus importelo con
   *
   *  import Cor1440Gen__Motor from "../cor1440_gen/motor"
   *
   * Use funciones por ejemplo con
   *
   *  Cor1440Gen__Motor.ejecutarAlCargarPagina()
   *
   * Para poderlo usar desde Javascript global con window.Cor1440Gen__Motor 
   * asegure que en app/javascript/application.js ejecuta:
   *
   * import Cor1440Gen__Motor from './controllers/cor1440_gen/motor.js'
   * window.Cor1440Gen__Motor = Cor1440Gen__Motor
   *
   */


  // Se ejecuta cada vez que se carga una página que no está en cache
  // y tipicamente después de que se ha cargado la página y los recursos.
  static ejecutarAlCargarDocumentoYRecursos() {
    console.log("* Corriendo Cor1440Gen__Motor::ejecutarAlCargarDocumentoYRecursos()")
  }

  // Llamar cada vez que se cargue una página detectada con turbo:load
  // Tal vez en cache por lo que podría no haberse ejecutado iniciar 
  // nuevamente.
  // Podría ser llamada varias veces consecutivas por lo que debe detectarlo
  // para no ejecutar dos veces lo que no conviene.
  static ejecutarAlCargarPagina() {
    console.log("* Corriendo Cor1440Gen__Motor::ejecutarAlCargarPagina()")
  }


  // Se ejecuta desde app/javascript/application.js tras importar el motor
  static iniciar() {
    console.log("* Corriendo Cor1440Gen__Motor::iniciar()")
  }

}
