USE [master]
GO
/****** Object:  Database [SSO]    Script Date: 5/13/2019 5:07:48 PM ******/
CREATE DATABASE [SSO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SSO', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\SSO.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SSO_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\SSO_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SSO] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SSO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SSO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SSO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SSO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SSO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SSO] SET ARITHABORT OFF 
GO
ALTER DATABASE [SSO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SSO] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SSO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SSO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SSO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SSO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SSO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SSO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SSO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SSO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SSO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SSO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SSO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SSO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SSO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SSO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SSO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SSO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SSO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SSO] SET  MULTI_USER 
GO
ALTER DATABASE [SSO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SSO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SSO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SSO] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SSO]
GO
/****** Object:  Table [dbo].[ApplicationInfo]    Script Date: 5/13/2019 5:07:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ApplicationInfo](
	[applicationId] [int] IDENTITY(1,1) NOT NULL,
	[applicationUrl] [varchar](200) NULL,
	[userName] [varchar](50) NULL,
	[passWord] [varchar](50) NULL,
	[des] [varchar](500) NULL,
	[icon] [varchar](50) NULL,
	[applicationName] [varchar](50) NULL,
 CONSTRAINT [PK_ApplicationInfo] PRIMARY KEY CLUSTERED 
(
	[applicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 5/13/2019 5:07:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Organization](
	[organizationId] [int] IDENTITY(1,1) NOT NULL,
	[organizationName] [varchar](50) NULL,
	[organizationDec] [varchar](50) NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_application]    Script Date: 5/13/2019 5:07:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_application](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[applicationId] [int] NULL,
 CONSTRAINT [PK_user_application] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 5/13/2019 5:07:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[OrganizationId] [int] NULL,
	[Des] [varchar](500) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ApplicationInfo] ON 

INSERT [dbo].[ApplicationInfo] ([applicationId], [applicationUrl], [userName], [passWord], [des], [icon], [applicationName]) VALUES (1, N'http://localhost:8880/EMPI/login', N'admin', N'admin', NULL, N'empi.png', N'EMPI')
INSERT [dbo].[ApplicationInfo] ([applicationId], [applicationUrl], [userName], [passWord], [des], [icon], [applicationName]) VALUES (3, N'http://tsds.stl-sdf.perkinelmercloud.net:8080/#login', N'Zhuang', N'Aa123456.', NULL, N'spotfire.jpg', N'DS')
INSERT [dbo].[ApplicationInfo] ([applicationId], [applicationUrl], [userName], [passWord], [des], [icon], [applicationName]) VALUES (4, N'http://172.26.10.52:90/spotfire/login.html', N'spotfire', N'spotfire', NULL, N'spotfire.jpg', N'Spotfire')
SET IDENTITY_INSERT [dbo].[ApplicationInfo] OFF
SET IDENTITY_INSERT [dbo].[Organization] ON 

INSERT [dbo].[Organization] ([organizationId], [organizationName], [organizationDec]) VALUES (1, N'RENJI', N'afsdfa')
SET IDENTITY_INSERT [dbo].[Organization] OFF
SET IDENTITY_INSERT [dbo].[user_application] ON 

INSERT [dbo].[user_application] ([id], [userId], [applicationId]) VALUES (3, 1, 3)
INSERT [dbo].[user_application] ([id], [userId], [applicationId]) VALUES (4, 1, 4)
SET IDENTITY_INSERT [dbo].[user_application] OFF
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([UserId], [UserName], [PassWord], [OrganizationId], [Des]) VALUES (1, N'admin', N'2f7a05538e9abc3d', 1, NULL)
INSERT [dbo].[UserInfo] ([UserId], [UserName], [PassWord], [OrganizationId], [Des]) VALUES (3, N'xiaoming', N'4832674d90ee20198d6af96f5a836de5', 1, NULL)
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
ALTER TABLE [dbo].[user_application]  WITH CHECK ADD  CONSTRAINT [FK_user_application_ApplicationInfo] FOREIGN KEY([applicationId])
REFERENCES [dbo].[ApplicationInfo] ([applicationId])
GO
ALTER TABLE [dbo].[user_application] CHECK CONSTRAINT [FK_user_application_ApplicationInfo]
GO
ALTER TABLE [dbo].[user_application]  WITH CHECK ADD  CONSTRAINT [FK_user_application_UserInfo] FOREIGN KEY([userId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
ALTER TABLE [dbo].[user_application] CHECK CONSTRAINT [FK_user_application_UserInfo]
GO
USE [master]
GO
ALTER DATABASE [SSO] SET  READ_WRITE 
GO
