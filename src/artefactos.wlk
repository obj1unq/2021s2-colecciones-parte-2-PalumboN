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

