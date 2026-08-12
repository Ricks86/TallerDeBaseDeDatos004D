DECLARE
TYPE Resumen_transaccion IS RECORD(
    Nombre_cliente VARCHAR2(160),
    Monto_bruto NUMBER(12,2),
    Descuento_aplicado NUMBER(12,2),
    Monto_final_pagado NUMBER(12,2),
    Estado VARCHAR2(20)
);

REC_RESUMEN Resumen_transaccion;
BEGIN

    FOR REG IN (SELECT RESERVA_ID FROM RESERVA_TEMPORAL) LOOP

        SELECT 
            MONTO_BRUTO,
            DESCUENTO,
            MONTO_FINAL,
            ESTADO
        INTO 
            REC_RESUMEN.Monto_bruto,
            REC_RESUMEN.Descuento_aplicado,
            REC_RESUMEN.Monto_final_pagado,
            REC_RESUMEN.Estado
        FROM TRANSACCION_PAGO
        WHERE RESERVA_ID = REG.RESERVA_ID;

        SELECT 
            C.nombre ||' '||C.APELLIDO
        INTO REC_RESUMEN.Nombre_cliente
        FROM CLIENTE C
        JOIN RESERVA_TEMPORAL RT ON C.CLIENTE_ID = RT.RESERVA_ID
        WHERE RT.RESERVA_ID = REG.RESERVA_ID;

        DBMS_OUTPUT.PUT_LINE('============================');
        DBMS_OUTPUT.PUT_LINE('Nombre: '||REC_RESUMEN.Nombre_cliente);
        DBMS_OUTPUT.PUT_LINE('Monto Bruto: '||REC_RESUMEN.Monto_bruto);
        DBMS_OUTPUT.PUT_LINE('Descuento aplicado: ' ||REC_RESUMEN.Descuento_aplicado);
        DBMS_OUTPUT.PUT_LINE('Monto final aplicado: '||REC_RESUMEN.Monto_final_pagado);
        DBMS_OUTPUT.PUT_LINE('Estado: '||REC_RESUMEN.Estado);
        DBMS_OUTPUT.PUT_LINE('============================');

    END LOOP;
END;

--SELECT 
--    C.nombre ||' '||C.APELLIDO AS "Nombre del Cliente",
--    TP.MONTO_BRUTO AS "Monto Bruto",
--    TP.DESCUENTO AS "Descuento aplicado",
--    TP.MONTO_FINAL AS "Monto final pagado",
--    TP.ESTADO AS "Estado del pago"
--FROM TRANSACCION_PAGO TP
--JOIN RESERVA_TEMPORAL RT ON TP.RESERVA_ID = RT.RESERVA_ID
--JOIN CLIENTE C ON RT.CLIENTE_ID = C.CLIENTE_ID;