// Requerimiento: Hacer que Rolando luche una batalla
// rolando.batallar() 	[acción]
//  -> artefacto.usar() [acción]

// Requerimiento: Saber el poder de pelea de Rolando
// rolando.poderDePelea()	[consulta -> Número]
//  -> artefacto.poderDePeleaQueAportaA(portador) [consulta -> Número]


object castillo {

	const property artefactos = #{}

	method agregarArtefactos(_artefactos) {
		artefactos.addAll(_artefactos)
	}

	method artefactoMasPoderosoPara(portador) {
		return artefactos.max(
			// Bloque
			{ unArtefacto => 
				unArtefacto.poderDePeleaQueAportaA(portador)
			} 
		)
	}
}

object rolando {

	const property artefactos = #{} // Set
	var property capacidad = 2
	const casa = castillo
	const property historia = [] // Lista
	var property poderBase = 5

	method batallar() {
		self.utilizarArtefactos()
		self.incrementarPoderBase(1)
	}

	method poderDePelea() {
		return poderBase + self.poderDePeleaDeLosArtefactos()
	}

	method encontrar(artefacto) {
		if (artefactos.size() < capacidad) {
			artefactos.add(artefacto)
		}
		historia.add(artefacto)
	}

	method volverACasa() {
		casa.agregarArtefactos(artefactos)
		artefactos.clear()
	}

	method posesiones() {
		return self.artefactos() + casa.artefactos()
	}

	method posee(artefacto) {
		return self.posesiones().contains(artefacto)
	}

	method incrementarPoderBase(cantidad) {
		poderBase += cantidad
	}

	method utilizarArtefactos() {
		// Usar los artefactos polimórficamente
		// Mandarles a todos los artefactos de la colección el mensaje `usar()`
		artefactos.forEach({ unArtefacto => unArtefacto.usar() })
	}

	method poderDePeleaDeLosArtefactos() {
		const poderes = artefactos.map({ unArtefacto => unArtefacto.poderDePeleaQueAportaA(self) })
		return poderes.sum()
	}
	
	method artefactoMasPoderosoDeLaCasa() {
		return casa.artefactoMasPoderosoPara(self)
	}
	
	method puedeVencer(enemigo) {
		return enemigo.poderDePelea() < self.poderDePelea()
	}

}

