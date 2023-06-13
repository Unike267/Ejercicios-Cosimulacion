# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN
---
---

- **Universidad**: UPV-EHU.
- **Master**: Sistemas electronicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---
---

### Resumen:

Se propone un ejercicio y un proyecto de asignatura. El objetivo en ambos casos consistirá en testear un componente de la arquitectura digital que implementa un MPPT realizada para el TFG, en concreto el [[decodificador de estados](https://github.com/Unike267/MPPT/blob/main/LAZO_ABIERTO_SIMULACION/decoder.v)].

Cuya tabla de verdad es la siguiente:
![Tabla de verdad](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/STATE%20DECODER%20TABLE.png)

Para ello se procede de la siguiente manera:

- **Ejercicio:**
    + Se rescribe el componente de verilog a VHDL.
    + Se realiza un test bench para comprobar sus resultados acorde a la tabla de verdad mostrada.
    + Se realiza otro test bench para implementarlo de forma autmatizada mediante [[VUnit](https://github.com/VUnit/vunit)].
    + **NOTA:** para analizar y eleborar los resultados se utiliza [[GHDL](https://github.com/ghdl/ghdl)].

- **Proyecto:**
    + Se realiza otro test bench junto a un programa en C para [[co-simular](https://github.com/ghdl/ghdl-cosim)] el test utilizando GHDL, unidos mediante el "puente" [[VHPIDIRECT](https://vunit.github.io/cosim/bridges/vhpidirect.html#)].
    + **NOTA:** Para que GHDL soporte la compilación cruzada se ha de tener instalados los paquetes "clang" y "llvm-dev" y a la hora de instalar el GHDL al configure se le ha de añadir como argumento "--with-llvm-config".

- **Extra:** Se realizan dos ejercicios extra.
    + En el primero se sintetizará el decodificador de estados en la FPGA y se comprobará su funcionamiento.
    + En el segundo se diseñará, simulará y sintetizará una arquitectura con objeto de ensayar el protocolo **AXI Stream**.

