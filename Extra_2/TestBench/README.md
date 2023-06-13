# [[Unike267](https://github.com/Unike267)] EJERCICIOS COSIMULACIÓN
---
---

- **Universidad**: UPV-EHU.
- **Master**: Sistemas electrónicos avanzados, [[SIEAV](https://github.com/umarcor/SIEAV)].
- **Asignatura**: Cosimulación para la verificación de sistemas sobre FPGAs.
- **Alumno**: Unai S.

---
---

### Test bench:

Se muestra en simulación el procedimiento del diseño:

![Simulación 1](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/Input_data.png)

Se demuestra mediante la siguiente imagen que la comunicación sigue el protocolo **AXI-Stream**. Ya que cuando *tvalid* y *tready* están en alto el bus *tdata* varía cada periodo de reloj.

![Simulación 2](https://github.com/Unike267/Photos/blob/master/UNI-Photos/cosim/Axi_stream_communication.png)

- **NOTA:** Para realizar el test bench se reducen los tiempos del diseño con objeto de acelerar la simulación.




