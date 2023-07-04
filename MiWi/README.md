# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN
---
---

- **Universidad**: UPV-EHU.
- **Máster**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---
---

### Miwi:

Miwi es un escritor de texto plano descrito íntegramente en **VHDL**.

## Interfaz:

La interfaz que soporta MiWi es la siguiente:

- **Pantalla:** Nokia 5110, PCD8544 controller/driver. [[DataSheet](https://github.com/EleonoreMizo/pedalevite/blob/master/doc/datasheets/Philips%20PCD8544%20-%20IC%2C%2048x84%20pixels%20matrix%20LCD%20controller%20(Nokia%205110).pdf)]

- **Teclado:** Teclado matricial 4 x 4.

- **FPGA:** ICE 40 (Lattice), placa Alhambra II.

## Esquema de montaje:

El esquema de montaje es el siguiente:

![Esquema de montaje](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/ESQUEMA_MONTAJE.png)

## Diseño:

Se muestra un esquema simplificado del diseño:

![Esquema de diseño](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/ESQUEMA_DISE%C3%91O.png)

## Limitaciones:

Caracteres soportados (6 x 8 pixeles por letra):

![Caracteres soportados](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/CARACTERES.png)

Distribuidos en el teclado de la siguiente manera:

![teclado](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/TECLADO.png)

Pantalla: debido a varias limitaciones, en concreto a las LUTs disponibles en la ICE 40 (el diseño ocupa 6429 de 7680) el número de caracteres imprimibles son 7. Es decir, **solo se escribe una de las seis lineas de la pantalla** (8 x 84 pixeles por linea). No obstante, al introducir el siguiente carácter después del séptimo se reinicia al estado inicial y se vuelve a poder escribir otros 7 caracteres. 

Esto es debido a que al extender la longitud del puntero que se modifica al escribir un carácter, véase [[screen.vhd](https://github.com/Unike267/Ejercicios-Cosimulacion/blob/main/MiWi/Top/screen.vhd)], con objeto de escribir toda la pantalla, se multiplica el número de LUTs necesarias superando las 7680.

## Demo:

Se muestra una demo de funcionamiento en el siguiente [[video](https://www.youtube.com/watch?v=qeRFKENe8lA)].
