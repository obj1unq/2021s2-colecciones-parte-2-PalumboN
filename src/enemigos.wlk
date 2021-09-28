// Requerimiento: Saber los enemigos que puede vencer Rolando
// erethia.enemigosQuePuedeVencer(rolando)	[consulta -> Colección de enemigos]

// Requerimiento: Saber las moradas conquistables para Rolando
// erethia.moradasConquistables(rolando)	[consulta -> Colección de moradas]

// Requerimiento: Saber Rolando es poderoso
// erethia.esPoderoso(rolando)	[consulta -> Booleano]


object erethia {
	const property enemigos = #{archibaldo, caterina, astra}
	
	method enemigosQuePuedeVencer(heroe) {
		return enemigos.filter({ unEnemigo =>
			heroe.puedeVencer(unEnemigo)
		})
	}
	
	method moradasConquistables(heroe) {
		return self.enemigosQuePuedeVencer(heroe).map({ unEnemigo => unEnemigo.morada() }).asSet()
	}
	
	method esPoderoso(heroe) {
		return enemigos.all({ unEnemigo =>
			heroe.puedeVencer(unEnemigo)
		})
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