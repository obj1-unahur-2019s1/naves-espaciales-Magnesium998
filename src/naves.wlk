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
	
	method prepararViaje() {self.cargarCombustible(30000) ; self.acelerar(5000)}
	
	method estaTranquila() = (combustible >= 4000) and (velocidad <= 12000)
}

class NaveBaliza inherits NaveEspacial{
	var color = "Verde"
	
	method cambiarColorDeBaliza(colorNuevo) {color = colorNuevo}
	
	override method prepararViaje() {super() ; self.cambiarColorDeBaliza("Verde")
									 self.ponerseParaleloAlSol()}
									 
	method recibirAmenaza() {self.irHaciaElSol() ; self.cambiarColorDeBaliza("Rojo")}
	
	override method estaTranquila() = super() and (color != "Rojo")
}

class NavePasajeros inherits NaveEspacial{
	var property racionesDeComida
	var property racionesDeBebida
	var property pasajeros 
	
	method cargarComida(numero) {racionesDeComida += numero}
	method descargarComida(numero) {racionesDeComida -= numero}
	method cargarBebida(numero) {racionesDeBebida += numero}
	method descargarBebida(numero) {racionesDeBebida -= numero}
	
	override method prepararViaje() {super() ; self.cargarComida(pasajeros*4)
									 self.cargarBebida(pasajeros*6) ; self.acercarseUnPocoAlSol()}
	
	method recibirAmenaza() {self.velocidad(velocidad*2) ; self.descargarComida(pasajeros)
							 self.descargarBebida(pasajeros*2) }
}

class NaveDeCombate inherits NaveEspacial{
	var visible
	var misiles
	var mensajes = []
	
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
	method esEscueta() = mensajes.all{m => m.size() <= 30} 
	method emitioMensaje(mensaje) = mensajes.contains(mensaje)
	
	override method prepararViaje() {super() ; self.ponerseVisible()
		                             self.acelerar(15000) ; self.desplegarMisiles()
									 self.emitirMensaje("Saliendo en mision")}
	
	method recibirAmenaza() {self.acercarseUnPocoAlSol() ; self.acercarseUnPocoAlSol()
							 self.emitirMensaje("Amenaza Recibida")	}
	
	override method estaTranquila() = super() and (not misiles)
}


class NaveHospital inherits NavePasajeros {
	var quirofanos
	
	method quirofanosRegistrados() = quirofanos
	override method recibirAmenaza() {super() ; quirofanos = true}
	
	override method estaTranquila() = super() and (not quirofanos)
}

class NaveCombateSigilosa inherits NaveDeCombate {
	override method recibirAmenaza() {super() ; self.desplegarMisiles()
									  self.ponerseInvisible()}
	override method estaTranquila() = super() and visible
}