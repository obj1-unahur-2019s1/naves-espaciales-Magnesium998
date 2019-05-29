class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0	
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000).max(0) }
	method desacelerar(cuanto) { velocidad -= cuanto }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	
	method cargarCombustible(litros) {combustible += litros}
	method descargarCombustible(litros) {combustible -= litros}
	
	method prepararViaje() {self.cargarCombustible(3000) ; self.acelerar(5000)}
}

class NaveBaliza inherits NaveEspacial{
	const rojo = "Rojo"
	const verde = "Verde"
	const azul = "Azul"
	
	method cambiarColorDeBaliza(colorNuevo) = colorNuevo
	
	override method prepararViaje() {super() ; self.cambiarColorDeBaliza(verde)
									 self.ponerseParaleloAlSol()}
}

class NavePasajeros inherits NaveEspacial{
	var property racionesDeComida
	var property racionesDeBebida
	var property pasajeros 
	
	method cargarComida(numero) {racionesDeComida += numero}
	method descargarComda(numero) {racionesDeComida -= numero}
	method cargarBebida(numero) {racionesDeBebida += numero}
	method descargarBebida(numero) {racionesDeBebida -= numero}
	
	override method prepararViaje() {super() ; self.cargarComida(pasajeros*4)
									 self.cargarBebida(pasajeros*6) ; self.acercarseUnPocoAlSol()}
}

class NaveDeCombate inherits NaveEspacial{
	var property visible
	var property misiles
	var property mensajes = []
	
	method ponerseVisible() {visible = true}
	method ponerseInvisible() {visible = false}
	method estaInvisible() = visible
	
	method desplegarMisiles() {misiles = true}
	method replegarMisiles() {misiles = false}
	method misilesDespegados() = misiles
	
	method emitirMensaje(mensaje) {mensajes.add(mensaje)}
	method mensajesEmitidos() = mensajes.size()
	method primerMensajeEmitido() = mensajes.first()
	method ultimoMensajeEmitido() = mensajes.last()
	method esEscueta() {}
	method emitioMensaje(mensaje) = mensajes.any(mensaje)
	
	override method prepararViaje() {super() ; self.ponerseVisible()
									self.desplegarMisiles() ; self.acelerar(1500) ; self.emitirMensaje("Saliendo en mision") }
}