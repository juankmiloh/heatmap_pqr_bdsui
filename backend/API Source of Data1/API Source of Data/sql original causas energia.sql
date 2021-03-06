SELECT SUM(M.NO_SOLICITUDES),
       M.COD_DANE,
       D.NOMBRE_DEL_DEPARTAMENTO,
       D.NOMBRE_DEL_MUNICIPIO,
       M.TIPO_TRAMITE,
       M.TIPO_RESPUESTA,
       M.AÑO,
       M.MES,
       M.TIPO_CAUSAL,
       M.COD_CAUSAL,
       M.CAUSAL,
       M.EMPRESA,
       R.ARE_ESP_NOMBRE
FROM
(
    SELECT COUNT (DISTINCT(CAR_T1548_RAD_RECIBIDO)) NO_SOLICITUDES,
          LPAD(CAR_T1548_DANE_DEPTO,2,0)|| LPAD(CAR_T1548_DANE_MPIO,3,0)||LPAD(CAR_T1548_DANE_CPOBLADO,3,0) COD_DANE,
          DECODE (CAR_T1548_TIPO_TRAMITE,1,'RECLAMACIONES',2,'QUEJA',4,'RECURSO DE REPOSICIÓN',5,'SUBSIDIARIO DE APELACIÓN') TIPO_TRAMITE,
          CAR_CARG_ANO AÑO,
          CAR_CARG_PERIODO MES,
          DECODE (CAR_T1548_CAUSAL,'F','FACTURACIÓN','I','INSTALACIÓN','P','PRESTACION')TIPO_CAUSAL,
          CAR_T1548_CAUSAL_DETALLE COD_CAUSAL,
          DECODE (CAR_T1548_RESPUESTA_TIPO,'1','ACCEDE','2','ACCEDE PARCIALMENTE','3','NO ACCEDE','4','CONFIRMA','5','MODIFICA','6','REVOCA','7','RECHAZA','8', 'TRASLADO POR COMPETENCIA','9','PENDIENTE DE RESPUESTA','10','SIN RESPUESTA','11','ARCHIVA') TIPO_RESPUESTA,
          CASE
              WHEN CAR_T1548_CAUSAL_DETALLE = 101 THEN 'INCONFORMIDAD CON EL AFORO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 102 THEN 'INCONFORMIDAD CON EL CONSUMO O PRODUCCIÓN FACTURADO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 103 THEN 'COBROS INOPORTUNOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 104 THEN 'COBROS DESCONOCIDOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 105 THEN 'COBRO POR SERVICIOS NO PRESTADOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 106 THEN 'DATOS GENERALES INCORRECTOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 107 THEN 'DATOS GENERALES INCORRECTOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 108 THEN 'ENTREGA INOPORTUNA O NO ENTREGA DE LA FACTURA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 109 THEN 'COBROS POR CONEXIÓN, RECONEXIÓN, REINSTALACIÓN'
              WHEN CAR_T1548_CAUSAL_DETALLE = 110 THEN 'COBROS DE MEDIDOR'
              WHEN CAR_T1548_CAUSAL_DETALLE = 111 THEN 'COBRO DE CARGOS RELACIONADOS CON EL SERVICIO PÚBLICO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 112 THEN 'SUBSIDIOS Y CONTRIBUCIONES'
              WHEN CAR_T1548_CAUSAL_DETALLE = 113 THEN 'COBRO DE OTROS BIENES O SERVICIOS EN LA FACTURA.'
              WHEN CAR_T1548_CAUSAL_DETALLE = 114 THEN 'DESCUENTO POR PREDIO DESOCUPADO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 115 THEN 'SUSPENSIÓN POR MUTUO ACUERDO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 117 THEN 'ESTRATO INCORRECTO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 118 THEN 'CLASE DE USO INCORRECTO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 119 THEN 'TARIFA INCORRECTA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 120 THEN 'COBROS POR PROMEDIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 121 THEN 'COBRO DE CONSUMO REGISTRADO POR MEDIDOR DE OTRO PREDIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 122 THEN 'PAGO SIN ABONO A CUENTA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 123 THEN 'SOLICITUD DE ROMPIMIENTO DE SOLIDARIDAD'
              WHEN CAR_T1548_CAUSAL_DETALLE = 124 THEN 'COBRO DE RECONEXIONES'
              WHEN CAR_T1548_CAUSAL_DETALLE = 126 THEN 'LECTURA INCORRECTA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 127 THEN 'INCONFORMIDAD POR DESVIACIÓN SIGNIFICATIVA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 128 THEN 'COBRO POR LA INSTALACIÓN DEL SERVICIO NO SOLICITADO '
              WHEN CAR_T1548_CAUSAL_DETALLE = 129 THEN 'COBRO POR CONSUMOS DEJADOS DE FACTURAR O RECUPERACIÓN DE ENERGÍA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 130 THEN 'COBRO DE ACUERDO DE PAGO O FINANCIACIÓN'
              WHEN CAR_T1548_CAUSAL_DETALLE = 131 THEN 'INCONFORMIDAD POR COBROS POR NORMALIZACIÓN DEL SERVICIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 132 THEN 'DESCUENTO POR NO RECOLECCIÓN PUERTA A PUERTA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 133 THEN 'COBRO POR RECONEXIÓN NO AUTORIZADA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 134 THEN 'INCONFORMIDAD CON EL SERVICIO A USUARIOS CICLO I'
              WHEN CAR_T1548_CAUSAL_DETALLE = 301 THEN 'NEGACIÓN DE LA SOLICITUD DE SUSPENSIÓN'
              WHEN CAR_T1548_CAUSAL_DETALLE = 302 THEN 'OPORTUNIDAD DE LAS REVISIONES'
              WHEN CAR_T1548_CAUSAL_DETALLE = 303 THEN 'FALLA EN LA PRESTACIÓN DEL SERVICIO POR CONTINUIDAD'
              WHEN CAR_T1548_CAUSAL_DETALLE = 304 THEN 'FALLA EN LA PRESTACIÓN DEL SERVICIO POR CALIDAD'
              WHEN CAR_T1548_CAUSAL_DETALLE = 305 THEN 'NEGATIVA DE PRESTACIÓN DE UN SERVICIO ESPECIAL'
              WHEN CAR_T1548_CAUSAL_DETALLE = 306 THEN 'INCONFORMIDAD EN LA ATENCIÓN DE CONDICIONES DE SEGURIDAD O RIESGO '
              WHEN CAR_T1548_CAUSAL_DETALLE = 307 THEN 'CAMBIO DE MEDIDOR O EQUIPO DE MEDIDA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 308 THEN 'TERMINACIÓN DEL CONTRATO '
              WHEN CAR_T1548_CAUSAL_DETALLE = 309 THEN 'SUSPENSIÓN O CORTE DEL SERVICIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 310 THEN 'FRECUENCIAS ADICIONALES DE BARRIDO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 311 THEN 'FRECUENCIAS ADICIONALES DE RECOLECCIÓN'
              WHEN CAR_T1548_CAUSAL_DETALLE = 312 THEN 'INCONFORMIDAD CON EL SERVICIO A USUARIOS CICLO I'
              WHEN CAR_T1548_CAUSAL_DETALLE = 313 THEN 'DAÑO A ELECTRODOMÉSTICOS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 314 THEN 'AFECTACIÓN AMBIENTAL'
              WHEN CAR_T1548_CAUSAL_DETALLE = 315 THEN 'QUEJAS ADMINISTRATIVAS'
              WHEN CAR_T1548_CAUSAL_DETALLE = 316 THEN 'ESTADO DE LAS INFRAESTRUCTURA'
              WHEN CAR_T1548_CAUSAL_DETALLE = 401 THEN 'FALLAS EN LA CONEXIÓN DEL SERVICIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 402 THEN 'NO CONEXIÓN DEL SERVICIO'
              WHEN CAR_T1548_CAUSAL_DETALLE = 403 THEN 'INSTALACIÓN DE INSTRUMENTO DE MEDIDA'
              END CAUSAL,
          IDENTIFICADOR_EMPRESA EMPRESA
    FROM SUI_SIMPLIFICA_2015.CAR_T1548_RECLAMACIONES_ENE
    WHERE CAR_CARG_ANO IN (2018)
    AND CAR_CARG_PERIODO IN (1)
    --AND IDENTIFICADOR_EMPRESA='3226'
    GROUP BY CAR_T1548_CAUSAL_DETALLE,
             CAR_T1548_DANE_DEPTO,
             CAR_T1548_DANE_MPIO,
             CAR_T1548_DANE_CPOBLADO,
             CAR_T1548_TIPO_TRAMITE,
             CAR_T1548_RESPUESTA_TIPO,
             IDENTIFICADOR_EMPRESA,
             CAR_CARG_ANO,
             CAR_CARG_PERIODO,
             CAR_T1548_CAUSAL,
             CASE
                WHEN CAR_T1548_CAUSAL_DETALLE = 101 THEN 'INCONFORMIDAD CON EL AFORO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 102 THEN 'INCONFORMIDAD CON EL CONSUMO O PRODUCCIÓN FACTURADO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 103 THEN 'COBROS INOPORTUNOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 104 THEN 'COBROS DESCONOCIDOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 105 THEN 'COBRO POR SERVICIOS NO PRESTADOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 106 THEN 'DATOS GENERALES INCORRECTOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 107 THEN 'DATOS GENERALES INCORRECTOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 108 THEN 'ENTREGA INOPORTUNA O NO ENTREGA DE LA FACTURA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 109 THEN 'COBROS POR CONEXIÓN, RECONEXIÓN, REINSTALACIÓN'
                WHEN CAR_T1548_CAUSAL_DETALLE = 110 THEN 'COBROS DE MEDIDOR'
                WHEN CAR_T1548_CAUSAL_DETALLE = 111 THEN 'COBRO DE CARGOS RELACIONADOS CON EL SERVICIO PÚBLICO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 112 THEN 'SUBSIDIOS Y CONTRIBUCIONES'
                WHEN CAR_T1548_CAUSAL_DETALLE = 113 THEN 'COBRO DE OTROS BIENES O SERVICIOS EN LA FACTURA.'
                WHEN CAR_T1548_CAUSAL_DETALLE = 114 THEN 'DESCUENTO POR PREDIO DESOCUPADO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 115 THEN 'SUSPENSIÓN POR MUTUO ACUERDO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 117 THEN 'ESTRATO INCORRECTO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 118 THEN 'CLASE DE USO INCORRECTO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 119 THEN 'TARIFA INCORRECTA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 120 THEN 'COBROS POR PROMEDIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 121 THEN 'COBRO DE CONSUMO REGISTRADO POR MEDIDOR DE OTRO PREDIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 122 THEN 'PAGO SIN ABONO A CUENTA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 123 THEN 'SOLICITUD DE ROMPIMIENTO DE SOLIDARIDAD'
                WHEN CAR_T1548_CAUSAL_DETALLE = 124 THEN 'COBRO DE RECONEXIONES'
                WHEN CAR_T1548_CAUSAL_DETALLE = 126 THEN 'LECTURA INCORRECTA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 127 THEN 'INCONFORMIDAD POR DESVIACIÓN SIGNIFICATIVA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 128 THEN 'COBRO POR LA INSTALACIÓN DEL SERVICIO NO SOLICITADO '
                WHEN CAR_T1548_CAUSAL_DETALLE = 129 THEN 'COBRO POR CONSUMOS DEJADOS DE FACTURAR O RECUPERACIÓN DE ENERGÍA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 130 THEN 'COBRO DE ACUERDO DE PAGO O FINANCIACIÓN'
                WHEN CAR_T1548_CAUSAL_DETALLE = 131 THEN 'INCONFORMIDAD POR COBROS POR NORMALIZACIÓN DEL SERVICIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 132 THEN 'DESCUENTO POR NO RECOLECCIÓN PUERTA A PUERTA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 133 THEN 'COBRO POR RECONEXIÓN NO AUTORIZADA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 134 THEN 'INCONFORMIDAD CON EL SERVICIO A USUARIOS CICLO I'
                WHEN CAR_T1548_CAUSAL_DETALLE = 301 THEN 'NEGACIÓN DE LA SOLICITUD DE SUSPENSIÓN'
                WHEN CAR_T1548_CAUSAL_DETALLE = 302 THEN 'OPORTUNIDAD DE LAS REVISIONES'
                WHEN CAR_T1548_CAUSAL_DETALLE = 303 THEN 'FALLA EN LA PRESTACIÓN DEL SERVICIO POR CONTINUIDAD'
                WHEN CAR_T1548_CAUSAL_DETALLE = 304 THEN 'FALLA EN LA PRESTACIÓN DEL SERVICIO POR CALIDAD'
                WHEN CAR_T1548_CAUSAL_DETALLE = 305 THEN 'NEGATIVA DE PRESTACIÓN DE UN SERVICIO ESPECIAL'
                WHEN CAR_T1548_CAUSAL_DETALLE = 306 THEN 'INCONFORMIDAD EN LA ATENCIÓN DE CONDICIONES DE SEGURIDAD O RIESGO '
                WHEN CAR_T1548_CAUSAL_DETALLE = 307 THEN 'CAMBIO DE MEDIDOR O EQUIPO DE MEDIDA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 308 THEN 'TERMINACIÓN DEL CONTRATO '
                WHEN CAR_T1548_CAUSAL_DETALLE = 309 THEN 'SUSPENSIÓN O CORTE DEL SERVICIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 310 THEN 'FRECUENCIAS ADICIONALES DE BARRIDO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 311 THEN 'FRECUENCIAS ADICIONALES DE RECOLECCIÓN'
                WHEN CAR_T1548_CAUSAL_DETALLE = 312 THEN 'INCONFORMIDAD CON EL SERVICIO A USUARIOS CICLO I'
                WHEN CAR_T1548_CAUSAL_DETALLE = 313 THEN 'DAÑO A ELECTRODOMÉSTICOS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 314 THEN 'AFECTACIÓN AMBIENTAL'
                WHEN CAR_T1548_CAUSAL_DETALLE = 315 THEN 'QUEJAS ADMINISTRATIVAS'
                WHEN CAR_T1548_CAUSAL_DETALLE = 316 THEN 'ESTADO DE LAS INFRAESTRUCTURA'
                WHEN CAR_T1548_CAUSAL_DETALLE = 401 THEN 'FALLAS EN LA CONEXIÓN DEL SERVICIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 402 THEN 'NO CONEXIÓN DEL SERVICIO'
                WHEN CAR_T1548_CAUSAL_DETALLE = 403 THEN 'INSTALACIÓN DE INSTRUMENTO DE MEDIDA'
                END
    ORDER BY 4,2
)M,
RUPS.ARE_ESP_EMPRESAS R,
CARG_ARCH.VM_DANE_DIVIPOLA D
WHERE M.EMPRESA = R.ARE_ESP_SECUE
--AND M.EMPRESA='1737'
AND SUBSTR(M.COD_DANE,0,2) = D.CODIGO_DEL_DEPARTAMENTO
AND SUBSTR(M.COD_DANE,3,3) = D.CODIGO_DEL_MUNICIPIO
GROUP BY M.COD_DANE,
       D.NOMBRE_DEL_DEPARTAMENTO,
       D.NOMBRE_DEL_MUNICIPIO,
       M.TIPO_TRAMITE,
       M.TIPO_RESPUESTA,
       M.AÑO,
       M.MES,
       M.COD_CAUSAL,
       M.CAUSAL,
       M.EMPRESA,
       R.ARE_ESP_NOMBRE,
       M.TIPO_CAUSAL
ORDER BY 10,6,7,5,9,2;