DECLARE
TYPE Resumen_transaccion IS RECORD(
    Nombre_cliente VARCHAR2(160),
    Monto_bruto TRANSACCION_PAGO.MONTO_BRUTO%TYPE,
    Descuento_aplicado TRANSACCION_PAGO.DESCUENTO%TYPE,
    Monto_final_pagado TRANSACCION_PAGO.MONTO_FINAL%TYPE,
    Estado RESERVA_TEMPORAL.ESTADO%TYPE
);

REC_RESUMEN Resumen_transaccion;
BEGIN

SELECT 
   C.nombre ||' '||C.APELLIDO ,
   TP.MONTO_BRUTO ,
   TP.DESCUENTO ,
   TP.MONTO_FINAL ,
   RT.ESTADO 
INTO REC_RESUMEN
FROM TRANSACCION_PAGO TP
JOIN RESERVA_TEMPORAL RT ON TP.RESERVA_ID = RT.RESERVA_ID
JOIN CLIENTE C ON RT.CLIENTE_ID = C.CLIENTE_ID
WHERE C.CLIENTE_ID = 1;

        DBMS_OUTPUT.PUT_LINE('============================ E-BOLETA ==================');
        DBMS_OUTPUT.PUT_LINE('Nombre                   :'||REC_RESUMEN.Nombre_cliente);
        DBMS_OUTPUT.PUT_LINE('Monto Bruto              :'||REC_RESUMEN.Monto_bruto);
        DBMS_OUTPUT.PUT_LINE('Descuento aplicado       :' ||REC_RESUMEN.Descuento_aplicado);
        DBMS_OUTPUT.PUT_LINE('Monto final aplicado     :'||REC_RESUMEN.Monto_final_pagado);
        DBMS_OUTPUT.PUT_LINE('Estado                   :'||REC_RESUMEN.Estado);
        DBMS_OUTPUT.PUT_LINE('========================================================');

END;