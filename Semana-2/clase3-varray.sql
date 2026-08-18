DECLARE
--Rellenar un VARRAY de forma no procedural (manual)--
TYPE num_asiento IS VARRAY(6) OF VARCHAR2(2);

V_asiento num_asiento := num_asiento('A1','A2','B1','B2','C1','C2');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Se a asignado el asiento N°'|| V_asiento(3));
    NULL;
END;
/
DECLARE
    TYPE RUT IS VARRAY(3) OF VARCHAR2(12);

    V_Rut RUT := RUT('21.612.825-7','21.619.740-2','12.345.678-9');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Rut número 1 es: '||V_Rut(1));
    DBMS_OUTPUT.PUT_LINE('Rut número 2 es: '||V_Rut(2));
    DBMS_OUTPUT.PUT_LINE('Rut número 3 es: '||V_Rut(3));
    NULL;
END;
/
--Ahora si procedural
DECLARE
    TYPE RUT IS VARRAY(3) OF VARCHAR2(12);

    V_Rut RUT := RUT();
BEGIN
    V_Rut.EXTEND;
    V_Rut(1):= '11.111.111-1';

    V_Rut.EXTEND;
    V_Rut(2):= '22.222.222-2';

    V_Rut.EXTEND;
    V_Rut(3):= '33.333.333-3';


    DBMS_OUTPUT.PUT_LINE('Rut número 1 es: '||V_Rut(1));
    DBMS_OUTPUT.PUT_LINE('Rut número 2 es: '||V_Rut(2));
    DBMS_OUTPUT.PUT_LINE('Rut número 3 es: '||V_Rut(3));
    NULL;
END;