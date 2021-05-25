SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [tmp].[sp_carga_cruce_SRV]
AS
BEGIN

  DECLARE @strgfini NVARCHAR(8);
  DECLARE @strgffin NVARCHAR(8);
  DECLARE @datefini DATE;
  DECLARE @dateffin DATE;

  SET DATEFIRST 1;

  SET @strgfini = '20210501';
  SET @strgffin = '20210502';

  SET @datefini = CONVERT(DATE, CONCAT(SUBSTRING(@strgfini, 1, 4), '-', SUBSTRING(@strgfini, 5, 2), '-', SUBSTRING(@strgfini, 7, 2)));
  SET @dateffin = CONVERT(DATE, CONCAT(SUBSTRING(@strgffin, 1, 4), '-', SUBSTRING(@strgffin, 5, 2), '-', SUBSTRING(@strgffin, 7, 2)));

  DROP TABLE tmp.t_cruce_srv_1;
  DROP TABLE tmp.t_cruce_srv_2;
  DROP TABLE tmp.t_cruce_srv_3;


/* error cuando se uso srv tablon
  select
        concat(substring(fecha,1,4),substring(fecha,6,2),substring(fecha,9,2)) as FECHA,
        case 
        when CODIGOMALL = '01' then '3001CC'
        when CODIGOMALL = '02' then '4007CC'
        end as UE,
        RUCEMISOR AS RUC,
        RAZONSOCIAL AS RAZON_SOCIAL,
        NOMBRE AS NOMBRE_COMERCIAL,
        MONEDA,
        convert(float,TOTALVALORVENTANETA) AS MONTO
        ,ID,ORDENITEM
   into ods.t_cruce_srv_1
   from stg.TABLON_SRV;
*/

  SELECT CONCAT(SUBSTRING(fecha, 1, 4), SUBSTRING(fecha, 6, 2), SUBSTRING(fecha, 9, 2)) AS FECHA
        ,CASE
           WHEN CODIGOMALL = '01' THEN '3001CC'
           WHEN CODIGOMALL = '02' THEN '4007CC'
         END AS UE
        ,RUCEMISOR AS RUC
        ,SupPartyRegName AS RAZON_SOCIAL
        ,SupPartyName AS NOMBRE_COMERCIAL
        ,MONEDA
        ,CONVERT(FLOAT, TOTALVALORVENTANETA) AS MONTO
        ,ID
        ,ORDEN 
    INTO tmp.t_cruce_srv_1
    FROM BD_SRV.tmp.[20210514_cew_data]    --bd_srv.dwh.cew_data
    --WHERE fecha >= @datefini
  ;

  SELECT FECHA
        ,UE
        ,RUC
        ,RAZON_SOCIAL
        ,NOMBRE_COMERCIAL
        ,MONEDA
        ,ID
        ,MAX(MONTO) AS MONTO 
   INTO tmp.t_cruce_srv_2
   FROM tmp.t_cruce_srv_1
  GROUP BY FECHA
          ,UE
          ,RUC
          ,RAZON_SOCIAL
          ,NOMBRE_COMERCIAL
          ,MONEDA
          ,ID
  ORDER BY FECHA, UE, RUC, RAZON_SOCIAL, NOMBRE_COMERCIAL, MONEDA, ID;

  SELECT FECHA
        ,UE
        ,RUC
        ,RAZON_SOCIAL
        ,NOMBRE_COMERCIAL
        ,MONEDA
        ,SUM(MONTO) AS MONTO
        ,COUNT(ID) AS TRX 
   INTO tmp.t_cruce_srv_3
   FROM tmp.t_cruce_srv_2
  GROUP BY FECHA
          ,UE
          ,RUC
          ,RAZON_SOCIAL
          ,NOMBRE_COMERCIAL
          ,MONEDA
  ORDER BY FECHA, UE, RUC, RAZON_SOCIAL, NOMBRE_COMERCIAL, MONEDA;


END
GO