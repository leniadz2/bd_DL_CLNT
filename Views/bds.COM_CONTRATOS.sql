SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [bds].[COM_CONTRATOS] AS
  select vn.[Clave RE]                 as VICNCN_ClaveRE
        ,vn.[Sociedad]                 as VICNCN_sociedad
        ,vn.[Contrato]                 as VICNCN_contrato
        --,vn.[Nº objeto]                as VICNCN_nroObjeto
        ,vn.[Clv.bien.inmb.]           as VICNCN_clvBienInmb
        ,vn.[Denominación de contrato] as VICNCN_denominacionContrato
        ,vn.[Contrato anterior]        as VICNCN_contratoAnterior
        ,vn.[Moneda del contrato]      as VICNCN_monedaContrato
        --,vl.[UID: IC/Objeto]           as VIBPOBJREL_UID_ICObjeto
        --,vl.[Clave RE]                 as VIBPOBJREL_ClaveRE
        --,vl.[Interloc.comercial]       as VIBPOBJREL_Interloccomercial
        --,vl.[Función]                  as VIBPOBJREL_Función
        ,vl.[Inicio relación]          as VIBPOBJREL_Iniciorelacion
        ,vl.[Final relación]           as VIBPOBJREL_Finalrelacion
        --,dm.[Interloc.comercial]       as DFKKBPTAXNUM_Interloccomercial
        ,dm.[N.I.F.]                   as DFKKBPTAXNUM_NIF
   from stg.SAPRE_VICNCN as vn 
          left join stg.SAPRE_VIBPOBJREL as vl
            on vn.[Clave RE] = vl.[Clave RE]
          left join stg.SAPRE_DFKKBPTAXNUM as dm
            on vl.[Interloc.comercial] = dm.[Interloc.comercial]
    where vl.[Función] = 'TR0600';
GO