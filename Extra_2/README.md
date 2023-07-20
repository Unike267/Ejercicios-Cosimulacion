# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN: Extra 2

- **Universidad**: UPV-EHU.
- **Máster**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---

Se propone un segundo ejercicio extra. En el se diseñará, simulará y sintetizará una pequeña arquitectura digital que realice lo siguiente:

- Obtener dos datos desde el switch 1 de la placa. Para ello se dispondrá de 10 segundos para introducir el primero y otros 10 para el segundo. El número de pulsaciones al switch será el dato introducido. El intervalo del dato irá de 0 a 15 (4 bits).

- A medida que se complete cada dato se escribirá en una fifo.

- Una vez pasados los 20 segundos, se comunicarán los datos introducidos mediante el protocolo **AXI-Stream**. Desde la fifo ubicada en el master a dos registros ubicados en el slave. La comunicación se hará en dos paquetes de 4 bits. Los registros del slave se enlazarán a los 8 leds de la placa, pudiendo así visualizar el resultado.

- Se podrá reiniciar el proceso reseteando el diseño desde el switch 2 de la placa.

Se ejemplifica la arquitectura mediante la siguiente imagen:

![Diseño simplificado](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/PLANO.png)


## Test

Se muestra en simulación el procedimiento del diseño:

![Simulación 1](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/Input_data.png)

Se demuestra mediante la siguiente imagen que la comunicación sigue el protocolo **AXI-Stream**. Ya que cuando *tvalid* y *tready* están en alto el bus *tdata* varía cada periodo de reloj.

![Simulación 2](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/Axi_stream_communication.png)

- **NOTA:** Para realizar el test bench se reducen los tiempos del diseño con objeto de acelerar la simulación.


## Síntesis del diseño:

Se sintetiza el diseño en VHDL en la FPGA ICE 40 de Lattice (placa Alhambra II) mediante [[yosys](https://github.com/YosysHQ/yosys)] con el plugin [[ghdl-yosys-plugin](https://github.com/ghdl/ghdl-yosys-plugin)].

Se muestra una demo de funcionamiento en el siguiente [[video](https://www.youtube.com/watch?v=B9bsUBxZJLg&t=1s)].
