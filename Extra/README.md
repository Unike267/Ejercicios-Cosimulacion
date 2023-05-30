# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN
---
---

- **Universidad**: UPV-EHU.
- **Master**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---
---

### Extra:

Una vez simulados y co-simulados los test bench de forma correcta, se propone un ejercicio extra. Este consistirá en sintetizar en la FPGA ICE-40 de LATTICE (placa Alhambra II) el decodificador de estados descrito en VHDL. Para ello, se utilizará el sintetizador [[yosys](https://github.com/YosysHQ/yosys)] y mediante el [[ghdl-yosys-plugin](https://github.com/ghdl/ghdl-yosys-plugin)] se añadirá el GHDL como módulo, pudiendo así sintetizar VHDL con yosys.
Se realizará un top del diseño, que introducirá mediante un contador de 5 bits pre-escaldo las 32 posibles entradas al decodificador de estados. También, asignará las 8 salidas a los 8 leds de la placa, comprobando así la funcionalidad del componente. Como se puede apreciar en el siguiente gif:

![flujo del state decoder](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/state_decoder.gif)

Se muestra en el archivo run.sh los pasos a realizar para analizar, sintetizar, hacer el place and route, generar el bitstream y cargarlo a la placa.


