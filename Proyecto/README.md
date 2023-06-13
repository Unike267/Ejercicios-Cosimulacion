# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN
---
---

- **Universidad**: UPV-EHU.
- **Master**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---
---

### Proyecto:

Para este proyecto se co-simulará el test bench corriendo de forma simultánea VHDL y C. Para ello se hará uso del puente [[VHPIDIRECT](https://vunit.github.io/cosim/bridges/vhpidirect.html#)].

El objetivo es analizar en un test bench las 32 posibles iteraciones de entrada que puede tener el componente "decodificador de estados" previamente diseñado, mediante un for en VHDL. Desde dicho bucle se llamará a dos funciones en C que aportan las 32 posibles entradas. Estado actual de 3 bits y flags de 2 bits. Dichas entradas se asignarán a las señales de entrada del componente. Por otro lado, desde el mismo bucle se llamarán mediante tres funciones en C a los resultados que se han de obtener a la salida del decodificador de estados. Estado siguiente de 3 bits, enables de 4 bits y rst_ci de 1 bit. Los resultados de estas funciones se aplicarán en un assert para comprobar que los valores obtenidos son correctos.

Para generar el archivo en C, tanto las funciones de las entradas como las de las salidas se han generado a partir de la tabla de verdad mostrada en la carpeta anterior.

Cabe destacar que en dichas funciones el argumento de entrada y de salida son integers, por lo que se habrá de acomodar a std_logic_vector, que es el tipo de dato utilizado para describir la arquitectura en VHDL. Además, se comenzó haciendo uso de señales intermedias tipo signal para guardar los resultados de las funciones. De esta manera no funcionaba correctamente, ya que guardaba el dato de la iteración anterior y en la primera iteración guardaba el estado 'U' a los std_logic. Por lo que se llegó a la conclusión que para guardar los resultados de las funciones se han de utilizar variables en lugar de signals.

Se muestra en el archivo run.sh los pasos a realizar para analizar, elaborar y correr el diseño.

### Resultado:

Se consigue un resultado de cosimulación correcto.


