# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN: Ejercicio

- **Universidad**: UPV-EHU.
- **Máster**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---

El esquema del componente que se rescribirá de verilog a VHDL es el siguiente:

![Esquema](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/STATE%20DECODER%20LOGIC.png)

Se analiza y elabora de forma correcta utilizando GHDL.

## Test bench automatizado mediante [[VUnit](https://github.com/VUnit/vunit)]:

En `tb_state_decoder_vunit.vhd` se automatiza el test bench mediante VUnit.
Para ello se modifica el test bench añadiendo las lineas de código necesarias y se genera un archivo en python para ejecutarlo.

### Resultado:

Se observa que el test pasa la prueba.

![Esquema](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/Captura%20de%20pantalla%20de%202023-05-02%2003-37-54.png)

**Nota:** si se modifica algun resultado en el assert del test bench, se imprimirá el error donde a fallado el ensayo.
