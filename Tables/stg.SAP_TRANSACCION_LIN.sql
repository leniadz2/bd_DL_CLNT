﻿CREATE TABLE [stg].[SAP_TRANSACCION_LIN] (
  [FACTURA] [int] NULL,
  [POSICION] [int] NULL,
  [CANTIDAD] [int] NULL,
  [UNIDADVENTA] [varchar](50) NULL,
  [UNIDADBASE] [varchar](50) NULL,
  [PESONETO] [float] NULL,
  [PESOBRUTO] [float] NULL,
  [UNIDADPESO] [varchar](50) NULL,
  [VOLUMEN] [float] NULL,
  [VALORNETO] [float] NULL,
  [DOCUMENTOMODELO] [float] NULL,
  [POSICIONMODELO] [int] NULL,
  [TIPODOCANTERIOR] [varchar](50) NULL,
  [DOCUMENTOVENTAS] [float] NULL,
  [POSICION1] [int] NULL,
  [MATERIAL] [float] NULL,
  [DENOMINACION] [varchar](50) NULL,
  [GRUPOARTICULOS] [varchar](50) NULL,
  [BASEDESCUENTO] [float] NULL,
  [GRUPOMATERIAL] [int] NULL,
  [FECHACRECION] [datetime2] NULL,
  [HORA] [datetime2] NULL,
  [SUBTOTAL1] [float] NULL,
  [SUBTOTAL2] [float] NULL,
  [SUBTOTAL3] [float] NULL,
  [SUBTOTAL4] [float] NULL,
  [SUBTOTAL5] [float] NULL,
  [SUBTOTAL6] [float] NULL,
  [CENTROBENEFICIOS] [varchar](50) NULL,
  [MATERIALINTRODUCIDO] [float] NULL,
  [NROOBJETOPA] [int] NULL,
  [ORGVENTASPEDIDO] [int] NULL,
  [TIPODOCCOMERCIAL] [varchar](50) NULL,
  [IMPORTEIMPUESTO] [float] NULL,
  [VALORBRUTO] [float] NULL
)
ON [PRIMARY]
GO