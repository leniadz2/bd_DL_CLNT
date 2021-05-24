SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [tmp].[sp_carga_cruce_PORTAL]
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

  DROP TABLE tmp.t_cruce_portal_1;

  --dbo.datastore$ es el CSV de PORTAL

  --insert de tipo append?
  /*
  INSERT INTO stg.REPORTE_PORTAL
  SELECT
  	[Centro Comercial]  ,
  	[Moneda]            ,
  	[Fecha Inicio]      ,
  	[Fecha Fin]         ,
  	[Contrato]          ,
  	[Ruc]               ,
  	[Razón Social]      ,
  	[Nombre Comercial]  ,
  	[Unidad Económica]  ,
  	[Locales]           ,
  	[dia]               ,
      CONVERT(FLOAT, [monto]),
      CONVERT(INT, [trx#1])
  FROM dbo.datastore$;
  */
  
  --cruce portal
  select concat(year(fechainicio),RIGHT(100+month(fechainicio),2),dia) as FECHA,
         UNIDAD_ECONOMICA AS UE,
         --CONTRATO,
         RUC,
         RAZON_SOCIAL,
         NOMBRE_COMERCIAL,
         case 
           when MONEDA = 'SOLES' then 'PEN'
           when MONEDA = 'DÓLARES' then 'USD'
         end as MONEDA,
         MONTO,
         TRX
    into tmp.t_cruce_portal_1
    from tmp.REPORTE_PORTAL;

END
GO