// Requerimiento: Hacer que Rolando luche una batalla
// rolando.batallar() 	[acción]
//  -> artefacto.usar() [acción]

// Requerimiento: Saber el poder de pelea de Rolando
// rolando.poderDePelea()	[consulta -> Número]
//  -> artefacto.poderDePeleaQueAportaA(portador) [consulta -> Número]

// Requerimiento: Saber los enemigos que puede vencer Rolando
// erethia.enemigosQuePuedeVencer(rolando)	[consulta -> Colección de enemigos]

// Requerimiento: Saber las moradas conquistables para Rolando
// erethia.moradasConquistables(rolando)	[consulta -> Colección de moradas]

// Requerimiento: Saber Rolando es poderoso
// erethia.esPoderoso(rolando)	[consulta -> Booleano]


object espada {

	var fueUsada = false

	method usar() {
		fueUsada = true
	}

	method poderDePeleaQueAportaA(portador) {
		return portador.poderBase() * self.indicePorUso()
	}

	method indicePorUso() {
		return if (fueUsada) 0.5 else 1
	}

}

object collar {

	var batallasUsado = 0

	method usar() {
		batallasUsado += 1
	}

	method poderDePeleaQueAportaA(portador) {
		return 3 + self.poderExtra(portador)
	}
	
	method poderExtra(portador) {
		return if (portador.poderBase() > 6) {
			batallasUsado
		} else {
			0
		}
	}
}

object armadura {

	method usar() {
	// No hace nada, debe entender el mensaje por polimorfismo
	}
	
	method poderDePeleaQueAportaA(portador) {
		return 6 
	}
}

object libro {
	
	var property hechizos = [bendicion, invisibilidad, invocacion]

	method usar() {
		hechizos.remove(self.hechizoActual())
	}
	
	method poderDePeleaQueAportaA(portador) {
		if (not self.hayHechizos()) {
			return 0
		}
		return self.hechizoActual().poderQueAporta(portador)
	}
	
	method hechizoActual() {
		return hechizos.head()
	}
	method hayHechizos() {
		return hechizos.size() > 0 
	}

}

object bendicion {
	method poderQueAporta(portador) {
		return 4
	}
}
object invisibilidad {
	method poderQueAporta(portador) {
		return portador.poderBase()
	}
}
object invocacion {
	method poderQueAporta(portador) {
		const artefacto = portador.artefactoMasPoderosoDeLaCasa() 
		return artefacto.poderDePeleaQueAportaA(portador)
	}
}




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

}

// ENEMIGOS
object erethia {
	const property enemigos = #{archibaldo, caterina, astra}
	
	method enemigosQuePuedeVencer(heroe) {
		return enemigos.filter({ unEnemigo =>
			self.vence(heroe, unEnemigo)
		})
	}
	
	method moradasConquistables(heroe) {
		return self.enemigosQuePuedeVencer(heroe).map({ unEnemigo => unEnemigo.morada() }).asSet()
	}
	
	method esPoderoso(heroe) {
		return enemigos.all({ unEnemigo =>
			self.vence(heroe, unEnemigo)
		})
	}
	
	//TODO: Mover a Rolando
	method vence(heroe, enemigo) {
		return enemigo.poderDePelea() < heroe.poderDePelea()
	}
}

object archibaldo {
	const property morada = palacioDeMarmol
	const property poderDePelea = 16
}

object caterina {
	const property morada = fortalezaDeAcero	
	const property poderDePelea = 28
}

object astra {
	const property morada = torreDeMarfil	
	const property poderDePelea = 14
}

object palacioDeMarmol {	
}
object fortalezaDeAcero {	
}
object torreDeMarfil {	
}