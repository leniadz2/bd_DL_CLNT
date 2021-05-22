CREATE TABLE [stg].[MKT_CLI] (
  [DocumentoIdentificacion] [varchar](20) NULL,
  [NombreCompleto] [varchar](150) NULL,
  [Nombre] [varchar](50) NULL,
  [Apellidos] [varchar](50) NULL,
  [FechaNacimiento] [date] NULL,
  [Sexo] [varchar](150) NULL,
  [Correo] [varchar](150) NULL,
  [Telefono] [varchar](20) NULL,
  [Distrito] [varchar](80) NULL,
  [Direccion] [varchar](150) NULL,
  [NivelSocioEconomico] [varchar](10) NULL,
  [CentroComercial] [varchar](150) NULL,
  [CategoriaInteres] [varchar](150) NULL,
  [TipoInformacionRecibe] [varchar](150) NULL,
  [EDAD] [int] NULL
)
ON [PRIMARY]
GO