SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [bds].[COM_CONTRATOS]
AS
/* usa tres tablas de RE para obtener el RUC por cada contrato
*/
SELECT
  vn.[Clave RE] AS VICNCN_ClaveRE
 ,vn.[Sociedad] AS VICNCN_sociedad
 ,vn.[Contrato] AS VICNCN_contrato
  --,vn.[Nº objeto]                as VICNCN_nroObjeto
 ,vn.[Clv.bien.inmb.] AS VICNCN_clvBienInmb
 ,vn.[Denominación de contrato] AS VICNCN_denominacionContrato
 ,vn.[Contrato anterior] AS VICNCN_contratoAnterior
 ,vn.[Moneda del contrato] AS VICNCN_monedaContrato
  --,vl.[UID: IC/Objeto]           as VIBPOBJREL_UID_ICObjeto
  --,vl.[Clave RE]                 as VIBPOBJREL_ClaveRE
  --,vl.[Interloc.comercial]       as VIBPOBJREL_Interloccomercial
  --,vl.[Función]                  as VIBPOBJREL_Función
 ,vl.[Inicio relación] AS VIBPOBJREL_Iniciorelacion
 ,vl.[Final relación] AS VIBPOBJREL_Finalrelacion
 ,ROW_NUMBER() OVER (PARTITION BY vl.[Clave RE] ORDER BY vl.[Final relación] DESC) AS VIBPOBJREL_ordInterloccomercial
  --,dm.[Interloc.comercial]       as DFKKBPTAXNUM_Interloccomercial
 ,dm.[N.I.F.] AS DFKKBPTAXNUM_NIF
FROM stg.SAPRE_VICNCN AS vn
LEFT JOIN stg.SAPRE_VIBPOBJREL AS vl
  ON vn.[Clave RE] = vl.[Clave RE]
LEFT JOIN stg.SAPRE_DFKKBPTAXNUM AS dm
  ON vl.[Interloc.comercial] = dm.[Interloc.comercial]
WHERE vl.[Función] = 'TR0600';
GO