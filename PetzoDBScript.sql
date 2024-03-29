USE [master]
GO
/****** Object:  Database [PetzoDB]    Script Date: 11/23/2019 5:50:03 PM ******/
CREATE DATABASE [PetzoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PetzoDB', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PetzoDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PetzoDB_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PetzoDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PetzoDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PetzoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PetzoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PetzoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PetzoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PetzoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PetzoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PetzoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PetzoDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PetzoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PetzoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PetzoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PetzoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PetzoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PetzoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PetzoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PetzoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PetzoDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PetzoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PetzoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PetzoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PetzoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PetzoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PetzoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PetzoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PetzoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PetzoDB] SET  MULTI_USER 
GO
ALTER DATABASE [PetzoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PetzoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PetzoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PetzoDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PetzoDB', N'ON'
GO
USE [PetzoDB]
GO
/****** Object:  StoredProcedure [dbo].[spSearchProviderDetails]    Script Date: 11/23/2019 5:50:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC spSearchProviderDetails 'Doctor', 'Delhi'
CREATE PROCEDURE [dbo].[spSearchProviderDetails]
	@ProviderType varchar(50) = NULL, 
	@City varchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
    SELECT pd.ProviderDetailId, pd.FirstName, pd.LastName, pd.Qualification, pd.City, pd.CellPhone, 
		   pd.Email, p.ProviderType
		FROM ProviderDetails pd
			INNER JOIN ProviderMaster p
				ON pd.ProviderId = p.ProviderId
		WHERE p.ProviderType = ISNULL (@ProviderType, p.ProviderType)
				AND pd.City = ISNULL (@City, pd.City)
END

GO
/****** Object:  Table [dbo].[ProviderDetails]    Script Date: 11/23/2019 5:50:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProviderDetails](
	[ProviderDetailId] [bigint] NOT NULL,
	[ProviderId] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[CellPhone] [varchar](50) NULL,
	[Email] [varchar](70) NULL,
	[Experience] [int] NULL,
	[City] [varchar](50) NULL,
	[Qualification] [varchar](50) NULL,
 CONSTRAINT [PK_ProviderDetails] PRIMARY KEY CLUSTERED 
(
	[ProviderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProviderMaster]    Script Date: 11/23/2019 5:50:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProviderMaster](
	[ProviderId] [int] NOT NULL,
	[ProviderType] [varchar](50) NULL,
	[ProviderStatus] [char](1) NULL,
 CONSTRAINT [PK_ProviderMaster] PRIMARY KEY CLUSTERED 
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ProviderDetails] ([ProviderDetailId], [ProviderId], [FirstName], [MiddleName], [LastName], [CellPhone], [Email], [Experience], [City], [Qualification]) VALUES (1, 1, N'Ashish', NULL, N'Srivastava', N'9911962406', N'ashi.srivastava@gmail.com', 12, N'Delhi', N'MBBS, MS')
INSERT [dbo].[ProviderDetails] ([ProviderDetailId], [ProviderId], [FirstName], [MiddleName], [LastName], [CellPhone], [Email], [Experience], [City], [Qualification]) VALUES (2, 1, N'Abhishek', N'Kumar', N'Rai', N'9867542380', N'abhi@yahoo.co.in', 5, N'Delhi', N'BAMS')
INSERT [dbo].[ProviderDetails] ([ProviderDetailId], [ProviderId], [FirstName], [MiddleName], [LastName], [CellPhone], [Email], [Experience], [City], [Qualification]) VALUES (3, 2, N'Abdul', NULL, N'Nazeer', N'5678903456', N'abdul.nazeer@rediffmail.com', 7, N'Meerut', N'Diploma in Pet''s Hair Cut')
INSERT [dbo].[ProviderDetails] ([ProviderDetailId], [ProviderId], [FirstName], [MiddleName], [LastName], [CellPhone], [Email], [Experience], [City], [Qualification]) VALUES (4, 1, N'Mike', NULL, N'Will', N'8876542903', N'mike@hotmail.com', 10, N'Lucknow', N'BDS')
INSERT [dbo].[ProviderMaster] ([ProviderId], [ProviderType], [ProviderStatus]) VALUES (1, N'Doctor', N'A')
INSERT [dbo].[ProviderMaster] ([ProviderId], [ProviderType], [ProviderStatus]) VALUES (2, N'Saloon', N'A')
INSERT [dbo].[ProviderMaster] ([ProviderId], [ProviderType], [ProviderStatus]) VALUES (3, N'Breeder', N'A')
ALTER TABLE [dbo].[ProviderDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProviderDetails_ProviderId] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[ProviderMaster] ([ProviderId])
GO
ALTER TABLE [dbo].[ProviderDetails] CHECK CONSTRAINT [FK_ProviderDetails_ProviderId]
GO
USE [master]
GO
ALTER DATABASE [PetzoDB] SET  READ_WRITE 
GO
