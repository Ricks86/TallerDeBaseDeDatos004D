/*Cursor que devuelva el nombre del evento, nombre localidad, precio y stock disponible 
y en base al stock asigne un estado, ej: <1000 critico o >
*/
DECLARE
    CURSOR C_STOCK IS
        SELECT 
            E.nombre,
            LE.NOMBRE_LOCALIDAD,
            LE.PRECIO,
            CASE 
                WHEN LE.STOCK_DISPONIBLE = 0 THEN 'AGOTADO'
                WHEN LE.STOCK_DISPONIBLE BETWEEN 1 AND 1500 THEN 'critico'
                WHEN LE.STOCK_DISPONIBLE BETWEEN 1501 AND 5000 THEN 'BAJA DISPONIBILIDAD'
                WHEN LE.STOCK_DISPONIBLE BETWEEN 5001 AND 1000 THEN 'DISPONIBILIDAD NORMAL'
                ELSE 'ALTA DISPONIBILIDAD'
            END AS STOCK
        FROM LOCALIDAD_EVENTO LE
        JOIN EVENTO E ON LE.EVENTO_ID = E.EVENTO_ID
        WHERE E.estado = 'VENTA';

    V_STOCK C_STOCK%ROWTYPE;
BEGIN 
    OPEN C_STOCK;

    LOOP
        FETCH C_STOCK INTO V_STOCK;

        EXIT WHEN C_STOCK%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('['||V_STOCK.STOCK||'] |Nombre evento: '||V_STOCK.Nombre||' | Localidad: '||V_STOCK.NOMBRE_LOCALIDAD||' | Precio: '||V_STOCK.PRECIO);
    END LOOP;
    CLOSE C_STOCK;
END;

