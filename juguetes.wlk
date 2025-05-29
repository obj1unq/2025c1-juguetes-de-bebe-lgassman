/** Agregar las clases y objetos*/

class Color {
    method aplicaImpuestoRosa() {
        return false
    }
}
object rosa inherits Color{
    override method aplicaImpuestoRosa() {
        return true
    }
}
object azul inherits Color{}

object cuv {
    var property valor = 2
}
class Pieza {
    const property volumen
    const color

    method costo() {
        return volumen * cuv.valor()
    }

    method eficacia() {
        return self.volumen()
    }
    
    method aplicaImpuestoRosa() {
        return color.aplicaImpuestoRosa()
    }

} 

class Juguete {

    method precio() {
        return (self.eficacia() * 10) + self.costo()
    }
    method eficacia()
    method costo()

}

class JugueteDePiezas inherits Juguete {

    const piezas 

    override method costo() {
        return self.costoFijo() + (piezas.size() * self.costoPiezaMayorVolumen())
    }

    method costoPiezaMayorVolumen() {
        return piezas.max({ pieza => pieza.volumen()}).costo()
    }

    method costoFijo()

    override method precio() {
        return super() + self.impuestoRosa()
    }

    method impuestoRosa() {
        return if (self.hayPiezaRosa()) { 20 } else { 0 }
    }

    method hayPiezaRosa() {
        return piezas.any({pieza => pieza.aplicaImpuestoRosa() })
    }

}

class Baldecito inherits JugueteDePiezas {
    override method costoFijo() {
        return 5
    }
    
    override method eficacia() {
        return 3 * piezas.size()
    }
}

class Tachitos inherits JugueteDePiezas {

    override method costoFijo() {
        return 3
    }

    override method eficacia() {
        return piezas.sum({pieza => pieza.eficacia()})
    }

}

class Pelota inherits Juguete {
    const radio

    override method costo() {
        return 3 * radio * cuv.valor()
    }

    override method eficacia() {
        return 12
    }
}

class Niñe {

    var property edad 
    const property juguetes = #{}

    method entretenimiento(juguete) {
        return self.eficaciaJuguete(juguete) *  (1 + (edad / 100))
    }

    method eficaciaJuguete(juguete) {
        return juguete.eficacia()
    }

    method recibir(juguete) {
        self.validarRecibir(juguete)
        juguetes.add(juguete)
    }

    method validarRecibir(juguete) {
        if (not self.acepta(juguete)) {
            self.error("No me gusta este " + juguete)
        }
    }
    method acepta(juguete) {
        return true
    }

    method recibirDonacion(donante) {
        self.validarDonacion(donante)
        const juguetesDonables = self.juguetesDonables(donante)
        juguetes.addAll(juguetesDonables)
        donante.removerJuguetes(juguetesDonables)
    }
    
    method removerJuguetes(_juguetes) {
        juguetes.removeAll(_juguetes)
    }

    method validarDonacion(donante) {
        if (not self.aceptaAlgun(donante.juguetes())) {
            self.error("No me gusta nada de " + donante )
        }
    }

    method juguetesDonables(donante) {
        return donante.juguetes().filter({juguete => self.acepta(juguete)})
    }

    method aceptaAlgun(juguetesDonables) {
        return juguetesDonables.any({juguete => self.acepta(juguete)})
    }

    // method donar(receptor) {
    //     self.validarDonar(receptor)
    // }

    // method validarDonar(receptor) {
    //     if (not receptor.aceptaAlgun(self.juguetes())) {
    //          self.error("A " + receptor + "No le gustan nada de " + self.juguetes() )
    //     }
    // }
}

class Curiose inherits Niñe {
    
    override method entretenimiento(juguete) {
        return super(juguete) * 1.5
    }

    override method acepta(juguete) {
        return juguete.precio() < 150
    }

}

class Revoltose inherits Niñe {
    
    override method eficaciaJuguete(juguete) {
        return super(juguete) / 2
    }

    override method acepta(juguete) {
        return self.entretenimiento(juguete) > 7
    }

}